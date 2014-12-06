
/**
 * ExtensionMapper.java
 *
 * This file was auto-generated from WSDL
 * by the Apache Axis2 version: 1.6.2  Built on : Apr 17, 2012 (05:34:40 IST)
 */

        
            package edu.ipfw.acs.services.soap;
        
            /**
            *  ExtensionMapper class
            */
            @SuppressWarnings({"unchecked","unused"})
        
        public  class ExtensionMapper{

          public static java.lang.Object getTypeObject(java.lang.String namespaceURI,
                                                       java.lang.String typeName,
                                                       javax.xml.stream.XMLStreamReader reader) throws java.lang.Exception{

              
                  if (
                  "http://tempuri.org/".equals(namespaceURI) &&
                  "GroupStat".equals(typeName)){
                   
                            return  edu.ipfw.acs.services.soap.GroupStat.Factory.parse(reader);
                        

                  }

              
                  if (
                  "http://tempuri.org/".equals(namespaceURI) &&
                  "ArrayOfGroupStat".equals(typeName)){
                   
                            return  edu.ipfw.acs.services.soap.ArrayOfGroupStat.Factory.parse(reader);
                        

                  }

              
                  if (
                  "http://tempuri.org/".equals(namespaceURI) &&
                  "GetCurrentStatsResult_type0".equals(typeName)){
                   
                            return  edu.ipfw.acs.services.soap.GetCurrentStatsResult_type0.Factory.parse(reader);
                        

                  }

              
             throw new org.apache.axis2.databinding.ADBException("Unsupported type " + namespaceURI + " " + typeName);
          }

        }
    