package com.apress.prospring5.ch7.config;


import org.hibernate.SessionFactory;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.PropertySource;
import org.springframework.core.env.Environment;
import org.springframework.jdbc.datasource.embedded.EmbeddedDatabaseBuilder;
import org.springframework.jdbc.datasource.embedded.EmbeddedDatabaseType;
import org.springframework.orm.hibernate5.HibernateTransactionManager;
import org.springframework.orm.hibernate5.LocalSessionFactoryBean;
import org.springframework.transaction.PlatformTransactionManager;
import org.springframework.transaction.annotation.EnableTransactionManagement;

import javax.sql.DataSource;
import java.io.IOException;
import java.util.Properties;

/**
 * Created by iuliana.cosmina on 4/21/17.
 */
@Configuration
@PropertySource("classpath:sql/db.properties")
@ComponentScan(basePackages = "com.apress.prospring5.ch7")
@EnableTransactionManagement
public class AppConfig {

	private static Logger logger = LoggerFactory.getLogger(AppConfig.class);

	@Autowired
	private Environment env;


	@Bean
	public DataSource dataSource() {
		try {
			EmbeddedDatabaseBuilder dbBuilder = new EmbeddedDatabaseBuilder();
			return dbBuilder.setType(EmbeddedDatabaseType.H2)
					.addScripts("classpath:sql/schema.sql", "classpath:sql/test-data.sql").build();
		} catch (Exception e) {
			logger.error("Embedded DataSource bean cannot be created!", e);
			return null;
		}
	}




	private Properties hibernateProperties() {
		Properties properties = new Properties();
		properties.put("hibernate.dialect", env.getProperty("hibernate.dialect"));
		properties.put("hibernate.hbm2ddl.auto", env.getProperty("hibernate.hbm2ddl.auto"));
		properties.put("hibernate.show_sql", env.getProperty("hibernate.show_sql"));
		return properties;
	}

	@Bean
	public SessionFactory sessionFactory() {
		LocalSessionFactoryBean lsfb = new LocalSessionFactoryBean();
		lsfb.setDataSource(dataSource());
		lsfb.setPackagesToScan("com.apress.prospring5.ch7.entities");
		lsfb.setHibernateProperties(hibernateProperties());
		try {
			lsfb.afterPropertiesSet();
		} catch (IOException e) {
			e.printStackTrace();
		}
		return lsfb.getObject();
	}

	@Bean public PlatformTransactionManager transactionManager() throws IOException {
		return new HibernateTransactionManager(sessionFactory());
	}


}
