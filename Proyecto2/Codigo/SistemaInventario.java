import java.util.Scanner;

public class SistemaInventario {

    // Variables globales
    static final int MAX_PRODUCTOS = 1000;
    static String[] codigos = new String[MAX_PRODUCTOS];
    static String[] nombres = new String[MAX_PRODUCTOS];
    static double[] precios = new double[MAX_PRODUCTOS];
    static int[] cantidades = new int[MAX_PRODUCTOS];
    static int[] vendidos = new int[MAX_PRODUCTOS];
    static int productos = 0;

    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        boolean salir = false;

        while (!salir) {
            mostrarMenu();

            if (scanner.hasNextInt()) {
                int opcion = scanner.nextInt();
                scanner.nextLine(); // Limpiar el buffer

                switch (opcion) {
                    case 1:
                        agregarProducto(scanner);
                        break;
                    case 2:
                        venderProducto(scanner);
                        break;
                    case 3:
                        verInventario();
                        break;
                    case 4:
                        mostrarReportes();
                        break;
                    case 5:
                        // mostrarEstadisticas();
                        break;
                    case 6:
                        salir = true;
                        break;
                    default:
                        System.out.println("Opción inválida");
                }
            } else {
                System.out.println("Error: Ingrese solo números");
                scanner.nextLine(); // limpiar entrada incorrecta
            }
        }
    }

    public static void mostrarMenu() {
        System.out.println("=================================");
        System.out.println("    TIENDA UNIVERSITARIA USAC");
        System.out.println("=================================");
        System.out.println("1. Agregar Producto Nuevo");
        System.out.println("2. Vender Producto");
        System.out.println("3. Ver Inventario");
        System.out.println("4. Reportes");
        System.out.println("5. Estadísticas");
        System.out.println("6. Salir");
        System.out.println("=================================");
        System.out.print("Ingrese opción: ");
    }


    //FUNCION 1: AGREGAR PRODUCTO
    public static void agregarProducto(Scanner scanner) {
        if (productos >= MAX_PRODUCTOS) {
            System.out.println("Inventario lleno");
            return;
        }

        System.out.println("\n--- AGREGAR PRODUCTO ---");

        // Leer código
        System.out.print("Código (5 dígitos): ");
        String codigo = scanner.nextLine();

        if (codigo.length() != 5 || !codigo.matches("\\d{5}")) {
            System.out.println("Error: Código debe tener 5 dígitos");
            return;
        }

        // Verificar duplicado
        for (int i = 0; i < productos; i++) {
            if (codigos[i].equals(codigo)) {
                System.out.println("Error: Código duplicado");
                return;
            }
        }

        // Convertir a binario
        int codigoInt = Integer.parseInt(codigo);
        String binario = convertirABinario(codigoInt);
        System.out.println("[Convirtiendo a binario: " + binario + "]");
        System.out.println("[Validando código... ✓]");

        // Leer nombre
        System.out.print("Nombre del producto: ");
        String nombre = scanner.nextLine();

        // Leer precio
        System.out.print("Precio (Q): ");
        if (!scanner.hasNextDouble()) {
            System.out.println("Error: Precio inválido");
            scanner.nextLine(); // limpiar
            return;
        }

        double precio = scanner.nextDouble();
        scanner.nextLine(); // limpiar

        if (precio <= 0) {
            System.out.println("Error: Precio inválido");
            return;
        }

        // Leer cantidad
        System.out.print("Cantidad inicial: ");
        if (!scanner.hasNextInt()) {
            System.out.println("Error: Cantidad inválida");
            scanner.nextLine(); // limpiar
            return;
        }

        int cantidad = scanner.nextInt();
        scanner.nextLine(); // limpiar

        if (cantidad <= 0) {
            System.out.println("Error: Cantidad inválida");
            return;
        }

        // Guardar en arreglos
        codigos[productos] = codigo;
        nombres[productos] = nombre;
        precios[productos] = precio;
        cantidades[productos] = cantidad;
        vendidos[productos] = 0;
        productos++;

        System.out.println("✓ Producto agregado exitosamente\n");
    }

    //FUNCION AUXILIAR para convertir un entero a binario.
    public static String convertirABinario(int numero) {
        return Integer.toBinaryString(numero);
    }


    //FUNCION AUXILIAR para buscar un producto por medio de un codigo.
    public static int buscarProducto(String codigoBuscar) {
        for (int i = 0; i < productos; i++) {
            if (codigos[i].equals(codigoBuscar)) {
                return i;
            }
        }
        return -1;
    }

    
    //FUNCION 2: VENDER PRODUCTO
    public static void venderProducto(Scanner scanner) {
        if (productos == 0) {
            System.out.println("No hay productos en el inventario");
            return;
        }

        System.out.println("\n--- VENDER PRODUCTO ---");
        System.out.print("Ingrese código: ");
        String codigoBuscar = scanner.nextLine();

        int posicion = buscarProducto(codigoBuscar);

        if (posicion != -1) {
            System.out.println("Producto: " + nombres[posicion]);
            System.out.println("Precio: Q" + precios[posicion]);
            System.out.println("Stock: " + cantidades[posicion]);

            if (cantidades[posicion] > 0) {
                System.out.print("¿Cuántos desea vender?: ");
                if (!scanner.hasNextInt()) {
                    System.out.println("Error: Cantidad inválida");
                    scanner.nextLine(); // limpiar
                    return;
                }

                int cantidadVender = scanner.nextInt();
                scanner.nextLine(); // limpiar

                if (cantidadVender <= 0) {
                    System.out.println("Error: Debe vender al menos 1 unidad");
                    return;
                }

                if (cantidadVender <= cantidades[posicion]) {
                    cantidades[posicion] -= cantidadVender;
                    vendidos[posicion] += cantidadVender;

                    double total = cantidadVender * precios[posicion];
                    System.out.println("✓ Venta exitosa");
                    System.out.println("Total: Q" + total);

                    if (cantidades[posicion] < 10) {
                        System.out.println("⚠️ ALERTA: Stock bajo!");
                        System.out.println("Quedan: " + cantidades[posicion]);
                    }
                } else {
                    System.out.println("Error: Stock insuficiente");
                }

            } else {
                System.out.println("Sin stock disponible");
            }

        } else {
            System.out.println("Producto no encontrado");
        }
    }


    //FUNCION 3: VER INVENTARIOS
    public static void verInventario() {
        System.out.println("===========================================");
        System.out.printf("%-8s | %-15s | %-6s | %-5s\n", "CÓDIGO", "NOMBRE", "PRECIO", "STOCK");
        System.out.println("===========================================");

        double valorTotalInventario = 0;

        for (int i = 0; i < productos; i++) {
            System.out.printf("%-8s | %-15s | Q%-5.2f | %-5d\n", 
                codigos[i], nombres[i], precios[i], cantidades[i]);
            valorTotalInventario += precios[i] * cantidades[i];
        }

        System.out.println("===========================================");
        System.out.println("Total productos: " + productos);
        System.out.printf("Valor total inventario: Q%,.2f\n", valorTotalInventario);
    }


    public static void mostrarReportes() {
        if (productos > 0) {
            System.out.println("=== REPORTES ===");

            // 1. Producto más vendido
            int maxVendido = vendidos[0];
            int posMaxVendido = 0;

            for (int i = 1; i < productos; i++) {
                if (vendidos[i] > maxVendido) {
                    maxVendido = vendidos[i];
                    posMaxVendido = i;
                }
            }

            System.out.println("1. PRODUCTO MÁS VENDIDO:");
            System.out.println(nombres[posMaxVendido] + " (" + maxVendido + " unidades)");

            // 2. Producto con menos stock
            int minStock = cantidades[0];
            int posMinStock = 0;

            for (int i = 1; i < productos; i++) {
                if (cantidades[i] < minStock) {
                    minStock = cantidades[i];
                    posMinStock = i;
                }
            }

            System.out.println("2. PRODUCTO CON MENOS STOCK:");
            System.out.println(nombres[posMinStock] + " (" + minStock + " unidades)");

            // 3. Valor total del inventario
            double valorTotal = 0;
            for (int i = 0; i < productos; i++) {
                valorTotal += precios[i] * cantidades[i];
            }
            System.out.printf("3. VALOR TOTAL DEL INVENTARIO: Q%,.2f\n", valorTotal);

            // 4. Productos por agotarse (stock < 10)
            System.out.println("4. PRODUCTOS POR AGOTARSE (menos de 10):");
            boolean hayProductosBajos = false;

            for (int i = 0; i < productos; i++) {
                if (cantidades[i] < 10) {
                    System.out.println("- " + nombres[i] + ": " + cantidades[i]);
                    hayProductosBajos = true;
                }
            }

            if (!hayProductosBajos) {
                System.out.println("Ningún producto con stock bajo");
            }

        } else {
            System.out.println("No hay datos para reportes");
        }
    }



}
