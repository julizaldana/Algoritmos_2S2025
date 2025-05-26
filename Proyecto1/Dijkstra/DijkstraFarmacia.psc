Algoritmo DijkstraFarmacia
	
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
	
FinAlgoritmo
