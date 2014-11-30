package edu.ipfw.acs.controller;

import java.io.IOException;
import java.io.StringReader;
import java.rmi.RemoteException;
import java.util.ArrayList;
import java.util.List;
import java.util.Locale;

import org.hibernate.Query;

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
import org.springframework.web.servlet.ModelAndView;
import org.w3c.dom.Document;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;
import org.xml.sax.InputSource;
import org.xml.sax.SAXException;
import org.apache.axiom.om.OMElement;
import org.apache.axiom.om.impl.builder.StAXOMBuilder;
import org.apache.axis2.AxisFault;
import org.apache.axis2.databinding.ADBException;
import org.hibernate.Session;
import org.hibernate.Transaction;

import edu.ipfw.acs.model.*;
import edu.ipfw.acs.services.soap.GetCurrentStats;
import edu.ipfw.acs.services.soap.GetCurrentStatsResponse;
import edu.ipfw.acs.services.soap.StatisticsStub;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.orm.hibernate4.HibernateTransactionManager;

/**
 * Handles requests for the application home page.
 */
@Controller
public class CAVBackendWebServiceController {

	@Autowired
	private CAVDataSourceManager dataSourceManager;
	
	public static Logger getLogger() {
		return logger;
	}

	private static final Logger logger = LoggerFactory.getLogger(CAVBackendWebServiceController.class);
	
	@RequestMapping(value = "/resetLabInfo", method = RequestMethod.GET)
	public String home(Locale locale, Model model) {
		
		/* Init Lab Data */
		CAVLab lab0 = new CAVLab();
		lab0.setLabStatsCode("WU_221");
		lab0.setBuilding("Walb");
		lab0.setRoom("221");
		lab0.setDetailedDescription("Walb is located across from Helmke Library and also from the Rhinehart Music Center. This computer lab is on the second floor.");
		lab0.setLatitude("41.118003");
		lab0.setLongitude("-85.108581");
		
		CAVLab lab1 = new CAVLab();
		lab1.setLabStatsCode("VA_205");
		lab1.setBuilding("Visual Arts");
		lab1.setRoom("205");
		lab1.setDetailedDescription("Visual Arts is located across from the Rhinehart Music Center. This computer lab is on the second floor.");
		lab1.setLatitude("41.120709");
		lab1.setLongitude("-85.109433");
		
		CAVLab lab2 = new CAVLab();
		lab2.setLabStatsCode("LA 42");
		lab2.setBuilding("Libral Arts");
		lab2.setRoom("42");
		lab2.setDetailedDescription("Libral Arts is located across from the Science building and also from Helmke Library. This computer lab is on the first floor.");
		lab2.setLatitude("41.117333");
		lab2.setLongitude("-85.110107");
		
		HibernateTransactionManager transactionManager = this.dataSourceManager.getTransactionManager();
		Session session = transactionManager.getSessionFactory().openSession();

		Transaction trans = null;
		try {
			trans = session.beginTransaction();
			Query query = (Query) session.createQuery("delete from CAVLab");
			query.executeUpdate();
			trans.commit();
			
			trans = session.beginTransaction();
			session.saveOrUpdate(lab0);
			session.saveOrUpdate(lab1);
			session.saveOrUpdate(lab2);
			session.flush();
			trans.commit();
		}
		catch (Exception e) {
			  if (trans!=null){
				  trans.rollback();
			  }
			  	e.printStackTrace(); 
			}finally {
			   session.close();
			}
	
		return "getLabInformation";
	}

	public CAVDataSourceManager getDataSourceManager() {
		return dataSourceManager;
	}

	public void setDataSourceManager(CAVDataSourceManager dataSourceManager) {
		this.dataSourceManager = dataSourceManager;
	}

	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@RequestMapping(value = "/getLabInformation", method = RequestMethod.GET)
	public ModelAndView getLabInformation(Locale locale, Model model) {
		ArrayList<CAVLab>cavLabs = this.getLabStatsInformation();
		
		ModelAndView modelAndView = new ModelAndView("getLabInformation","cavLabs", cavLabs);
		
		return modelAndView;
	}
	
	private ArrayList<CAVLab> getLabStatsInformation(){
		ArrayList <CAVLab> labStatsInformation = null;
		
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
						
						HibernateTransactionManager transactionManager = this.dataSourceManager.getTransactionManager();
						Session session = transactionManager.getSessionFactory().openSession();
						
						List<CAVLab> cavLabs = null;
						Transaction trans = null;
					    try {      
					    	Query query = (Query) session.createQuery("from CAVLab");
					        cavLabs = query.list();
					    } catch (Exception e) {
							  if (trans!=null){
								  trans.rollback();
							  }
							  
							  	e.printStackTrace(); 
							}finally {
							   session.close();
							}
					    
					    for(CAVLab cavLab : cavLabs){
					    	for(LabStatsXMLNode node : labStatsXMLNode){
					    		if(node.groupName.toLowerCase().trim().equals(cavLab.getLabStatsCode().toLowerCase().trim())){
					    			if(node.getType().toLowerCase().trim().equals("avail")){
					    				cavLab.setAvailableCapacity(node.getValue());
					    			}
					    			else if(node.getType().toLowerCase().trim().equals("in use")){
					    				cavLab.setInUse(node.getValue());
					    			}
					    			else if(node.getType().toLowerCase().trim().equals("off")){
					    				cavLab.setOff(node.getValue());
					    			}
					    		}
					    	}
					    }
					    
					   labStatsInformation = new ArrayList<CAVLab>(cavLabs); 
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
