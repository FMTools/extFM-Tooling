package org.js.model.feature.quality.assurance;

import java.util.*;

import org.eclipse.core.resources.*;
import org.eclipse.core.runtime.*;
import org.eclipse.jface.viewers.*;

/**
 * This class offers static functionalities to interact with Eclipse
 * @author David Gollasch
 *
 */
public class QAPluginHelper {
	/**
	 * Takes a selection and if it's a folder selection it will return you back a 
	 * list with all directly sub ordered files of this folder 
	 * @param selection The selection (a folder has to be selected to run correctly)
	 * @return A list of files if <code>selection</code> is a folder selection 
	 * 			and if this folder includes files
	 */
	public static List<IFile> getFilesFromFolderSelection(ISelection selection) {
		
		if(selection instanceof IStructuredSelection) {
			IStructuredSelection issl = (IStructuredSelection)selection;
			Object obj = issl.getFirstElement();
			IFolder folder = (IFolder) Platform.getAdapterManager().getAdapter(obj, IFolder.class);
			if(folder == null) {
				if(obj instanceof IAdaptable) {
					folder = (IFolder)((IAdaptable)obj).getAdapter(IFolder.class);
				} else {
					// (state) no folder found
					// return no list
					return null;
				}
			}
			
			// (state) folder grabbed
			
			ArrayList<IResource> includedelements = new ArrayList<IResource>();
			try {
				includedelements.addAll(Arrays.asList(folder.members()));
			} catch (CoreException e) {
				// exception reasons:
				// no resource existing or resource is a closed project
				
				// leave the includedelements list empty
			}
			
			// (state) all sub ordered resources grabbed
			
			List<IFile> includedfiles = new ArrayList<IFile>();
			
			for (IResource ir : includedelements) {
				if(ir.getType() == IResource.FILE) {
					includedfiles.add((IFile)(ir.getAdapter(IFile.class)));
				}
			}
			
			// (state) all sub ordered files grabbed
			
			return includedfiles;
			
		}
		
		return null;
	}
}
