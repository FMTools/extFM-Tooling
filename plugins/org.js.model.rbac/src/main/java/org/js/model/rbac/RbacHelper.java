/************************************************************
 * Copyright (c) 2010 paperlocator.org - all rights reserved.
 * 
 * $Id$ 
 * $Revision$ 
 * $Author$
 ***********************************************************/
package org.js.model.rbac;

import org.js.model.feature.Attribute;
import org.js.model.feature.DomainValue;
import org.js.model.feature.Feature;


/**
 * Helper Class to handle model changes.
 * 
 * @author <a href="mailto:julia.schroeter@tu-dresden.de">Julia Schroeter</a>
 *
 */
public final class RbacHelper {
   
   public static DeselectDomainValue createDeselectDomainValue(DomainValue value){
      DeselectDomainValue domainValue = RbacFactory.eINSTANCE.createDeselectDomainValue();
      String name = value.getName();
      domainValue.setValue(name);
      return domainValue;
   }
   public static SelectDomainValue createSelectDomainValue(DomainValue value){
      SelectDomainValue domainValue = RbacFactory.eINSTANCE.createSelectDomainValue();
      String name = value.getName();
      domainValue.setValue(name);
      return domainValue;
   }
   
   public static SetAttribute createSetAttribute(Feature f, Attribute a){
      SetAttribute sa1 = RbacFactory.eINSTANCE.createSetAttribute();
      sa1.setAttribute(a);
      sa1.setFeature(f);
      return sa1;
   }
   
   public static SelectFeature createSelectFeature(Feature f){
      SelectFeature selectFeature = RbacFactory.eINSTANCE.createSelectFeature();
      selectFeature.setFeature(f);
      return selectFeature;
   }
  
   public static DeselectFeature createDeselectFeature(Feature f){
      DeselectFeature deselectFeature = RbacFactory.eINSTANCE.createDeselectFeature();
      deselectFeature.setFeature(f);
      return deselectFeature;
   }
   
}
