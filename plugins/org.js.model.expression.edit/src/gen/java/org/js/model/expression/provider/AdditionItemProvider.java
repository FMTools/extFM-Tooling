/**
 */
package org.js.model.expression.provider;


import java.util.Collection;
import java.util.List;

import org.eclipse.emf.common.notify.AdapterFactory;
import org.eclipse.emf.common.notify.Notification;

import org.eclipse.emf.common.util.ResourceLocator;

import org.eclipse.emf.edit.provider.IEditingDomainItemProvider;
import org.eclipse.emf.edit.provider.IItemLabelProvider;
import org.eclipse.emf.edit.provider.IItemPropertyDescriptor;
import org.eclipse.emf.edit.provider.IItemPropertySource;
import org.eclipse.emf.edit.provider.IStructuredItemContentProvider;
import org.eclipse.emf.edit.provider.ITreeItemContentProvider;

import org.js.model.expression.expressionFactory;

import org.js.model.feature.FeaturePackage;

import org.js.model.feature.provider.BinaryExpressionItemProvider;

/**
 * This is the item provider adapter for a {@link org.js.model.expression.Addition} object.
 * <!-- begin-user-doc -->
 * <!-- end-user-doc -->
 * @generated
 */
public class AdditionItemProvider
   extends BinaryExpressionItemProvider
   implements
      IEditingDomainItemProvider,
      IStructuredItemContentProvider,
      ITreeItemContentProvider,
      IItemLabelProvider,
      IItemPropertySource {
   /**
    * This constructs an instance from a factory and a notifier.
    * <!-- begin-user-doc -->
    * <!-- end-user-doc -->
    * @generated
    */
   public AdditionItemProvider(AdapterFactory adapterFactory) {
      super(adapterFactory);
   }

   /**
    * This returns the property descriptors for the adapted class.
    * <!-- begin-user-doc -->
    * <!-- end-user-doc -->
    * @generated
    */
   @Override
   public List<IItemPropertyDescriptor> getPropertyDescriptors(Object object) {
      if (itemPropertyDescriptors == null) {
         super.getPropertyDescriptors(object);

      }
      return itemPropertyDescriptors;
   }

   /**
    * This returns Addition.gif.
    * <!-- begin-user-doc -->
    * <!-- end-user-doc -->
    * @generated
    */
   @Override
   public Object getImage(Object object) {
      return overlayImage(object, getResourceLocator().getImage("full/obj16/Addition"));
   }

   /**
    * This returns the label text for the adapted class.
    * <!-- begin-user-doc -->
    * <!-- end-user-doc -->
    * @generated
    */
   @Override
   public String getText(Object object) {
      return getString("_UI_Addition_type");
   }

   /**
    * This handles model notifications by calling {@link #updateChildren} to update any cached
    * children and by creating a viewer notification, which it passes to {@link #fireNotifyChanged}.
    * <!-- begin-user-doc -->
    * <!-- end-user-doc -->
    * @generated
    */
   @Override
   public void notifyChanged(Notification notification) {
      updateChildren(notification);
      super.notifyChanged(notification);
   }

   /**
    * This adds {@link org.eclipse.emf.edit.command.CommandParameter}s describing the children
    * that can be created under this object.
    * <!-- begin-user-doc -->
    * <!-- end-user-doc -->
    * @generated
    */
   @Override
   protected void collectNewChildDescriptors(Collection<Object> newChildDescriptors, Object object) {
      super.collectNewChildDescriptors(newChildDescriptors, object);

      newChildDescriptors.add
         (createChildParameter
            (FeaturePackage.Literals.BINARY_EXPRESSION__OPERAND1,
             expressionFactory.eINSTANCE.createFeatureAttributeReference()));

      newChildDescriptors.add
         (createChildParameter
            (FeaturePackage.Literals.BINARY_EXPRESSION__OPERAND1,
             expressionFactory.eINSTANCE.createFeatureAttributeValue()));

      newChildDescriptors.add
         (createChildParameter
            (FeaturePackage.Literals.BINARY_EXPRESSION__OPERAND1,
             expressionFactory.eINSTANCE.createAddition()));

      newChildDescriptors.add
         (createChildParameter
            (FeaturePackage.Literals.BINARY_EXPRESSION__OPERAND1,
             expressionFactory.eINSTANCE.createSubtraction()));

      newChildDescriptors.add
         (createChildParameter
            (FeaturePackage.Literals.BINARY_EXPRESSION__OPERAND1,
             expressionFactory.eINSTANCE.createMultiplication()));

      newChildDescriptors.add
         (createChildParameter
            (FeaturePackage.Literals.BINARY_EXPRESSION__OPERAND1,
             expressionFactory.eINSTANCE.createDivision()));

      newChildDescriptors.add
         (createChildParameter
            (FeaturePackage.Literals.BINARY_EXPRESSION__OPERAND1,
             expressionFactory.eINSTANCE.createFeatureReference()));

      newChildDescriptors.add
         (createChildParameter
            (FeaturePackage.Literals.BINARY_EXPRESSION__OPERAND2,
             expressionFactory.eINSTANCE.createFeatureAttributeReference()));

      newChildDescriptors.add
         (createChildParameter
            (FeaturePackage.Literals.BINARY_EXPRESSION__OPERAND2,
             expressionFactory.eINSTANCE.createFeatureAttributeValue()));

      newChildDescriptors.add
         (createChildParameter
            (FeaturePackage.Literals.BINARY_EXPRESSION__OPERAND2,
             expressionFactory.eINSTANCE.createAddition()));

      newChildDescriptors.add
         (createChildParameter
            (FeaturePackage.Literals.BINARY_EXPRESSION__OPERAND2,
             expressionFactory.eINSTANCE.createSubtraction()));

      newChildDescriptors.add
         (createChildParameter
            (FeaturePackage.Literals.BINARY_EXPRESSION__OPERAND2,
             expressionFactory.eINSTANCE.createMultiplication()));

      newChildDescriptors.add
         (createChildParameter
            (FeaturePackage.Literals.BINARY_EXPRESSION__OPERAND2,
             expressionFactory.eINSTANCE.createDivision()));

      newChildDescriptors.add
         (createChildParameter
            (FeaturePackage.Literals.BINARY_EXPRESSION__OPERAND2,
             expressionFactory.eINSTANCE.createFeatureReference()));
   }

   /**
    * This returns the label text for {@link org.eclipse.emf.edit.command.CreateChildCommand}.
    * <!-- begin-user-doc -->
    * <!-- end-user-doc -->
    * @generated
    */
   @Override
   public String getCreateChildText(Object owner, Object feature, Object child, Collection<?> selection) {
      Object childFeature = feature;
      Object childObject = child;

      boolean qualify =
         childFeature == FeaturePackage.Literals.BINARY_EXPRESSION__OPERAND1 ||
         childFeature == FeaturePackage.Literals.BINARY_EXPRESSION__OPERAND2;

      if (qualify) {
         return getString
            ("_UI_CreateChild_text2",
             new Object[] { getTypeText(childObject), getFeatureText(childFeature), getTypeText(owner) });
      }
      return super.getCreateChildText(owner, feature, child, selection);
   }

   /**
    * Return the resource locator for this item provider's resources.
    * <!-- begin-user-doc -->
    * <!-- end-user-doc -->
    * @generated
    */
   @Override
   public ResourceLocator getResourceLocator() {
      return expressionEditPlugin.INSTANCE;
   }

}