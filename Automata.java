import java.util.ArrayList;
import java.util.List;
import java.util.Scanner;
import java.util.HashSet;

public class Automata {

    private Scanner scanner;
    private String[] alphabet;
    private HashSet<HashSet<State>> statesDFA;
    private ArrayList<State> statesNDFA;
    HashSet<State> initialState;
    
    
    public Automata()
    {
        scanner = new Scanner(System.in);
    }
    
    //Create states from 0 to n-1 with user input
    public void createStates()
    {
        System.out.println("Cuantos estados tiene su AFND?");
        int stateAmount = scanner.nextInt();
        
        statesNDFA = new ArrayList<State>();
        for (int i = 0; i < stateAmount; i++) {
            State state = new State(Integer.toString(i));
            statesNDFA.add(state);
        }
    }
    
    // Ask for initial state index
    public void setInitialState()
    {
        System.out.println("Coloque el indice del estado inicial:");
        int in = scanner.nextInt();
        scanner.nextLine();
        statesNDFA.get(in).inicial = true;
        initialState = new HashSet<State>();
        initialState.add(statesNDFA.get(in));
    }
    
    // Ask for amount and indices of acceptance states separated by comma
    public void setAcceptanceStates()
    {
        //Pedimos el estado de aceptacion
        System.out.println("Coloque el indice del estado de aceptacion: ");
        int ac = scanner.nextInt();
        scanner.nextLine();
        statesNDFA.get(ac).aceptacion = true;
    }
    
    // Ask for amount and elements of the alphabet separated by comma
    public void setAlphabet()
    {
        System.out.println("Introduzca los simbolos del alfabeto separados por coma:");
        String symbols = scanner.nextLine();
        alphabet = symbols.split(","); 
    }
    
    public void setTransitionTable()
    {
        for (int i = 0; i < statesNDFA.size(); i++) 
        {
            for (String symbol : alphabet)
            {
                System.out.println("El estado q" + i + " Tiene transiciones con: " + symbol + " y/n");
                String ans = scanner.nextLine();

                if (ans.equals("y")) {

                    System.out.println("Escriba el numero de estados de la transicion: ");
                    int tranLen = scanner.nextInt();
                    scanner.nextLine();

                    System.out.println("Introduzca el indice de los estados a los que va separados por coma: ");
                    String destinationIndices      = scanner.nextLine();
                    String[] destinationIndicesArr = destinationIndices.split(",");

                    HashSet<State> destinations = new HashSet<State>();
                    for (String index : destinationIndicesArr)
                    {
                        destinations.add(statesNDFA.get(Integer.parseInt(index)));
                    }
                    statesNDFA.get(i).transitions.put(symbol, destinations);
                }
            }
        }
    }
    
    public void convertToDFA()
    {
        statesDFA = new HashSet<HashSet<State>>();
        statesDFA.add(initialState);
        findDestinationSet(initialState);
    }
    
    // Function to get Destination Set of a Given Origin Set
    private void findDestinationSet(HashSet<State> originSet)
    {
        for (String symbol : alphabet)
        {
            /*HashSet<State> destinationSet= new HashSet<State>();
            
            // Find destination set as Union of all destinationSets of all originStates in this Set when receiving a specific symbol
            for (State originState : originSet)
            {
                if(originState.transitions.containsKey(symbol))
                    destinationSet.addAll(originState.transitions.get(symbol));
            }*/
            HashSet<State> destinationSet = findDestinationSetWithSymbol(originSet, symbol);
            
            // If this element is not already contained add elements to the DFA Origin Set
            if(!statesDFA.contains(destinationSet) && destinationSet.size()>0)
            {
                statesDFA.add(destinationSet);
                findDestinationSet(destinationSet);
            }
        }
    }
    
    // Helper function for getting resulting set given an origin set and an input
    private HashSet<State> findDestinationSetWithSymbol(HashSet<State> originSet, String symbol)
    {
        HashSet<State> destinationSet= new HashSet<State>();

        // Find destination set as Union of all destinationSets of all originStates in this Set when receiving a specific symbol
        for (State originState : originSet)
        {
            if(originState.transitions.containsKey(symbol))
                destinationSet.addAll(originState.transitions.get(symbol));
        }
        return destinationSet;
    }
    
    
    @Override
    public String toString()
    {
        String result = "";
        result += "---\n";
        result += "DFA\n";
        result += "---\n\n";
        
        int newStateIndex = 0;
        for (HashSet<State> originSet : statesDFA)
        {
            result += "c" + newStateIndex + " | ";
            result += originSet;
            result += " | ";
            
            for (String symbol : alphabet)
            {
                result += symbol + ": ";
                result += findDestinationSetWithSymbol(originSet, symbol);
                result += " | ";
            }
            
            result += "\n";
            newStateIndex++;
        }

        return result;
    }
    
    
}