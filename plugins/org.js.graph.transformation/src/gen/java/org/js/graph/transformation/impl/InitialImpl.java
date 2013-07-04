/**
 */
package org.js.graph.transformation.impl;

import java.util.Collection;

import org.eclipse.emf.common.notify.Notification;
import org.eclipse.emf.common.notify.NotificationChain;

import org.eclipse.emf.common.util.EList;

import org.eclipse.emf.ecore.EClass;
import org.eclipse.emf.ecore.InternalEObject;

import org.eclipse.emf.ecore.impl.ENotificationImpl;
import org.eclipse.emf.ecore.impl.MinimalEObjectImpl;

import org.eclipse.emf.ecore.util.EObjectWithInverseResolvingEList;
import org.eclipse.emf.ecore.util.InternalEList;

import org.js.graph.transformation.Edge;
import org.js.graph.transformation.Initial;
import org.js.graph.transformation.TransformationPackage;

/**
 * <!-- begin-user-doc -->
 * An implementation of the model object '<em><b>Initial</b></em>'.
 * <!-- end-user-doc -->
 * <p>
 * The following features are implemented:
 * <ul>
 *   <li>{@link org.js.graph.transformation.impl.InitialImpl#getName <em>Name</em>}</li>
 *   <li>{@link org.js.graph.transformation.impl.InitialImpl#getIn <em>In</em>}</li>
 *   <li>{@link org.js.graph.transformation.impl.InitialImpl#getOut <em>Out</em>}</li>
 * </ul>
 * </p>
 *
 * @generated
 */
public class InitialImpl extends MinimalEObjectImpl.Container implements Initial {
	/**
    * The default value of the '{@link #getName() <em>Name</em>}' attribute.
    * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
    * @see #getName()
    * @generated
    * @ordered
    */
	protected static final String NAME_EDEFAULT = "";

	/**
    * The cached value of the '{@link #getName() <em>Name</em>}' attribute.
    * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
    * @see #getName()
    * @generated
    * @ordered
    */
	protected String name = NAME_EDEFAULT;

	/**
    * The cached value of the '{@link #getIn() <em>In</em>}' reference list.
    * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
    * @see #getIn()
    * @generated
    * @ordered
    */
	protected EList<Edge> in;

	/**
    * The cached value of the '{@link #getOut() <em>Out</em>}' reference list.
    * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
    * @see #getOut()
    * @generated
    * @ordered
    */
	protected EList<Edge> out;

	/**
    * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
    * @generated
    */
	protected InitialImpl() {
      super();
   }

	/**
    * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
    * @generated
    */
	@Override
	protected EClass eStaticClass() {
      return TransformationPackage.Literals.INITIAL;
   }

	/**
    * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
    * @generated
    */
	public String getName() {
      return name;
   }

	/**
    * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
    * @generated
    */
	public void setName(String newName) {
      String oldName = name;
      name = newName;
      if (eNotificationRequired())
         eNotify(new ENotificationImpl(this, Notification.SET, TransformationPackage.INITIAL__NAME, oldName, name));
   }

	/**
    * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
    * @generated
    */
	public EList<Edge> getIn() {
      if (in == null) {
         in = new EObjectWithInverseResolvingEList<Edge>(Edge.class, this, TransformationPackage.INITIAL__IN, TransformationPackage.EDGE__TARGET);
      }
      return in;
   }

	/**
    * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
    * @generated
    */
	public EList<Edge> getOut() {
      if (out == null) {
         out = new EObjectWithInverseResolvingEList<Edge>(Edge.class, this, TransformationPackage.INITIAL__OUT, TransformationPackage.EDGE__SOURCE);
      }
      return out;
   }

	/**
    * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
    * @generated
    */
	@SuppressWarnings("unchecked")
	@Override
	public NotificationChain eInverseAdd(InternalEObject otherEnd, int featureID, NotificationChain msgs) {
      switch (featureID) {
         case TransformationPackage.INITIAL__IN:
            return ((InternalEList<InternalEObject>)(InternalEList<?>)getIn()).basicAdd(otherEnd, msgs);
         case TransformationPackage.INITIAL__OUT:
            return ((InternalEList<InternalEObject>)(InternalEList<?>)getOut()).basicAdd(otherEnd, msgs);
      }
      return super.eInverseAdd(otherEnd, featureID, msgs);
   }

	/**
    * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
    * @generated
    */
	@Override
	public NotificationChain eInverseRemove(InternalEObject otherEnd, int featureID, NotificationChain msgs) {
      switch (featureID) {
         case TransformationPackage.INITIAL__IN:
            return ((InternalEList<?>)getIn()).basicRemove(otherEnd, msgs);
         case TransformationPackage.INITIAL__OUT:
            return ((InternalEList<?>)getOut()).basicRemove(otherEnd, msgs);
      }
      return super.eInverseRemove(otherEnd, featureID, msgs);
   }

	/**
    * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
    * @generated
    */
	@Override
	public Object eGet(int featureID, boolean resolve, boolean coreType) {
      switch (featureID) {
         case TransformationPackage.INITIAL__NAME:
            return getName();
         case TransformationPackage.INITIAL__IN:
            return getIn();
         case TransformationPackage.INITIAL__OUT:
            return getOut();
      }
      return super.eGet(featureID, resolve, coreType);
   }

	/**
    * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
    * @generated
    */
	@SuppressWarnings("unchecked")
	@Override
	public void eSet(int featureID, Object newValue) {
      switch (featureID) {
         case TransformationPackage.INITIAL__NAME:
            setName((String)newValue);
            return;
         case TransformationPackage.INITIAL__IN:
            getIn().clear();
            getIn().addAll((Collection<? extends Edge>)newValue);
            return;
         case TransformationPackage.INITIAL__OUT:
            getOut().clear();
            getOut().addAll((Collection<? extends Edge>)newValue);
            return;
      }
      super.eSet(featureID, newValue);
   }

	/**
    * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
    * @generated
    */
	@Override
	public void eUnset(int featureID) {
      switch (featureID) {
         case TransformationPackage.INITIAL__NAME:
            setName(NAME_EDEFAULT);
            return;
         case TransformationPackage.INITIAL__IN:
            getIn().clear();
            return;
         case TransformationPackage.INITIAL__OUT:
            getOut().clear();
            return;
      }
      super.eUnset(featureID);
   }

	/**
    * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
    * @generated
    */
	@Override
	public boolean eIsSet(int featureID) {
      switch (featureID) {
         case TransformationPackage.INITIAL__NAME:
            return NAME_EDEFAULT == null ? name != null : !NAME_EDEFAULT.equals(name);
         case TransformationPackage.INITIAL__IN:
            return in != null && !in.isEmpty();
         case TransformationPackage.INITIAL__OUT:
            return out != null && !out.isEmpty();
      }
      return super.eIsSet(featureID);
   }

	/**
    * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
    * @generated
    */
	@Override
	public String toString() {
      if (eIsProxy()) return super.toString();

      StringBuffer result = new StringBuffer(super.toString());
      result.append(" (name: ");
      result.append(name);
      result.append(')');
      return result.toString();
   }

} //InitialImpl
