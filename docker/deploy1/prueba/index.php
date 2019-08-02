<?php

// Conexión con el servidor
$conexion=mysqli_connect("db", "usu1", "mypassusu1") or die ("error1".mysqli_error());

// Selección de Base de Datos
mysqli_select_db($conexion, "prueba") or die ("error2".mysqli_error());
?>

<?php
////Obteniendo registros de la base de datos a traves de una consulta SQL 
$consulta="SELECT * FROM Datos";
$resultado=mysqli_query($conexion, $consulta);
while($rows=mysqli_fetch_array($resultado)){
echo "Nombre: ".$rows[0]."<br>";
echo "Apellido: ".$rows[1]."<br>";
echo "Email: ".$rows[2]."<br>";
}
?>
