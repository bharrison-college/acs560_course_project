package edu.ipfw.acs.model;

import org.springframework.orm.hibernate4.HibernateTransactionManager;

public class CAVDataSourceManager {
	private HibernateTransactionManager transactionManager;
	
	public HibernateTransactionManager getTransactionManager() {
		return transactionManager;
	}

	public void setTransactionManager(HibernateTransactionManager transactionManager) {
		this.transactionManager = transactionManager;
	}
}
