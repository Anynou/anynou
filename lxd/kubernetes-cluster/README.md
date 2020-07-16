#Despliegue automatizado de kubernetes en contenedores lxd._

##Requisitos
Para que funcione correctamente se ha de crear un perfil con la configuración del fichero k8s-profile._
También debemos tener instalado kubectl en la máquina en la que estamos realizando el despliegue._

###NOTA:_
Hay 2 scripts de isntalación, uno nos crea un volumen compartido en los workers, para poder crear volúmenes persistentes y el otro no.
