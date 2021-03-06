/**
 * <copyright>
 * </copyright>
 *
 * 
 */
package org.js.model.rbac.resource.rbactext.analysis;

import org.js.model.rbac.RBACResolverUtil;

public class AccessControlModelAccessControlModelsReferenceResolver implements org.js.model.rbac.resource.rbactext.IRbactextReferenceResolver<org.js.model.rbac.AccessControlModel, org.js.model.rbac.AccessControlModel> {
	
	private org.js.model.rbac.resource.rbactext.analysis.RbactextDefaultResolverDelegate<org.js.model.rbac.AccessControlModel, org.js.model.rbac.AccessControlModel> delegate = new org.js.model.rbac.resource.rbactext.analysis.RbactextDefaultResolverDelegate<org.js.model.rbac.AccessControlModel, org.js.model.rbac.AccessControlModel>();
	
	public void resolve(String identifier, org.js.model.rbac.AccessControlModel container, org.eclipse.emf.ecore.EReference reference, int position, boolean resolveFuzzy, final org.js.model.rbac.resource.rbactext.IRbactextReferenceResolveResult<org.js.model.rbac.AccessControlModel> result) {
		delegate.resolve(identifier, container, reference, position, resolveFuzzy, result);
	}
	
	public String deResolve(org.js.model.rbac.AccessControlModel element, org.js.model.rbac.AccessControlModel container, org.eclipse.emf.ecore.EReference reference) {
		return RBACResolverUtil.getRelativeURI(element, container);
	}
	
	public void setOptions(java.util.Map<?,?> options) {
		// save options in a field or leave method empty if this resolver does not depend
		// on any option
	}
	
}
