package edu.ipfw.acs;

import java.io.IOException;
import java.io.StringReader;
import java.rmi.RemoteException;
import java.text.DateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.Locale;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;
import javax.xml.stream.XMLStreamException;
import javax.xml.stream.XMLStreamReader;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.w3c.dom.Document;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;
import org.xml.sax.InputSource;
import org.xml.sax.SAXException;
import org.apache.axiom.om.OMElement;
import org.apache.axiom.om.impl.builder.StAXOMBuilder;
import org.apache.axis2.AxisFault;
import org.apache.axis2.databinding.ADBException;

import edu.ipfw.acs.model.*;
import edu.ipfw.acs.services.soap.GetCurrentStats;
import edu.ipfw.acs.services.soap.GetCurrentStatsResponse;
import edu.ipfw.acs.services.soap.StatisticsStub;

import org.springframework.orm.hibernate4.HibernateTransactionManager;

/**
 * Handles requests for the application home page.
 */
@Controller
public class CAVBackendWebServiceController {
	
	private HibernateTransactionManager transactionManager;
	

	public HibernateTransactionManager getTransactionManager() {
		return transactionManager;
	}

	public void setTransactionManager(HibernateTransactionManager transactionManager) {
		this.transactionManager = transactionManager;
	}

	public static Logger getLogger() {
		return logger;
	}

	private static final Logger logger = LoggerFactory.getLogger(CAVBackendWebServiceController.class);
	
	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@RequestMapping(value = "/saveLabs", method = RequestMethod.GET)
	public String home(Locale locale, Model model) {
		/*
		CAVLab testLab = new CAVLab();
		testLab.setAvailableCapacity("30");
		testLab.setInUse("15");
		testLab.setOff("15");
		testLab.setBuilding("Kettler Hall");
		testLab.setPreviewDescription("Kettler hall preview");
		testLab.setDetailedDescription("Kettler Hall was formed..");
		testLab.setLatitude("123.3432");
		testLab.setLongitude("32423.234");	
		
		this.transactionManager.getSessionFactory().getCurrentSession().save(testLab);
		*/
		
		logger.info("successfully saved");
		
		return "getLabAvailability";
	}
	
	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@RequestMapping(value = "/getLabInformation", method = RequestMethod.GET)
	public String getLabInformation(Locale locale, Model model) {
		this.getLabStatsInformation();
		return "getLabInformation";
	}
	
	private boolean checkLabStatsAvailability(){
		
		return false;
	}
	
	private boolean checkDataSourceAvailability(){
		
		return false;
	}
	
	private ArrayList<CAVLab> getLabStatsInformation(){
		ArrayList <CAVLab> labStatsInformation = new ArrayList<CAVLab>();
		
		try {
			StatisticsStub statisticsStub = new StatisticsStub();
			GetCurrentStats getCurrentStats = new GetCurrentStats();
			try {
				GetCurrentStatsResponse getCurrentStatsResults = statisticsStub.getCurrentStats(getCurrentStats);
				
				try {
					XMLStreamReader xmlStreamReader = getCurrentStatsResults.getPullParser(getCurrentStats.MY_QNAME);
					try {
						OMElement omElement = new StAXOMBuilder(xmlStreamReader).getDocumentElement();
						String xml = omElement.toStringWithConsume();
						
						ArrayList<LabStatsXMLNode> labStatsXMLNode = this.processXML(xml);
						
					} catch (XMLStreamException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
				} catch (ADBException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				
			} catch (RemoteException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
		} catch (AxisFault e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return labStatsInformation;
	}
	
	private ArrayList<LabStatsXMLNode>processXML(String xml){
		ArrayList<LabStatsXMLNode>labStatsXMLNodeList = new ArrayList<LabStatsXMLNode>();
		try {
			DocumentBuilder db = DocumentBuilderFactory.newInstance().newDocumentBuilder();
			InputSource is = new InputSource();
		    is.setCharacterStream(new StringReader(xml));

		    Document doc = null;
			try {
				doc = db.parse(is);
			} catch (SAXException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
		    NodeList nodes = doc.getElementsByTagName("In_x0020_Use");
		    int nodeListLength = nodes.getLength();
		    int c = 0;
		    for(; c < nodeListLength; c++){
		    	Node moduleNode = nodes.item(c);
		    	NodeList childNodes = moduleNode.getChildNodes();
		    	LabStatsXMLNode labStatsXMLNode = new LabStatsXMLNode();
		    	
		    	int attributeNodeListLength = childNodes.getLength();
		    	boolean isGroupAttributeNode = false;
		    	int u = 0;
		    	for(; u < attributeNodeListLength; u++){
		    		Node node = childNodes.item(u);
		    		if(node.getNodeName().equals("GroupName")){
		    			String text = node.getTextContent();
		    			labStatsXMLNode.setGroupName(text);
		    			
		    			isGroupAttributeNode = true;
		    		}
		    		else if(node.getNodeName().equals("Type")){
		    			String text = node.getTextContent();
		    			labStatsXMLNode.setType(text);
		    		}
		    		else if(node.getNodeName().equals("Value")){
		    			String text = node.getTextContent();
		    			labStatsXMLNode.setValue(text);
		    		}
		    	}
		    	
		    	if(isGroupAttributeNode){
		    		labStatsXMLNodeList.add(labStatsXMLNode);
		    	}
		    }
		    
		    for(LabStatsXMLNode labStatsXMLNode : labStatsXMLNodeList){
		    	System.out.println(labStatsXMLNode.groupName);
		    	System.out.println(labStatsXMLNode.type);
		    	System.out.println(labStatsXMLNode.value);
		    }
			
		} catch (ParserConfigurationException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return labStatsXMLNodeList;
	}
	
	private ArrayList<CAVLab> getLabInformationFromDataSource(){
		ArrayList <CAVLab> labStatsInformation = new ArrayList<CAVLab>();
		
		return labStatsInformation;
	}
	
	private class LabStatsXMLNode{
		private String groupName;
		private String type;
		private String value;

		public LabStatsXMLNode(String groupName, String type, String value){
			this.groupName = groupName;
			this.type = type;
			this.value = value;
		}
		
		public LabStatsXMLNode(){}
		
		public String getGroupName() {
			return groupName;
		}

		public void setGroupName(String groupName) {
			this.groupName = groupName;
		}

		public String getType() {
			return type;
		}

		public void setType(String type) {
			this.type = type;
		}

		public String getValue() {
			return value;
		}

		public void setValue(String value) {
			this.value = value;
		}
	}
}
