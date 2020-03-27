
Datos oficiales de COVID-19 por CCAA
====================================

<!-- 
Readme.md is generated from Readme.Rmd. 
Please edit that file 

Pendiente:

- Establecer fecha y último fichero pdf en cabecera YAML
  (actualizar texto con rmarkdown::metadata?).
  
- Combinar tablas

- Añadir enlaces

-->
El objetivo principal de [este repositorio](https://github.com/rubenfcasal/COVID-19) es facilitar el acceso a los datos del COVID-19 en España a los que pueden estar interesados en analizarlos empleando R. Además se incluye una pequeña recopilación de enlaces a recursos que pueden ser de interés.

El fichero [COVID-19-tablas.html](COVID-19-tablas.html) contiene el listado actualizado a fecha de **2020-03-27**. Las tablas (con un procesado mínimo) están almacenadas en el archivo [COVID-19.RData](COVID-19.RData).

***Nuevo (Importante)***: Desde el ***2020-03-26*** se pueden descargar los datos oficiales acumulados en la página web [Situación de COVID-19 en España](https://covid19.isciii.es) del [Instituto de Salud Carlos III (ISCIII)](https://www.isciii.es).
Archivo: [serie\_historica\_acumulados.csv](https://covid19.isciii.es/resources/serie_historica_acumulados.csv) (también disponible en este repositorio [aquí](serie_historica_acumulados.csv) y en fomato de R en [acumulados.RData](acumulados.RData)).

Por ese motivo, continuaré con este repositorio centrándome en los datos por edad y sexo:

Desde la `Actualizacion_53_COVID-19.pdf` (2020-03-23) los archivos contienen nuevas tablas con la distribución de casos hospitalizados, ingresados en UCI y fallecidos por grupos de edad y sexo (34.240 casos notificados disponían de esa información a las 21:00 horas del 2020-03-26).

***Importante***: El siguiente paso será tratar de conseguir los datos por provincias (puedes colaborar a través de GitHub o enviando un correo a <rubenfcasal@gmail.com>).

-   Galicia: <https://galiciancovid19.info>

Fuentes de los datos
--------------------

En un primer momento, al buscar datos oficiales solo encontré esta web del *Ministerio de Sanidad, Consumo y Bienestar Social*:

<https://www.mscbs.gob.es/profesionales/saludPublica/ccayes/alertasActual/nCov-China/situacionActual.htm>

donde se puede descargar un pdf con la situación actual (actualizado a las 13:00 durante la semana y a las 12:00 el fin de semana; en la web también hay actualizaciones a otras horas).

Haciendo pruebas, vi que se podían descargar los documentos desde la actualización 31. El código y los documentos pdfs los podéis encontrar en este repositorio. El archivo `COVID-19-descarga.R` contiene el código necesario para descargar los pdfs.

Posteriormente, gracias a [este comentario](https://hypatia.math.ethz.ch/pipermail/r-help-es/2020-March/013753.html) en la lista de correo de [R-Hispano](http://r-es.org), descubrí otro repositorio que contiene los datos: <https://github.com/datadista/datasets/tree/master/COVID%2019> (de donde pude descargar el fichero `Actualizacion_44_COVID.pdf` que no encontré en la web oficial).

Otros enlaces que pueden ser de interés (ver Sección [Enlaces](#enlaces)):

-   [Instituto de Salud Carlos III (ISCIII)](https://www.isciii.es)

    -   [Situación de COVID-19 en España](https://covid19.isciii.es)

    -   [serie\_historica\_acumulados.csv](https://covid19.isciii.es/resources/serie_historica_acumulados.csv)

    -   [Informes COVID-19 del Centro Nacional de Epidemiología](https://www.isciii.es/QueHacemos/Servicios/VigilanciaSaludPublicaRENAVE/EnfermedadesTransmisibles/Paginas/InformesCOVID-19.aspx)

Preparación de los datos
------------------------

### Instalación de los paquetes necesarios

Para extraer las tablas desde R se emplea el paquete [tabulizer](https://docs.ropensci.org/tabulizer), que depende del paquete [rJava](https://rforge.net/rJava). Otro paquete que puede ser de utilidad es [pdftools](https://docs.ropensci.org/pdftools), empleado actualmente para extraer las fechas.

Estos dos últimos paquetes se pueden instalar desde CRAN, pero [rJava]() necesitaría tener instalado previamente el Java Runtime Environment correspondiente al equipo y a la versión de R (e.g [JRE de 64 bits para Windows](https://www.java.com/es/download/windows-64bit.jsp)).

Para instalar [tabulizer](https://docs.ropensci.org/tabulizer) se puede emplear el paquete [devtools](https://devtools.r-lib.org):

    devtools::install_github( c("ropenscilabs/tabulizerjars", "ropenscilabs/tabulizer"), 
                              INSTALL_opts = "--no-multiarch" )

### Extracción

Las tablas por CCAA comienzan en `Actualizacion_35_COVID-19.pdf` (2020-03-03; en la tabla 3, que no se detecta). Las tablas por CCAA completas comienzan en `Actualizacion_36_COVID-19.pdf` (2020-03-04), aunque posteriormente hay cambios en los formatos de las tablas y de los archivos.

El fichero `COVID-19-procesado.R` contiene el código necesario para extraer las tablas de los pdfs, desde `Actualizacion_36_COVID-19.pdf` (2020-03-04) hasta ¿hoy?

***En preparación***: El fichero `COVID-19-procesado2.R` contiene el código en desarrollo para extraer las tablas por grupo de edad y sexo...

### Tablas

Las tablas (con un procesado mínimo) y el listado de ficheros están almacenadas en el archivo [COVID-19.RData](COVID-19.RData).

El fichero [COVID-19-tablas.html](COVID-19-tablas.html) contiene un listado (generado automáticamente a partir de [COVID-19-tablas.Rmd](COVID-19-tablas.Rmd)).

El siguiente paso será combinar las tablas (y depurarlas si es necesario)...

Work in progress... help needed!

Si quieres puedes ayudar a través de GitHub o enviando un correo a <rubenfcasal@gmail.com>.

El archivo [Actualizacion\_53\_COVID-19.pdf](Actualizacion_53_COVID-19.pdf) (2020-03-23) contiene nuevas tablas con la distribución de casos hospitalizados, ingresados en UCI y fallecidos por grupos de edad y sexo a 22.03.20 a partir de 18.959 casos notificados que disponían de esa información.

La [Actualizacion\_57\_COVID-19.pdf](Actualizacion_57_COVID-19.pdf) (2020-03-27) contiene tablas con la distribución de 34.240 casos notificados con información de edad y sexo (en los datos consolidados a las 21:00 horas del 2020-03-26).

Enlaces
-------

Work in progress... help needed!

-   [Acción Matemática contra el Coronavirus](http://matematicas.uclm.es/cemat/covid19)

-   Aplicación Shiny con estos datos: <https://cafernandezlo.shinyapps.io/es_covid>

### COVID-19 y R

-   [Top 25 R resources on COVID-19 Coronavirus](https://www.statsandr.com/blog/top-r-resources-on-covid-19-coronavirus)

-   [Covid-19 interactive map (using R with shiny, leaflet and dplyr)](http://r-posts.com/covid-19-interactive-map-using-r-with-shiny-leaflet-and-dplyr)

-   [COVID-19 epidemiology with R](https://rviews.rstudio.com/2020/03/05/covid-19-epidemiology-with-r)

### Epidemiología con R

-   <https://www.repidemicsconsortium.org>

-   [Model-based Geostatistics: Methods and Applications in Global Public Health (book)](https://sites.google.com/site/mbgglobalhealth/r-scripts)

-   [Epicalc\_Book](https://cran.r-project.org/doc/contrib/Epicalc_Book.pdf)

### Paquetes de R

Paquetes y otras herramientas...

Se puede realizar una búsqueda en <https://rseek.org>...
