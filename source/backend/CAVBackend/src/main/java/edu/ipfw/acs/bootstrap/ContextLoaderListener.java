package edu.ipfw.acs.bootstrap;

import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.orm.hibernate4.HibernateTransactionManager;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;

import edu.ipfw.acs.model.CAVDataSourceManager;
import edu.ipfw.acs.model.CAVLab;

public class ContextLoaderListener extends org.springframework.web.context.ContextLoaderListener
{
	@Autowired
	private CAVDataSourceManager dataSourceManager;
    
    	public CAVDataSourceManager getDataSourceManager() {
		return dataSourceManager;
	}

	public void setDataSourceManager(CAVDataSourceManager dataSourceManager) {
		this.dataSourceManager = dataSourceManager;
	}

		public void contextInitialized(ServletContextEvent event) {
    		super.contextInitialized(event);
    		
    		WebApplicationContextUtils
            .getRequiredWebApplicationContext(event.getServletContext())
            .getAutowireCapableBeanFactory()
            .autowireBean(this);
			
    		// Init Lab Information
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
    		lab1.setDetailedDescription("The Visual Arts Building is located across from the Rhinehart Music Center. This computer lab is on the second floor.");
    		lab1.setLatitude("41.120709");
    		lab1.setLongitude("-85.109433");
    		
    		CAVLab lab2 = new CAVLab();
    		lab2.setLabStatsCode("LA 42");
    		lab2.setBuilding("Liberal Arts");
    		lab2.setRoom("42");
    		lab2.setDetailedDescription("The Liberal Arts Building is located across from the Science Building and also from Helmke Library. This computer lab is on the first floor.");
    		lab2.setLatitude("41.117309");
    		lab2.setLongitude("-85.110180");
    		
    		CAVLab lab3 = new CAVLab();
    		lab3.setLabStatsCode("SB G15");
    		lab3.setBuilding("Science Building");
    		lab3.setRoom("G15");
    		lab3.setDetailedDescription("The Science Building is located across from the Liberal Arts Building and also from Kettler Hall. This computer lab is on the first floor.");
    		lab3.setLatitude("41.117170");
    		lab3.setLongitude("-85.111417");
    		
    		CAVLab lab4 = new CAVLab();
    		lab4.setLabStatsCode("NF B71");
    		lab4.setBuilding("Neff Hall");
    		lab4.setRoom("B71");
    		lab4.setDetailedDescription("Neff Hall is located across from Kettler Hall and also from the Engineering Building. This computer lab is in the basement.");
    		lab4.setLatitude("41.116257");
    		lab4.setLongitude("-85.110467");
    		
    		CAVLab lab5 = new CAVLab();
    		lab5.setLabStatsCode("LB_4th_Floor");
    		lab5.setBuilding("Helmke Library");
    		lab5.setRoom("4th Floor");
    		lab5.setDetailedDescription("Helmke Library is located across from the Liberal Arts Building and also from the Engineering Building. This computer lab is on the fourth floor.");
    		lab5.setLatitude("41.117284");
    		lab5.setLongitude("-85.108980");
    		
    		CAVLab lab6 = new CAVLab();
    		lab6.setLabStatsCode("LB_2nd_Floor");
    		lab6.setBuilding("Helmke Library");
    		lab6.setRoom("2nd Floor");
    		lab6.setDetailedDescription("Helmke Library is located across from the Liberal Arts Building and also from the Engineering Building. This computer lab is on the second floor.");
    		lab6.setLatitude("41.117217");
    		lab6.setLongitude("-85.108915");
    		
    		CAVLab lab7 = new CAVLab();
    		lab7.setLabStatsCode("LB_1st_Floor");
    		lab7.setBuilding("Helmke Library");
    		lab7.setRoom("1st Floor");
    		lab7.setDetailedDescription("Helmke Library is located across from the Liberal Arts Building and also from the Engineering Building. This computer lab is on the first floor.");
    		lab7.setLatitude("41.117138");
    		lab7.setLongitude("-85.109138");
    		
    		CAVLab lab8 = new CAVLab();
    		lab8.setLabStatsCode("LB 24HR Lab");
    		lab8.setBuilding("Helmke Library");
    		lab8.setRoom("24 Hour Lab");
    		lab8.setDetailedDescription("Helmke Library is located across from the Liberal Arts Building and also from the Engineering Building. This computer lab is on the first floor.");
    		lab8.setLatitude("41.117096");
    		lab8.setLongitude("-85.109170");
    		
    		CAVLab lab9 = new CAVLab();
    		lab9.setLabStatsCode("KT 217");
    		lab9.setBuilding("Kettler Hall");
    		lab9.setRoom("217");
    		lab9.setDetailedDescription("Kettler Hall is located across from the Science Building and also from Neff Hall. This computer lab is on the second floor.");
    		lab9.setLatitude("41.115700");
    		lab9.setLongitude("-85.111895");
    		
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
    			session.saveOrUpdate(lab3);
    			session.saveOrUpdate(lab4);
    			session.saveOrUpdate(lab5);
    			session.saveOrUpdate(lab6);
    			session.saveOrUpdate(lab7);
    			session.saveOrUpdate(lab8);
    			session.saveOrUpdate(lab9);
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
    	}
}