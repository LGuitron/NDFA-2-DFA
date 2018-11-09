
import java.util.ArrayList;
import java.util.List;
import java.util.Scanner;

public class Main {

    private static int es, lenSize;

    public static void main(String args[]) {

        //Creamos el scanner para recibir inputs
        Scanner sc = new Scanner(System.in);
        //Preguntamos por el numero de nodos
        System.out.println("Cuantos estados tiene su AFND?");
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
        System.out.println("Coloque el indice del estado inicial:");
        int in = sc.nextInt();
        estados.get(in).inicial = true;
        //Pedimos el estado de aceptacion
        System.out.println("Coloque el indice del estado de aceptacion:");
        int ac = sc.nextInt();
        estados.get(ac).aceptacion = true;
        //Preguntamos por el numero de simbolos del alfabetoo
        System.out.println("Escriba el tamanio del alfabeto");
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
        
        
        int counter = 0;
        
        ArrayList<ArrayList<Estado>> estadosDFA = new ArrayList<ArrayList<Estado>>();
        ArrayList<Estado> inicial = new ArrayList<Estado>();

        inicial.add(estados.get(in));
        estadosDFA.add(inicial);
        
        while(counter < estadosDFA.size())
        {   
            ArrayList<Estado> estadoDestino = new ArrayList<Estado>();
            ArrayList<Estado> listEstado = estadosDFA.get(counter);
            for (Estado estado : listEstado)
            {
                for (String symbol : len)
                {
                    // Iterate transitions for this state
                    for (Transicion trans : estado.transiciones)
                    {
                        if(symbol == trans.simbolo)
                        {
                            
                            for(Estado destino : trans.desitnos)
                            {
                                if(!estadoDestino.contains(destino))
                                {
                                    estadoDestino.add(destino);
                                }

                            }
                        }
                    }
                }
            }
            counter++;
        }
        
        
        // Imprime resultado
        for (ArrayList<Estado> listaEstado : estadosDFA)
        {
            String estadosOrigen = "";
            for (Estado estado : listaEstado)
            {
                estadosOrigen += estado.id + ", ";
            }
            
            
            System.out.println("Origen: " + estadosOrigen);
            for (String symbol : len)
            {
                ArrayList<Estado> estadoDestino = new ArrayList<Estado>();
                for (Estado estado : listaEstado)
                {
                    // Iterate transitions for this state
                    for (Transicion trans : estado.transiciones)
                    {
                        if(symbol == trans.simbolo)
                        {
                            
                            for(Estado destino : trans.desitnos)
                            {
                                if(!estadoDestino.contains(destino))
                                {
                                    estadoDestino.add(destino);
                                }

                            }
                        }
                    }
                }
                System.out.println(symbol);
                for (Estado e : estadoDestino)
                {
                    System.out.println(e.id);
                }
                System.out.println();
            }
        }
    }
}
