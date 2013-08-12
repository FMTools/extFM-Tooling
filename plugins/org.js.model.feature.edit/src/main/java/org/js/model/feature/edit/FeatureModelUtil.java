/************************************************************
 * Copyright (c) 2010 paperlocator.org - all rights reserved.
 * 
 * $Id$ 
 * $Revision$ 
 * $Author$
 ***********************************************************/
package org.js.model.feature.edit;

import java.io.IOException;

import org.eclipse.core.resources.IFile;
import org.eclipse.core.resources.IFolder;
import org.eclipse.core.resources.IProject;
import org.eclipse.core.resources.IResource;
import org.eclipse.core.resources.IWorkspace;
import org.eclipse.core.resources.ResourcesPlugin;
import org.eclipse.core.runtime.CoreException;
import org.eclipse.core.runtime.IPath;
import org.eclipse.core.runtime.NullProgressMonitor;
import org.eclipse.emf.common.util.URI;
import org.eclipse.emf.ecore.EObject;
import org.eclipse.emf.ecore.resource.Resource;
import org.eclipse.emf.ecore.resource.ResourceSet;
import org.eclipse.emf.ecore.resource.impl.ResourceSetImpl;
import org.eclipse.emf.workspace.util.WorkspaceSynchronizer;
import org.js.model.feature.AttributeConstraint;
import org.js.model.feature.AttributeOperand;
import org.js.model.feature.AttributeReference;
import org.js.model.feature.AttributeValue;
import org.js.model.feature.Feature;
import org.js.model.feature.FeatureConstraint;
import org.js.model.feature.FeatureState;
import org.js.model.feature.Imply;
import org.js.model.feature.Relop;

/**
 * @author <a href="mailto:julia.schroeter@tu-dresden.de">Julia Schroeter</a>
 * 
 */
public final class FeatureModelUtil {

	public static boolean isFeatureSelected(Feature feature) {
		FeatureState selected = feature.getConfigurationState();
		return FeatureState.SELECTED.equals(selected);
	}

	public static boolean isFeatureDeselected(Feature feature) {
		FeatureState selected = feature.getConfigurationState();
		return FeatureState.DESELECTED.equals(selected);
	}

	/**
	 * save the feature model in the file system.
	 * 
	 * @param model
	 * @param fileName
	 */
	public static void persistModel(EObject model, String fileName) {
		ResourceSet set = new ResourceSetImpl();
		URI modelURI = URI.createFileURI(fileName);
		Resource modelResource = set.createResource(modelURI);
		modelResource.getContents().add(model);
		try {
			modelResource.save(null);
			// log.info("Model saved to " + fileName);
			refreshModelResource(modelResource);
		} catch (IOException e) {
			// log.error("Could not save model to path " + fileName);
			// log.error(e.getMessage());
		}
	}

	/**
	 * refresh the resource file locally in the workspace.
	 * 
	 * @param modelResource
	 */
	public static void refreshModelResource(Resource modelResource) {
		IFile file = getFile(modelResource);
		try {
			if (file != null) {
				file.refreshLocal(IResource.DEPTH_ZERO, null);
			}
		} catch (CoreException e) {
			// log.error("Could not refresh featuremodel at path " +
			// file.getName());
		}
	}

	/**
	 * get the ifile representation of a resource.
	 * 
	 * @param modelResource
	 * @return
	 */
	public static IFile getFile(Resource modelResource) {
		IFile file = WorkspaceSynchronizer.getFile(modelResource);
		return file;
	}

	public static void persistModel(EObject model, String fileName,
			String nsPrefix, String modelFolder, String projectName) {
		IProject genProject = getProject(projectName);
		IFolder projectFolder = getProjectFolder(modelFolder, genProject);
		if (projectFolder != null) {
			IPath path = projectFolder.getRawLocation();
			if (path != null) {
				String absoluteFileUri = path + "/" + fileName + "." + nsPrefix;
				// log.info("Persist model " + absoluteFileUri);
				persistModel(model, absoluteFileUri);
			}
			try {
				projectFolder.refreshLocal(IResource.DEPTH_ZERO, null);
			} catch (CoreException e) {
				// log.error("Could not refresh Folder " + projectFolder);
			}
		}
	}

	/**
	 * get a folder from the workspace that is a member if the given project
	 * 
	 * @param folderName
	 * @return
	 */
	public static IFolder getProjectFolder(String folderName, IProject project) {
		IFolder projectFolder = null;
		if (project != null) {
			projectFolder = project.getFolder(folderName);
			if (!projectFolder.exists()) {
				try {
					projectFolder.create(false, true, null);
				} catch (CoreException e) {
					// log.error("Could not create Folder " + folderName);
				}
			}
		}
		return projectFolder;
	}

	/**
	 * get a project from the workspace. if it does not exist it, create it.
	 * 
	 * @param projectName
	 * @return
	 */
	public static IProject getProject(String projectName) {
		IWorkspace workspace = ResourcesPlugin.getWorkspace();
		IProject project = workspace.getRoot().getProject(projectName);
		try {
			if (!project.exists()) {
				project.create(new NullProgressMonitor());
			}
			openProject(project);
		} catch (CoreException e) {
			// log.error("Unable to find or create project '" + projectName +
			// "' in workspace.");
		}
		return project;
	}

	/**
	 * Open a project in the workspace.
	 * 
	 * @param project
	 */
	public static void openProject(IProject project) {
		try {
			if (!project.isOpen()) {
				project.open(new NullProgressMonitor());
			}
		} catch (CoreException e) {
			// log.error("Unable to open project '" + project.getName() + "'.");
		}
	}

	public static IProject getProject(EObject object) {
		Resource eResource = object.eResource();
		IFile file = getFile(eResource);
		return file.getProject();
	}

	public static String getProjectName(EObject object) {
		return getProject(object).getName();
	}

	/**
	 * return a textual representation of the given feature model constraint
	 * 
	 * @param constraint
	 * @return
	 */
	public static String getLabel(FeatureConstraint constraint) {
		String label = "<" + constraint.getId() + ">";
		Feature leftOperand = constraint.getLeftOperand();
		Feature rightOperand = constraint.getRightOperand();
		String leftOpId = leftOperand.getName();
		String rightOpId = rightOperand.getName();
		String operator = constraint instanceof Imply ? "requires" : "excludes";
		label += " " + leftOpId + " " + operator + " " + rightOpId;
		return label;
	}

	public static String getLabel(AttributeOperand operand) {
		String label = "";
		if (operand instanceof AttributeReference) {
			AttributeReference attributeRef = (AttributeReference) operand;
			label += getAttributeReferenceName(attributeRef);
		} else if (operand instanceof AttributeValue) {
			AttributeValue attributeValue = (AttributeValue) operand;
			label += getAttributeValueLabel(attributeValue);

		}

		return label;
	}

	public static String getLabel(
			AttributeConstraint constraint) {
		String label = "<" + constraint.getId() + ">";
		AttributeOperand attribute1 = constraint.getAttribute1();
		String att1Label = getLabel(attribute1);
		AttributeOperand attribute2 = constraint.getAttribute2();
		String att2Label = getLabel(attribute2);

		Relop operator = constraint.getOperator();
		String operatorLabel = getLabel(operator);
		label += " " + att1Label + " " + operatorLabel + " " + att2Label;
		return label;
	}

	private static String getLabel(Relop operator) {
		String label = "";
		switch (operator.getValue()) {
		case Relop.EQUAL_VALUE:
			label = "==";
			break;
		case Relop.GREATER_THAN_OR_EQUAL_VALUE:
			label = ">=";
			break;
		case Relop.GREATER_THAN_VALUE:
			label = ">";
			break;
		case Relop.LESS_THAN_OR_EQUAL_VALUE:
			label = "<=";
			break;
		case Relop.LESS_THAN_VALUE:
			label = "<";
			break;
		case Relop.UNEQUAL_VALUE:
			label = "!=";
			break;

		default:
			break;
		}
		
		return label;
	}

	public static String getAttributeValueLabel(AttributeValue attributeValue) {
		String label = "";
		String name = attributeValue.getName();
		if (name != null && !name.isEmpty()) {
			label = name;
		} else {
			label = Integer.toString(attributeValue.getInt());
		}
		return label;
	}

	public static String getAttributeReferenceName(AttributeReference reference) {
		String label = "";
		String featureId = reference.getFeature().getId();
		String attName = reference.getAttribute().getName();
		label += " " + featureId + "." + attName;
		return label;
	}

}