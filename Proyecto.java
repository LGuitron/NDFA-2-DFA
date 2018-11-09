import java.util.*;
import java.awt.*;

// Untitled.java
// Created by Alister Estrada Cueto on 11/2/18.

public class Proyecto {
	
	public static void main(String[] args) {
		
		Automata automata = new Automata();
		
		/*Scanner sc = new Scanner(System.in);
		LinkedHashSet<Character> set = new LinkedHashSet<Character>();
		Alfabeto Alfabeto = new Alfabeto(set);
		
		String AlfabetoString;
		String estadosString;
		String inicialString;
		String estadosFinalesPorEstado;
		
		System.out.println("Ingrese el Alfabeto aceptado");
	
		AlfabetoString = sc.nextLine();
		
		for (int i = 0; i < AlfabetoString.length() ; i++) {
			Alfabeto.simbolos.add(AlfabetoString.toCharArray()[i]);
			
		}*/
		
		/*System.out.println("Ingrese los estados ");
		estadosString = sc.nextLine();
		String[] parts = estadosString.split(" ");
		
		
		LinkedHashSet<Estado> estados = new LinkedHashSet<Estado>(); 
		for (int i = 0; i < parts.length ; i++) {
			Estado inicial = new Estado(parts[i]);
			estados.add(inicial);
		}*/

		
		/*System.out.println("Ingrese el estado inicial ");
		inicialString = sc.nextLine();		
		
		Estado inicial = new Estado(inicialString);*/
		
		/*ArrayList<Estado> list = new ArrayList<Estado>();
		ArrayList<Character> list2 = new ArrayList<Character>();
		
		list.addAll(estados);
		list2.addAll(Alfabeto.simbolos);
		
		LinkedHashSet<Transicion> tablaTransicion = new LinkedHashSet<Transicion>();
		
		for (int i = 0; i < estados.size(); i++) {		
			
			for (int j = 0; j < Alfabeto.simbolos.size() ; j++) {
				
				System.out.println("Para el estado " + list.get(i) + " leyendo " + list2.get(j) + " llega a  :" );
				estadosFinalesPorEstado = sc.nextLine();
				
				String[] parts2 = estadosFinalesPorEstado.split(" ");

				
				LinkedHashSet<Estado> estados2 = new LinkedHashSet<Estado>(); 
				for (int k = 0; k < parts2.length ; k++) {
					Estado e = new Estado(parts2[k]);
					
					
					estados2.add(e);
				}
				
				LinkedHashSet<Estado> estado3 = new LinkedHashSet<Estado>();
				estado3.add(list.get(i));
				
				Transicion Transicion = new Transicion(estado3, estados2, list2.get(j));
				
				tablaTransicion.add(Transicion);
			}
			
		}

		System.out.println("Ingrese los estado de aceptacion :");
		estadosFinalesPorEstado = sc.nextLine();
		
		String[] parts3 = estadosFinalesPorEstado.split(" ");
		
		LinkedHashSet<Estado> estadosAceptacion = new LinkedHashSet<Estado>();
		
		for (int i = 0; i < parts3.length; i++) {
			Estado e = new Estado(parts3[i]);
			estadosAceptacion.add(e);
		}
		
		Automata automata = new Automata(estados, Alfabeto, inicial, estadosAceptacion, tablaTransicion);
		
		
		System.out.println(automata.toString());*/
		
	}
	
	
	
	// Clases 
	
	public static class Alfabeto{
		private LinkedHashSet<Character> simbolos = new LinkedHashSet<Character>();

		public Alfabeto(LinkedHashSet<Character> simbolos){
			this.simbolos = simbolos;
		}
		
		@Override
		public String toString(){
			return simbolos.toString();
		}
	}
	
	
	
	public static class Automata{
		
		Scanner sc = new Scanner(System.in);
		private Alfabeto alfabeto;
		private LinkedHashSet<Estado> estados = new LinkedHashSet<Estado>(); 
		private Estado estadoInicial;
		private LinkedHashSet<Estado> estadosAceptacion = new LinkedHashSet<Estado>(); 
		private LinkedHashSet<Transicion> funcionesTransicion = new LinkedHashSet<Transicion>(); 
		
		
        ArrayList<Estado> listaEstados = new ArrayList<Estado>();
		ArrayList<Character> listaSimbolos = new ArrayList<Character>();
		
		public Automata()
		{
            insertAlfabeto();
            insertEstados();
            setEstadoInicial();
            setTransiciones();
		}
		
		
		private void insertAlfabeto()
		{
            System.out.println("Ingrese el alfabeto aceptado");
            String alfabetoString = sc.nextLine();
            
            for (int i = 0; i < alfabetoString.length() ; i++) {
                System.out.println(alfabetoString.toCharArray()[i]);
                //alfabeto.simbolos.add(alfabetoString[i]);
                alfabeto.simbolos.add(alfabetoString.toCharArray()[i]);
                
                
            }
		}
		
		private void insertEstados()
		{
            System.out.println("Ingrese los estados ");
            String estadosString = sc.nextLine();
            String[] parts = estadosString.split(" ");
            
            
            LinkedHashSet<Estado> estados = new LinkedHashSet<Estado>(); 
            for (int i = 0; i < parts.length ; i++) {
                Estado inicial = new Estado(parts[i]);
                estados.add(inicial);
            }
		}
		
		private void setEstadoInicial()
		{
            System.out.println("Ingrese el estado inicial ");
            String inicialString = sc.nextLine();		
            estadoInicial = new Estado(inicialString);
		}
		
		private void setTransiciones()
		{
            for(Estado e : estados)
            {
                System.out.println(e);
            }
            //LinkedHashSet<Transicion> tablaTransicion = new LinkedHashSet<Transicion>();
            /*for (int i = 0; i < estados.size(); i++) {		
                
                for (int j = 0; j < alfabeto.simbolos.size() ; j++) {
                    
                    System.out.println("Para el estado " + list.get(i) + " leyendo " + list2.get(j) + " llega a  :" );
                    estadosFinalesPorEstado = sc.nextLine();
                    
                    String[] estadosSeparados = estadosFinalesPorEstado.split(" ");

                    
                    LinkedHashSet<Estado> estadosDestino = new LinkedHashSet<Estado>(); 
                    for (int k = 0; k < estadosSeparados.length ; k++) {
                        Estado e = new Estado(estadosSeparados[k]);
                        
                        
                        
                        
                        
                        estadosDestino.add(e);
                    }
                    
                    LinkedHashSet<Estado> estado3 = new LinkedHashSet<Estado>();
                    estado3.add(list.get(i));
                    
                    Transicion Transicion = new Transicion(estado3, estados2, list2.get(j));
                    
                    tablaTransicion.add(Transicion);
                }
                
            }*/
		}
		
		
		
		
		/*public Automata(LinkedHashSet<Estado> estados , Alfabeto Alfabeto, Estado estadoInicial, LinkedHashSet<Estado> estadosAceptacion, LinkedHashSet<Transicion> funcionesTransicion){
			this.estados=estados;
			this.Alfabeto= Alfabeto;
			this.estadoInicial = estadoInicial;
			this.estadosAceptacion = estadosAceptacion;
			this.funcionesTransicion = funcionesTransicion;
		}*/
		
		@Override
		public String toString(){
			
			StringBuilder builder = new StringBuilder(100000);
			
			builder.append("La lista de estados en el automata es :" + estados.toString() +"\n");
			builder.append("El estado inicial del automata es " + estadoInicial.toString() +"\n");
			builder.append("Los estados de aceptacion del automata son " + estadosAceptacion.toString() +"\n");
			builder.append("El alfabeto acpetado por el autoamta es " + alfabeto.toString() +"\n");
			builder.append("La tabla de transicion del automata es "+"\n");
			builder.append("Estado Origen"  +"\t Simbolo Leido "+"\tEstado que Llega"+"\n");
			builder.append(funcionesTransicion.toString());
			
			return builder.toString();
		}
		
		public void toDeterministic(){
			System.out.println("Automata Deterministico");
			
			
		}
		
	}
	
	
	public static class Transicion{
		
		private LinkedHashSet<Estado> estadoInicial = new LinkedHashSet<Estado>();
		private LinkedHashSet<Estado> estadosFinales = new LinkedHashSet<Estado>(); 
		private char simboloLeido;
		
		public Transicion(LinkedHashSet<Estado> estadoInicial , LinkedHashSet<Estado> estadosFinales, char simboloLeido){
			this.estadoInicial = estadoInicial;
			this.estadosFinales = estadosFinales;
			this.simboloLeido = simboloLeido;
		}
		
		@Override 
		public String toString(){
			
			StringBuilder builder = new StringBuilder(100000);
			
			
			builder.append(estadoInicial.toString() +"\t\t"+ simboloLeido + "\t\t"+estadosFinales.toString()+"\n");
			
			return builder.toString();
		}
		
		
		
	}
	
	public static class Estado{
		
		
		private  String nombreDelEstado;
		private Transicion[] transiciones;
		private LinkedHashSet<Estado> subestados;
 		
		public Estado(String nombreDelEstado){
			this.nombreDelEstado=nombreDelEstado;
		}
		
		
		
		
		@Override
		public boolean equals(Object other) {
			
			return ((Estado)other).nombreDelEstado.equals(this.nombreDelEstado);   
			
		}

		@Override
		public int hashCode() {
			return this.nombreDelEstado.hashCode();
		}
		
		
		@Override
		public String toString(){				
			return nombreDelEstado ;
		}
		
	}
	
}
