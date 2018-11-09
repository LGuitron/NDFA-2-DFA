
import java.util.ArrayList;
import java.util.List;
import java.util.Scanner;

public class Main {

    private static int es, lenSize;

    public static void main(String args[]) {

        //Creamos el scanner para recibir inputs
        Scanner sc = new Scanner(System.in);
        //Preguntamos por el número de nodos
        System.out.println("¿Cuántos estados tiene su AFND?");
        es = sc.nextInt();
        //Creamos los estados
        List<Estado> estados = new ArrayList<Estado>();
        for (int i = 0; i < es; i++) {
            Estado e = new Estado();
            e.id = "" + i;
            e.transiciones = new ArrayList();
            System.out.println("Creado el estado Q" + i);
            estados.add(e);
        }
        //Pedimos que se indique el estado inicial
        System.out.println("Coloque el índice del estado inicial:");
        int in = sc.nextInt();
        estados.get(in).inicial = true;
        //Pedimos el estado de aceptación
        System.out.println("Coloque el índice del estado de aceptación:");
        int ac = sc.nextInt();
        estados.get(ac).aceptacion = true;
        //Preguntamos por el número de símbolos del alfabetoo
        System.out.println("Escriba el tamaño del alfabeto");
        lenSize = sc.nextInt();
        sc.nextLine();
        //Pedimos que se introduzcan todos separados por coma
        System.out.println("Introduzca los simbolos del alfabeto separados por coma");
        String tmp = sc.nextLine();
        //Los separamos y los agregamos a un arreglo
        String[] len = new String[lenSize];
        Scanner s = new Scanner(tmp).useDelimiter("(\\p{javaWhitespace}|\\,)+");
        for (int i = 0; i < lenSize; i++) {
            String a = s.next();
            if (a != null) {
                len[i] = a;
            } else {
                System.out.println("Cuidado, no hay nada");
            }
        }
        s.close();

        for (int i = 0; i < estados.size(); i++) {

            for (int a = 0; a < lenSize; a++) {

                System.out.println("El estado Q" + i + " Tiene transiciones con: " + len[a] + " y/n");
                String ans = sc.nextLine();

                if (ans.equals("y")) {

                    System.out.println("Escriba el numero de estados de la transicion: ");
                    int tranLen = sc.nextInt();
                    sc.nextLine();

                    System.out.println("Introduzca el indice de los estados a los que va separados por coma: ");
                    String esTemp = sc.nextLine();

                    Transicion tran = new Transicion();
                    tran.simbolo = len[a];
                    tran.desitnos = new ArrayList();

                    Scanner t = new Scanner(esTemp).useDelimiter("(\\p{javaWhitespace}|\\,)+");
                    for (int j = 1; j <= tranLen; j++) {
                        String q = t.next();
                        if (q != null) {
                            int qint = Integer.parseInt(q);
                            tran.desitnos.add(estados.get(qint));
                            j++;
                        } else {
                            System.out.println("Cuidado, no hay nada");
                        }
                    }
                    estados.get(i).transiciones.add(tran);
                    System.out.println(estados.get(i).transiciones);
                    t.close();
                }
            }

        }
    }
}
