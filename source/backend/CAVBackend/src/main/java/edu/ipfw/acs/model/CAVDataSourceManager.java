package edu.ipfw.acs.model;

import java.util.List;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.springframework.orm.hibernate4.HibernateTransactionManager;

public class CAVDataSourceManager {
	private HibernateTransactionManager transactionManager;
	
	public HibernateTransactionManager getTransactionManager() {
		return transactionManager;
	}

	public void setTransactionManager(HibernateTransactionManager transactionManager) {
		this.transactionManager = transactionManager;
	}
	
	public List<CAVLab> getAllCAVLabs(){
		HibernateTransactionManager transactionManager = this.getTransactionManager();
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
	    
		return cavLabs;
	}
}
