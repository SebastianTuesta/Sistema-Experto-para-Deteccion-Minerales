;;HAY CONFLICTOS ENTRE ALGUNAS REGLAS PARA SOLUCIONARLO SE USARA LA REGLA DE SOLUCION DE CONFLICTOS DE LA REGLA MAS GENERAL MEDIANTE EL USO DEL SLOT "Nombre" Y DECLARANDO LAS REGLAS MAS GENERALES PRIMERO QUE LAS MENOS GENERALES

;;TEMPLATE PARA MINERAL
(deftemplate Mineral
         (slot Color (type STRING) (allowed-strings "Incoloro" "Blanco" "Rosado" "Amarillo" "Marron" "Gris Blanco" "Beige" "Amarillo Verdoso" "Gris" "Gris Verdoso" "Verde Azulado" "Morado" "Blanco Plata" "Blanco Verdoso" "Marron Verdoso" "Verde" "Marron Claro" "Marron Oscuro" "Negro" "Rojo" "Azul" "Amarillo Laton" "Celeste" "Azul Oscuro" "Negro Verdoso" "Negro Grisaceo" "Azul Celeste" "Celeste" "Verde Oliva" "Ocre"  "Rojo Ladrillo" "Marron Verdoso" "Verde Azulado" "Verde Amarillento" "Pardo" "Blanco Rojizo" "Blanco Verdoso" "Blanco Amarillento" "Gris Amarillento" "Rojo Rosaceo" "Verde Manzana") (default ?NONE))
         (slot Transparencia (type STRING) (allowed-strings "Opaco" "Translucido" "Sub Translucido" "Transparente") (default ?NONE))
         (slot Fractura (type STRING) (allowed-strings "Fragil" "Astillosa" "Concoidal" "Irregular" "Sub Concoidal" "Sectil" "Terrosa") (default ?NONE))
         (slot Habito (type STRING)(allowed-strings "Acicular" "Columnar" "Cristalino" "Fibroso" "Granular" "Masivo" "Foliado" "Botroidal" "Laminar" "Estriado" "Terroso" "Diseminado" "Estalactita" "En Bloque" "Micaceo") (default ?NONE))
	 (slot Dureza (type NUMBER) (range 1 10) (default ?NONE))
	 (slot Luminiscencia (type STRING) (allowed-strings "Ligeramente Fluorescente" "Fluorescente" "No Fluorescente" "Fosforescente" "Tribuluminiscente") (default ?NONE))
	 (slot Brillo (type STRING) (allowed-strings "Metalico" "Vitreo" "Diamantino" "Resinoso" "Perlado" "Mate" "Iridiscente" "Terroso" "Graso") (default ?NONE))
	 (slot Magnetismo (type STRING)(allowed-strings "Fuerte" "Sin Magnetismo" "Despues de Calentar") (default ?NONE))
	 (slot Raya (type STRING) (allowed-strings "Blanca" "Gris Verdoso" "Negra Verduzca" "Negro Grisaceo" "Verde Manzana" "Celeste" "Gris" "Blanco Marron" "Verde" "Marron Claro" "Verde Claro") (default ?NONE))
	;;ESTE SLOT SIRVE PARA EVITAR CICLOS INFINITOS
	 (slot Nombre (type STRING))
)

;;INGRESANDO BASE DE REGLAS
(defrule Magnetita
	?mineral<-(Mineral (Magnetismo "Fuerte")(Nombre ""))
	=>(modify ?mineral (Nombre "Magnetita"))
)

(defrule Pirita
	?mineral<-(Mineral (Magnetismo "Despues de Calentar") (Raya "Negra Verduzca")(Nombre ""))
	=>(modify ?mineral (Nombre "Pirita"))
)

(defrule Bornita
	?mineral<-(Mineral (Magnetismo "Despues de Calentar") (Raya "Negro Grisaceo")(Nombre ""))
	=>(modify ?mineral (Nombre "Bornita"))
)

(defrule Augita
	?mineral<-(Mineral (Magnetismo "Sin Magnetismo") (Raya "Gris Verdoso")(Nombre ""))
	=>(modify ?mineral (Nombre "Augita"))
)

(defrule Atacamita
	?mineral<-(Mineral (Magnetismo "Sin Magnetismo") (Raya "Verde Manzana")(Nombre ""))
	=>(modify ?mineral (Nombre "Atacamita"))
)

(defrule Azurita
	?mineral<-(Mineral (Magnetismo "Sin Magnetismo") (Raya "Celeste")(Nombre ""))
	=>(modify ?mineral (Nombre "Azurita"))
)

(defrule Epidota
	?mineral<-(Mineral (Magnetismo "Sin Magnetismo") (Raya "Blanco Marron")(Nombre ""))
	=>(modify ?mineral (Nombre "Epidota"))
)

(defrule Piroxeno
	?mineral<-(Mineral (Magnetismo "Sin Magnetismo") (Raya "Marron Claro"|"Verde")(Nombre ""))
	=>(modify ?mineral (Nombre "Piroxeno"))
)

(defrule Crisocola
	?mineral<-(Mineral (Magnetismo "Sin Magnetismo") (Raya "Verde Claro")(Nombre ""))
	=>(modify ?mineral (Nombre "Crisocola"))
)

(defrule Galena
	?mineral<-(Mineral (Magnetismo "Sin Magnetismo") (Raya "Gris") (Brillo "Metalico")(Nombre ""))
	=>(modify ?mineral (Nombre "Galena"))
)

(defrule Biotita
	?mineral<-(Mineral (Magnetismo "Sin Magnetismo") (Raya "Gris") (Brillo "Vitreo"|"Perlado")(Nombre ""))
	=>(modify ?mineral (Nombre "Biotita"))
)

(defrule No_Rayan
	(Mineral (Magnetismo "Sin Magnetismo") (Raya "Blanca")(Nombre ""))
	=>(assert (Rayan No))
)

(defrule Montomorillonita
	(Rayan No)
	?mineral<-(Mineral (Brillo "Terroso")(Nombre ""))
	=>(modify ?mineral (Nombre "Montomorillonita"))
)

(defrule Ulexita
	(Rayan No)
	?mineral<-(Mineral (Brillo "Iridiscente")(Nombre ""))
	=>(modify ?mineral (Nombre "Ulexita"))
)

(defrule Sodalita
	(Rayan No)
	?mineral<-(Mineral (Brillo "Graso")(Nombre ""))
	=>(modify ?mineral (Nombre "Sodalita"))
)

(defrule Baritina1
	(Rayan No)
	?mineral<-(Mineral (Brillo "Perlado") (Dureza ?dureza )(Nombre ""))
	(test (and(< ?dureza 5)(> ?dureza 2.5)))
	=>(modify ?mineral (Nombre "Baritina"))	
)

(defrule Cianita
	(Rayan No)
	?mineral<-(Mineral (Brillo "Perlado") (Dureza ?dureza)(Nombre ""))
	(test (and(< ?dureza 7)(> ?dureza 5)))
	=>(modify ?mineral (Nombre "Cianita"))
)

(defrule Baritina
	(Rayan No)
	?mineral<-(Mineral (Brillo "Perlado")(Nombre ""))
	=>(modify ?mineral (Nombre "Baritina"))	
)
(defrule Granate
	(Rayan No)
	?mineral<-(Mineral (Brillo "Resinoso")(Nombre ""))
	=>(modify ?mineral (Nombre "Granate"))
)

(defrule Piroxeno1
	(Rayan No)
	?mineral<-(Mineral (Brillo "Metalico")(Nombre ""))
	=>(modify ?mineral (Nombre "Piroxeno"))
)

(defrule Vidrio
	(Rayan No)
	?mineral<-(Mineral (Brillo "Vitreo")(Nombre ""))
	=>(assert(Vidrio Si))
)


(defrule Calcita
	(Vidrio Si)
	?mineral<-(Mineral (Color "Incoloro"|"Blanco"|"Rosado"|"Amarillo"|"Marron")(Dureza 3)(Habito "Cristalino")(Fractura "Concoidal") (Luminiscencia "Fluorescente"|"Fosforescente")(Nombre ""))
	=>(modify ?mineral (Nombre "Calcita"))
)

(defrule Albita
	(Vidrio Si)
	?mineral<-(Mineral (Color "Blanco"|"Gris"|"Gris Verdoso"| "Verde Azulado")(Dureza 7)(Habito "Granular"|"En Bloque"|"Estriado")(Fractura "Irregular") (Luminiscencia "Fluorescente")(Nombre ""))
	=>(modify ?mineral (Nombre "Albita"))
)

(defrule Muscovita
	(Vidrio Si)
	?mineral<-(Mineral (Color "Blanco"|"Gris"|"Blanco Plata" |"Blanco Verdoso")(Dureza 2.25)(Habito "Foliado"|"Micaceo")(Fractura "Sectil") (Luminiscencia "No Fluorescente")(Nombre ""))
	=>(modify ?mineral (Nombre "Muscovita"))
)

(defrule Fluorita
	(Vidrio Si)
	?mineral<-(Mineral (Color "Blanco"|"Amarillo"|"Verde"|"Rojo"|"Azul")(Dureza 4)(Habito "Cristalino"|"Masivo"|"Diseminado")(Fractura "Irregular") (Luminiscencia "Fluorescente")(Nombre ""))
	=>(modify ?mineral (Nombre "Fluorita"))
)

(defrule Calcita1
	(Vidrio Si)
	?mineral<-(Mineral (Color "Blanco"|"Rosado"|"Amarillo"|"Marron")(Dureza 3)(Habito "Cristalino"|"Masivo"|"Estalactita")(Fractura "Concoidal") (Luminiscencia "Fluorescente"|"Fosforescente")(Nombre ""))
	=>(modify ?mineral (Nombre "Calcita"))
)

(defrule Baritina2
	(Vidrio Si)
	?mineral<-(Mineral (Color "Incoloro"|"Amarillo"|"Blanco"|"Marron"|"Verde Azulado")(Dureza 3.25)(Habito "Cristalino")(Fractura "Irregular") (Luminiscencia "Fluorescente")(Nombre ""))
	=>(modify ?mineral (Nombre "Baritina"))
)

(defrule Apatita
	(Vidrio Si)
	?mineral<-(Mineral (Color "Blanco"|"Amarillo"| "Verde"|"Rojo"|"Azul")(Dureza 5)(Habito "Terroso"|"Masivo")(Fractura "Concoidal") (Luminiscencia "No Fluorescente")(Nombre ""))
	=>(modify ?mineral (Nombre "Apatita"))
)

(defrule Celestina
	(Vidrio Si)
	?mineral<-(Mineral (Color "Azul"|"Marron"|"Incoloro"|"Verde"|"Gris")(Dureza 3.25)(Habito "Cristalino"|"Granular"| "Masivo")(Fractura "Concoidal") (Luminiscencia "Fluorescente")(Nombre ""))
	=>(modify ?mineral (Nombre "Celestina"))
)

(defrule Olivino
	(Vidrio Si)
	?mineral<-(Mineral (Color "Verde Amarillento"|"Verde Oliva"|"Negro Verdoso"|"Ocre")(Dureza 6.75)(Habito "Masivo"| "Granular")(Fractura "Concoidal") (Luminiscencia "No Fluorescente")(Nombre ""))
	=>(modify ?mineral (Nombre "Olivino"))
)

(defrule Aragonita
	(Vidrio Si)
	?mineral<-(Mineral (Color "Incoloro"|"Blanco"|"Gris"| "Blanco Amarillento"|"Blanco Rojizo")(Dureza 3.75)(Habito "Columnar"|"Fibroso")(Fractura "Sub Concoidal") (Luminiscencia "Fluorescente"|"Fosforescente")(Nombre ""))
	=>(modify ?mineral (Nombre "Aragonita"))
)

(defrule Rodocrosita
	(Vidrio Si)
	?mineral<-(Mineral (Color "Rosado"|"Pardo"|"Gris Amarillento"|"Rojo"|"Rosado")(Dureza 3.75)(Habito "Cristalino"|"Estalactita"|"Masivo")(Fractura "Concoidal") (Luminiscencia "No Fluorescente")(Nombre ""))
	=>(modify ?mineral (Nombre "Rodocrosita"))
)

(defrule Granate1
	(Vidrio Si)
	?mineral<-(Mineral (Transparencia  "Opaco") (Luminiscencia "Ligeramente Fluorescente")(Nombre ""))
	=>(modify ?mineral (Nombre "Granate"))
)

(defrule Piroxeno2
	(Vidrio Si)
	?mineral<-(Mineral (Transparencia  "Opaco") (Luminiscencia "No Fluorescente")(Color "Negro Verdoso")(Nombre ""))
	=>(modify ?mineral (Nombre "Piroxeno"))
)

(defrule Plagioclasa
	(Vidrio Si)
	?mineral<-(Mineral (Transparencia "Opaco") (Luminiscencia "No Fluorescente")(Color "Blanco"|"Blanco Rojizo"|"Gris"|"Blanco Verdoso")(Nombre ""))
	=>(modify ?mineral (Nombre "Plagiocasa"))
)

(defrule Cuarzo
	(Vidrio Si)
	?mineral<-(Mineral (Transparencia  "Transparente") (Dureza ?dureza)(Nombre ""))
	(test (> ?dureza 5))
	(test (< ?dureza 7))
	=>(modify ?mineral (Nombre "Cuarzo"))
)

(defrule Halita
	(Vidrio Si)
	?mineral<-(Mineral (Transparencia  "Transparente") (Dureza ?dureza)(Nombre ""))
	(test (< ?dureza 2.5))
	=>(modify ?mineral (Nombre "Halita"))
)