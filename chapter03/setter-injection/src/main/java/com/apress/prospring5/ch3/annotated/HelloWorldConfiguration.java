package com.apress.prospring5.ch3.annotated;

import com.apress.prospring5.ch2.decoupled.MessageProvider;
import com.apress.prospring5.ch2.decoupled.MessageRenderer;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;

/**
 * Created by iuliana.cosmina on 1/29/17.
 */
@ComponentScan(basePackages = {"com.apress.prospring5.ch3.annotated"})
@Configuration
public class HelloWorldConfiguration {
    @Bean
    public MessageProvider saymonprovider() {
        return new HelloWorldMessageProvider();
    }


    @Bean
    public MessageRenderer saymonrenderer(){
        MessageRenderer renderer = new StandardOutMessageRenderer();
        renderer.setMessageProvider(saymonprovider());
        return renderer;
    }
}
