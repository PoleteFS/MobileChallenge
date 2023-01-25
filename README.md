# MobileChallenge

- La arquitectura usada para la prueba es MVVM

- El botón de la pantalla principal situado a la parte inferior es para verificar que mientras llegan los datos, la interfície no de bloqueo, mostrando así un 
texto por la consola.

- En la pantalla principal se muestran los productos (ProductsViewController), donde cada producto tiene un botón de detalle desde el cual se accede
a un segunda pantalla (ProductDetailViewcontroller )donde se muestran las transacciones de dicho producto junto con la suma total del importe de ellas en euro.

- Se han añadido 3 UnitTest:
      - Verificar que no hay conversiones imposibles.
      - Verificar que existen un producto.
      - Verificar que un producto tiene conversion a euro.
