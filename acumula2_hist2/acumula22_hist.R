#' ---
#' title: "Datos ISCIII COVID-19 por CCAA"
#' author: "Evolución de los valores reportados"
#' 
#' output:
#'   html_document:
#'      code_folding: hide
#'      toc: true
#'      toc_float: true
#'      fig_width: 12
#'      fig_height: 6  
#'      out_width: "100%"    
#' ---

# knitr::spin("acumula22_hist.R", knit = FALSE) # Crea .Rmd
# knitr::purl("acumula22_hist.Rmd", documentation = 2) # Crea .R spin

# PENDIENTE:
#   Generar un fichero de cambios:
#         Bucle last:2 / Empezar solo con last
#         Añadir ficheros 2:(last - 1) a files[last] y calcular diferencia/error y lag/horizonte
#   Análisis descriptivo: dispersión/boxplot error|lag


library(dplyr, warn.conflicts = FALSE)
library(tidyr)

files <- dir(pattern = paste0('^acumula22_\\d{2}_\\d{2}_\\d{2}\\.RData'))
fechas.txt <- substr(files, 11, 18)
fechas <- as.Date(fechas.txt, format = "%y_%m_%d") 
last <- length(files)
semanas <- 6
fecha.ini <- fechas[last] - 7*semanas - 1
colors <- gray((last - seq_along(files))/last)


# Cargar datos
datos <- lapply(files, function(f) {
  load(f)
  return(acumula22)
})
names(datos) <- fechas

# Obtener niveles
load("../ccaas.RData")
iso <- names(datos[[1]]) # names(ccaas) 
respuestas <- c("confirmados", "hospitalizados", "uci", "fallecidos") # names(datos[[1]][[1]])

#' 
#' Se genera un gráfico con toda la serie ***hasta `r fechas[last] - 1`*** 
#' y otro de las últimas ***`r semanas` semanas (desde `r fecha.ini`)***.
#' 
#' El color de las líneas se corresponde con la fecha en la que se reportaron los datos
#' (se muestra también el día del mes en el segundo gráfico).
#' 

xlim2 <- c(fecha.ini, max(fechas) + 1)
plot(NULL ,xaxt='n',yaxt='n',bty='n',ylab='',xlab='', xlim=0:1, ylim=0:1)
legend("top", rev(names(datos)), lty = 1, col = rev(colors), ncol = 2)

#+ results = "asis"

for (r in respuestas) {  # r <- "hospitalizados"
  cat("\n\n# ", r, "\n\n") 
  
  for (ca in iso) { # ca <- "ES"
    cat("\n\n## ",  ccaas[ca], "\n\n")
    
    old.par <- par(mfrow = c(1, 2))

    plot(observado ~ fecha, data = datos[[last]][[ca]][[r]], 
         type = "l", main = paste(ccaas[ca], r), xlab = "Fecha", ylab = r,
         col = colors[last])
    lapply(1:(last-1), function(i) 
         lines(observado ~ fecha, data = datos[[i]][[ca]][[r]], 
               col = colors[i]))     
    # legend("topleft", rev(names(datos)), lty = 1, col = rev(colors))
    

    plot(observado ~ fecha, data = datos[[last]][[ca]][[r]], 
         type = "l", main = paste(ccaas[ca], r), xlab = "Fecha", ylab = r,
         lwd = 2, col = colors[last], subset = fecha > fecha.ini - 1,
         xlim = xlim2)
    lapply(1:(last-1), function(i) 
         lines(observado ~ fecha, data = datos[[i]][[ca]][[r]], 
               col = colors[i], subset = fecha > fecha.ini - 1))
    # legend("topleft", rev(names(datos)), lty = 1, col = rev(colors))
    lapply(1:last, function(i) {
        d <- datos[[i]][[ca]][[r]]
        text(d[nrow(d), c("fecha", "observado")], 
             labels = format(fechas[i], "%d"), pos = 4)
    })
    
    par(old.par)

  } # for (ca in iso)
} # for (r in respuestas)   
  
