// SubProceso 1: Dijkstra
SubProceso BuscarRutaMasBarata
    Escribir "Ejecutando algoritmo de Dijkstra (ruta más barata)..."
    
	Definir i, j, origen, destino, min, nodoMin, costoTotal Como Entero
    
    // Declarar matrices y vectores
    Dimension costos[6,6]
    Dimension dist[6]
    Dimension visitado[6]
    Dimension previo[6]
	
	costos[1,1] <- 0
	costos[1,2] <- 50
	costos[1,3] <- 40
	costos[1,4] <- 60
	costos[1,5] <- 120
	
	costos[2,1] <- 50
	costos[2,2] <- 0
	costos[2,3] <- 30
	costos[2,4] <- 25
	costos[2,5] <- 40
	
	costos[3,1] <- 40
	costos[3,2] <- 30
	costos[3,3] <- 0
	costos[3,4] <- 35
	costos[3,5] <- 40
	
	costos[4,1] <- 60
	costos[4,2] <- 25
	costos[4,3] <- 35
	costos[4,4] <- 0
	costos[4,5] <- 45
	
	costos[5,1] <- 120
	costos[5,2] <- 80
	costos[5,3] <- 40
	costos[5,4] <- 45
	costos[5,5] <- 0
	
    // Leer datos
    Escribir "=== BUSCAR RUTA MAS BARATA ==="
    Escribir "Ingrese numero de farmacia origen (1-5):"
    Leer origen
    Escribir "Ingrese numero de farmacia destino (1-5):"
    Leer destino
	
    // Inicializar distancias
    Para i <- 1 Hasta 5
        dist[i] <- 9999  // Valor infinito
        visitado[i] <- 0
        previo[i] <- -1
    Fin Para
	
    dist[origen] <- 0
	
    // Algoritmo Dijkstra
    Para i <- 1 Hasta 5
        // Encontrar nodo no visitado con menor distancia
        min <- 9999
        nodoMin <- -1
        Para j <- 1 Hasta 5
            Si (visitado[j] = 0) Y (dist[j] < min) Entonces
                min <- dist[j]
                nodoMin <- j
            Fin Si
        Fin Para
		
        Si nodoMin = -1 Entonces
			i <- 6  // forzar salida del ciclo Para (que va de 1 a 5)
		Fin Si
		
		
        visitado[nodoMin] <- 1
		
        // Actualizar vecinos
        Para j <- 1 Hasta 5
            Si (visitado[j] = 0) Y (dist[nodoMin] + costos[nodoMin, j] < dist[j]) Entonces
                dist[j] <- dist[nodoMin] + costos[nodoMin, j]
                previo[j] <- nodoMin
            Fin Si
        Fin Para
    Fin Para
	
    // Mostrar resultado
    Escribir "RUTA ENCONTRADA:"
    Escribir "Costo total: Q", dist[destino]
	
    // Mostrar la ruta
    Definir index Como Entero
	Dimension ruta[6]
	
    index <- 1
    j <- destino
    Mientras j <> -1
        ruta[index] <- j
        index <- index + 1
        j <- previo[j]
    Fin Mientras
	
    Para i <- index - 1 Hasta 1 Con Paso -1
        Segun ruta[i]
            1: Escribir Sin Saltar "Central"
            2: Escribir Sin Saltar " -> Norte"
            3: Escribir Sin Saltar " -> Sur"
            4: Escribir Sin Saltar " -> Este"
            5: Escribir Sin Saltar " -> Oeste"
        Fin Segun
    Fin Para
	
FinSubProceso

// SubProceso 2: Inventario
SubProceso BalancearInventarios
    Escribir "Ejecutando algoritmo de balanceo de inventarios..."
    
	Definir i, total, promedio, minIdeal, maxIdeal Como Entero
    Definir exceso Como Entero
    Dimension inventario[6]
    Dimension nombreFarmacia[6]
    
    // Nombres
    nombreFarmacia[1] <- "Central"
    nombreFarmacia[2] <- "Norte"
    nombreFarmacia[3] <- "Sur"
    nombreFarmacia[4] <- "Este"
    nombreFarmacia[5] <- "Oeste"
    
    // Inventarios actuales (puedes cambiarlos luego por Lectura)
    inventario[1] <- 500
    inventario[2] <- 20
    inventario[3] <- 150
    inventario[4] <- 180
    inventario[5] <- 50
	
    Escribir "=== BALANCEAR INVENTARIOS ==="
    Escribir "Inventario actual de Acetaminof?n:"
	
    // Calcular total
    total <- 0
    Para i <- 1 Hasta 5
        total <- total + inventario[i]
    Fin Para
	
    // Calcular promedio
    promedio <- trunc(total / 5)
    minIdeal <- trunc(promedio * 0.8)
    maxIdeal <- trunc(promedio * 1.2)
	
    // Mostrar estado actual
    Para i <- 1 Hasta 5
        Escribir "- Farmacia ", nombreFarmacia[i], ": ", inventario[i], " cajas (";
        Si inventario[i] < minIdeal Entonces
            Escribir Sin Saltar "FALTA)"
        Sino
            Si inventario[i] > maxIdeal Entonces
                Escribir Sin Saltar "EXCESO)"
            Sino
                Escribir Sin Saltar "OK)"
            Fin Si
        Fin Si
    Fin Para
	
    Escribir ""
    Escribir "Promedio ideal: ", promedio, " cajas por farmacia"
    Escribir ""
    Escribir "TRANSFERENCIAS RECOMENDADAS:"
	
    // L?gica para transferencias: mover desde farmacias con exceso a las que tienen falta
    Para i <- 1 Hasta 5
        Si inventario[i] > maxIdeal Entonces
            exceso <- inventario[i] - maxIdeal
			
            Para j <- 1 Hasta 5
                Si (inventario[j] < minIdeal) Y (exceso > 0) Entonces
                    Necesario <- promedio - inventario[j] 
                    mover <- Necesario
					
                    // Si hay m?s exceso de lo que necesita la farmacia
                    Si exceso < Necesario Entonces
                        mover <- exceso
                    Fin Si
					
                    Escribir "- Mover ", mover, " cajas de ", nombreFarmacia[i], " a ", nombreFarmacia[j]
                    inventario[i] <- inventario[i] - mover
                    inventario[j] <- inventario[j] + mover
                    exceso <- exceso - mover
                Fin Si
            Fin Para
        Fin Si
    Fin Para
	
FinSubProceso

// SubProceso 3: Predicción de ventas
SubProceso PredecirVentas
	Dimension ventas[5]
    Definir prediccion Como Real
    Definir i Como Entero
	
    Escribir "=== PREDICCION DE VENTAS ==="
    Escribir "Medicamento: Jarabe para la tos"
    Escribir "Farmacia: Norte"
    Escribir ""
    
    // Leer ventas de los ultimos 4 meses
    Para i <- 1 Hasta 4
        Escribir "Ingrese ventas de hace ", 5 - i, " mes(es): "
        Leer ventas[i]
    Fin Para
    
    Escribir ""
    Escribir "Ventas anteriores:"
    Para i <- 1 Hasta 4
        Escribir "- Hace ", 5 - i, " meses: ", ventas[i], " unidades"
    Fin Para
    
    // Calcular prediccion usando media ponderada
    prediccion <- (ventas[4] * 0.4) + (ventas[3] * 0.3) + (ventas[2] * 0.2) + (ventas[1] * 0.1)
    
    Escribir ""
    Escribir "PREDICCION para pr?ximo mes: ", Trunc(prediccion), " unidades"
    Escribir "(Calculo: ", ventas[4], "×0.4 + ", ventas[3], "×0.3 + ", ventas[2], "×0.2 + ", ventas[1], "×0.1)"
FinSubProceso

// SubProceso 4: Ver datos de farmacias
SubProceso VerDatosFarmacias
    Escribir "=== DATOS DE FARMACIAS ==="
    Escribir "1. Farmacia Central - Zona 1"
    Escribir "2. Farmacia Norte - Zona 17"
    Escribir "3. Farmacia Sur - Zona 12"
    Escribir "4. Farmacia Este - Zona 10"
    Escribir "5. Farmacia Oeste - Mixco"
FinSubProceso



Algoritmo MenuFarmacia
	
    Definir opcion Como Entero
	
    Repetir
        Escribir "====================================="
        Escribir "    SISTEMA FARMACIA LA SALUD"
        Escribir "====================================="
        Escribir "1. Buscar ruta más barata"
        Escribir "2. Balancear inventarios"
        Escribir "3. Predecir ventas"
        Escribir "4. Ver datos de farmacias"
        Escribir "5. Salir"
        Escribir "====================================="
        Escribir "Ingrese opción: "
        Leer opcion
		
        Segun opcion Hacer
            1:
                BuscarRutaMasBarata
            2:
                BalancearInventarios
            3:
                PredecirVentas
            4:
                VerDatosFarmacias
            5:
                Escribir "Saliendo del sistema..."
            De Otro Modo:
                Escribir "Opción inválida. Intente de nuevo."
        FinSegun
		
        Escribir ""
        Escribir "Presione ENTER para continuar..."
        
		
    Hasta Que opcion = 5
	
FinAlgoritmo
