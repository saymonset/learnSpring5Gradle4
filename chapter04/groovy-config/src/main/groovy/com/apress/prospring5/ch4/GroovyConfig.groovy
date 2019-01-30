package com.apress.prospring5.ch4

import com.apress.prospring5.ch3.xml.Singer
import org.springframework.beans.factory.groovy.GroovyBeanDefinitionReader
import org.springframework.context.support.GenericApplicationContext

def ctx = new GenericApplicationContext()
def reader = new GroovyBeanDefinitionReader(ctx)

reader.beans {
    singer(Singer, name: 'John Mayer', age: 39)
}

ctx.refresh()

println ctx.getBean("singer")
