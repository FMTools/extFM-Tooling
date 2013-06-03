/**
 */
package org.js.model.workflow;

import org.eclipse.emf.common.util.EList;


import org.eclipse.jwt.we.conf.model.AspectInstance;
import org.js.model.rbac.ConfigurationDecision;
import org.js.model.rbac.Permission;

/**
 * <!-- begin-user-doc -->
 * A representation of the model object '<em><b>Log</b></em>'.
 * <!-- end-user-doc -->
 *
 * <p>
 * The following features are supported:
 * <ul>
 *   <li>{@link org.js.model.workflow.Log#getConfigurationDecisions <em>Configuration Decisions</em>}</li>
 * </ul>
 * </p>
 *
 * @see org.js.model.workflow.WorkflowPackage#getLog()
 * @model
 * @generated
 */
public interface Log extends AspectInstance {
	/**
	 * Returns the value of the '<em><b>Configuration Decisions</b></em>' reference list.
	 * The list contents are of type {@link org.js.model.rbac.ConfigurationDecision}.
	 * <!-- begin-user-doc -->
	 * <p>
	 * If the meaning of the '<em>Configuration Decisions</em>' reference list isn't clear,
	 * there really should be more of a description here...
	 * </p>
	 * <!-- end-user-doc -->
	 * @return the value of the '<em>Configuration Decisions</em>' reference list.
	 * @see org.js.model.workflow.WorkflowPackage#getLog_ConfigurationDecisions()
	 * @model
	 * @generated
	 */
	EList<ConfigurationDecision> getConfigurationDecisions();

} // Log
