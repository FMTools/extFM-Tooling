package org.js.model.rbac;

import java.util.ArrayList;
import java.util.List;

import org.eclipse.emf.common.util.EList;
import org.eclipse.emf.common.util.TreeIterator;
import org.eclipse.emf.ecore.EObject;
import org.js.model.feature.Attribute;
import org.js.model.feature.DiscreteDomain;
import org.js.model.feature.Domain;
import org.js.model.feature.DomainValue;
import org.js.model.feature.Feature;
import org.js.model.feature.FeatureModel;

public class PermissionInitialization {

   private AccessControlModel model;
   private List<Permission> allModelPermissions;
   private RBACService rbacService;

   public PermissionInitialization(AccessControlModel model) {
      this.model = model;
      this.rbacService = new RBACService();
      this.allModelPermissions = rbacService.getAllModelPermissions(model);
   }

   public void initPermissions() {
      EList<FeatureModel> featureModels = model.getFeatureModels();
      for (FeatureModel featureModel : featureModels) {
         Feature root = featureModel.getRoot();
         addSelectRootFeaturePermission(root);
         TreeIterator<EObject> treeIterator = root.eAllContents();
         while (treeIterator.hasNext()) {
            EObject eObject = (EObject) treeIterator.next();
            createPermissions(eObject);
         }
      }
   }

   private void addSelectRootFeaturePermission(Feature root) {
      SelectFeature rootPermission = rbacService.getSelectFeaturePermission(root, allModelPermissions);
      if (rootPermission == null) {
         SelectFeature selectFeature = RbacHelper.createSelectFeature(root);
         EList<Permission> permissions = model.getPermissions();
         permissions.add(selectFeature);
      }
   }

   private void createPermissions(EObject eObject) {
      if (eObject instanceof Feature) {
         Feature feature = (Feature) eObject;
         createFeaturePermissions(feature);
      } else if (eObject instanceof Attribute) {
         Attribute attribute = (Attribute) eObject;
         createAttributePermissions(attribute);
      }
   }

   private void createAttributePermissions(Attribute attribute) {
      SetAttribute permission = rbacService.getSetAttributePermission(attribute, allModelPermissions);
      if (permission == null) {
         Feature feature = attribute.getFeature();
         permission = RbacHelper.createSetAttribute(feature, attribute);
         EList<Permission> permissions = model.getPermissions();
         permissions.add(permission);
      }
      Domain domain = attribute.getDomain();
      createDomainPermissions(permission, domain);
   }

   private void createDomainPermissions(SetAttribute setAttribute, Domain domain) {
      EList<AttributeDecision> domainValueOperations = setAttribute.getAttributeDecisions();
      if (domain instanceof DiscreteDomain) {
         DiscreteDomain discreteDomain = (DiscreteDomain) domain;
         List<AttributeDecision> discreteDomainPermissions = createDiscreteDomainPermissions(discreteDomain);
         domainValueOperations.addAll(discreteDomainPermissions);
      }
   }

   private List<AttributeDecision> createDiscreteDomainPermissions(DiscreteDomain domain) {
      EList<DomainValue> domainValues = domain.getValues();
      List<AttributeDecision> operations = new ArrayList<AttributeDecision>(domainValues.size() * 2);
      for (DomainValue value : domainValues) {
         SelectDomainValue selectDomainValue = createSelectDomainValueOperation(value);
         operations.add(selectDomainValue);
         DeselectDomainValue deselectDomainValue = createDeselectDomainValueOperation(value);
         operations.add(deselectDomainValue);
      }
      return operations;
   }

   private DeselectDomainValue createDeselectDomainValueOperation(DomainValue value) {
      DeselectDomainValue deselectDomainValue = RbacHelper.createDeselectDomainValue(value);
      return deselectDomainValue;
   }

   private SelectDomainValue createSelectDomainValueOperation(DomainValue value) {
      SelectDomainValue selectDomainValue = RbacHelper.createSelectDomainValue(value);
      return selectDomainValue;
   }

   private void createFeaturePermissions(Feature feature) {
      SelectFeature permission = rbacService.getSelectFeaturePermission(feature, allModelPermissions);
      EList<Permission> permissions = model.getPermissions();
      if (permission == null) {
         SelectFeature selectFeature = RbacHelper.createSelectFeature(feature);
         permissions.add(selectFeature);
      }
      DeselectFeature deselectPermission = rbacService.getDeselectFeaturePermission(feature, allModelPermissions);
      if (deselectPermission == null) {
         DeselectFeature deselectFeature = RbacHelper.createDeselectFeature(feature);
         permissions.add(deselectFeature);
      }
   }

}
