Algoritmo PredecirVentas
	
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
    Escribir "PREDICCION para pr�ximo mes: ", Trunc(prediccion), " unidades"
    Escribir "(Calculo: ", ventas[4], "×0.4 + ", ventas[3], "×0.3 + ", ventas[2], "×0.2 + ", ventas[1], "×0.1)"
    
FinAlgoritmo
