#!/usr/bin/python
import os, sys
readTemplate('/u01/app/oracle/product/12.2.1/wlserver/common/templates/wls/wls.jar')
cd('/Security/base_domain/User/weblogic')
cmo.setPassword('ExamplePassword1')
cd('/Server/AdminServer')
cmo.setName('AdminServer')
cmo.setListenPort(8001)
cmo.setListenAddress('172.17.0.2')
writeDomain('/u01/app/oracle/config/domains/mydomain')
closeTemplate()
exit()