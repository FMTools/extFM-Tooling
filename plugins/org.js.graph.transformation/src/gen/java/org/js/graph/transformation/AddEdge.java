/**
 */
package org.js.graph.transformation;

import org.eclipse.emf.common.util.EList;

/**
 * <!-- begin-user-doc -->
 * A representation of the model object '<em><b>Add Edge</b></em>'.
 * <!-- end-user-doc -->
 *
 * <p>
 * The following features are supported:
 * <ul>
 *   <li>{@link org.js.graph.transformation.AddEdge#getEdge <em>Edge</em>}</li>
 * </ul>
 * </p>
 *
 * @see org.js.graph.transformation.TransformationPackage#getAddEdge()
 * @model
 * @generated
 */
public interface AddEdge extends ChangePrimitive {
	/**
	 * Returns the value of the '<em><b>Edge</b></em>' containment reference list.
	 * The list contents are of type {@link org.js.graph.transformation.Edge}.
	 * <!-- begin-user-doc -->
	 * <p>
	 * If the meaning of the '<em>Edge</em>' containment reference list isn't clear,
	 * there really should be more of a description here...
	 * </p>
	 * <!-- end-user-doc -->
	 * @return the value of the '<em>Edge</em>' containment reference list.
	 * @see org.js.graph.transformation.TransformationPackage#getAddEdge_Edge()
	 * @model containment="true"
	 * @generated
	 */
	EList<Edge> getEdge();

} // AddEdge
