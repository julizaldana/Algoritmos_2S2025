Algoritmo BalancearInventario
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
    Escribir "Inventario actual de Acetaminofén:"
	
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
	
    // Lógica para transferencias: mover desde farmacias con exceso a las que tienen falta
    Para i <- 1 Hasta 5
        Si inventario[i] > maxIdeal Entonces
            exceso <- inventario[i] - maxIdeal
			
            Para j <- 1 Hasta 5
                Si (inventario[j] < minIdeal) Y (exceso > 0) Entonces
                    Necesario <- promedio - inventario[j] 
                    mover <- Necesario
					
                    // Si hay más exceso de lo que necesita la farmacia
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
FinAlgoritmo
