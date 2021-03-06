/************************************************************
 * Copyright (c) 2010 paperlocator.org - all rights reserved.
 * 
 * $Id$ 
 * $Revision$ 
 * $Author$
 ***********************************************************/
package org.js.model.rbac;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;
import java.util.TreeSet;

import org.eclipse.emf.common.util.EList;
import org.eclipse.emf.ecore.EObject;
import org.eclipse.emf.ecore.util.EcoreUtil;
import org.js.model.feature.Attribute;
import org.js.model.feature.Feature;

/**
 * Access information from the RBAC model.
 * 
 * @author <a href="mailto:julia.schroeter@tu-dresden.de">Julia Schroeter</a>
 * 
 */
public class RBACService {

   // default constructor
   public RBACService() {}

   public Set<Permission> getAllRolePermissions(Role role) {
      Set<Permission> permissionSet = new TreeSet<Permission>(new PermissionComparator());
      Set<Permission> permissions = new HashSet<Permission>();
      getAllRolePermissionsRecursively(role, permissions);
      synchronized (this) {
         permissionSet.addAll(permissions);
      }
      return permissionSet;
   }

   private void getAllRolePermissionsRecursively(Role role, Set<Permission> permissions) {
      permissions.addAll(role.getPermissions());
      EList<Role> parentRoles = role.getParentRoles();
      for (Role parentRole : parentRoles) {
         getAllRolePermissionsRecursively(parentRole, permissions);
      }
   }

//   /**
//    * returns all permissions defined in the hierarchically referenced access control models.
//    * 
//    * @param model
//    * @return
//    */
//   public List<Permission> getAllModelPermissions(AccessControlModel model) {
//      List<Permission> result = new ArrayList<Permission>();
//      result.addAll(model.getPermissions());
//      EList<AccessControlModel> accessControlModels = model.getAccessControlModels();
//      for (AccessControlModel accessControlModel : accessControlModels) {
//         result.addAll(accessControlModel.getPermissions());
//      }
//      return result;
//   }

   /**
    * get a subject's direct and indirect roles.
    * 
    * @param subject
    * @return
    */
   public List<Role> getSubjectRoles(Subject subject) {
      List<Role> allRoles = new ArrayList<>();
      EList<Role> roles = subject.getRoles();
      allRoles.addAll(roles);
      for (Role role : roles) {
         List<Role> parentRoles = getParentRoles(role);
         for (Role parent : parentRoles) {
            if (!allRoles.contains(parent)) {
               allRoles.add(parent);
            }
         }
      }
      return allRoles;
   }

   private void findParentRoles(Role role, List<Role> roles) {
      EList<Role> parents = role.getParentRoles();
      for (Role parent : parents) {
         if (!roles.contains(parent)) {
            roles.add(parent);
            findParentRoles(parent, roles);
         }
      }
   }

   private void findChildRoles(Role role, List<Role> roles) {
      EList<Role> children = role.getChildRoles();
      for (Role child : children) {
         if (!roles.contains(child)) {
            roles.add(child);
            findChildRoles(child, roles);
         }
      }
   }

   /**
    * get a role's directly assigned subjects.
    * 
    * @param role
    * @return
    */
   public List<Subject> getRoleDirectSubjects(Role role) {
      EList<Subject> subjects = role.getSubjects();
      return subjects;
   }

   /**
    * get all the roles that are direct and indirect children of the specified role.
    * 
    * @param role
    * @return
    */
   public List<Role> getChildRoles(Role role) {
      List<Role> children = new ArrayList<Role>();
      findChildRoles(role, children);
      return children;
   }

   /**
    * get all the roles that are directly and indirectly assigned parents of the specified role.
    * 
    * @param role
    * @return
    */
   public List<Role> getParentRoles(Role role) {
      List<Role> parents = new ArrayList<Role>();
      findParentRoles(role, parents);
      return parents;
   }

   public FeatureOperation getSelectFeaturePermission(Feature feature, List<Permission> permissions) {
      FeatureOperation result = null;
      for (Permission permission : permissions) {
         if (permission instanceof FeatureOperation) {
            FeatureOperation operation = (FeatureOperation) permission;
            if (ConfigurationType.SELECT.equals(operation.getType())) {
               Feature permFeature = operation.getFeature();
               if (EcoreUtil.equals(feature, permFeature)) {
                  result = operation;
               }
            }
         }
      }
      return result;
   }

   public FeatureOperation getDeselectFeaturePermission(Feature feature, List<Permission> permissions) {
      FeatureOperation result = null;
      for (Permission permission : permissions) {
         if (permission instanceof FeatureOperation) {
            FeatureOperation operation = (FeatureOperation) permission;
            if (ConfigurationType.DESELECT.equals(operation.getType())) {
               Feature permFeature = operation.getFeature();
               if (EcoreUtil.equals(feature, permFeature)) {
                  result = operation;
               }
            }
         }
      }
      return result;
   }

   public AttributeOperation getSetAttributePermission(Attribute attribute, List<Permission> permissions) {
      AttributeOperation result = null;
      for (Permission permission : permissions) {
         if (permission instanceof AttributeOperation) {
            AttributeOperation setAttribute = (AttributeOperation) permission;
            Attribute permAttribute = setAttribute.getAttribute();
            if (EcoreUtil.equals(attribute, permAttribute)) {
               result = setAttribute;
            }
         }
      }
      return result;
   }

   public List<Group> getOwnedGroups(Role role) {
      AccessControlModel accessControlModel = getAccessControlModel(role);
      List<Group> roleGroups = new ArrayList<Group>(1);
      if (accessControlModel != null) {
         EList<Group> groups = accessControlModel.getGroups();
         for (Group group : groups) {
            Role represents = group.getOwner();
            if (EcoreUtil.equals(role, represents)) {
               roleGroups.add(group);
            }
         }

      }
      return roleGroups;
   }

   public AccessControlModel getAccessControlModel(EObject object) {
      AccessControlModel model = null;
      EObject rootContainer = EcoreUtil.getRootContainer(object);
      if (rootContainer instanceof AccessControlModel) {
         model = (AccessControlModel) rootContainer;
      }
      return model;
   }

}
