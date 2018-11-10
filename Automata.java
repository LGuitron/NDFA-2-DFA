import java.util.ArrayList;
import java.util.Scanner;
import java.util.HashSet;

public class Automata {

    private Scanner scanner;
    private String[] alphabet;
    private HashSet<HashSet<State>> statesDFA;
    public ArrayList<State> statesNDFA;
    HashSet<State> initialState;
    HashSet<State> finalStates;
    
    public Automata()
    {
        statesNDFA = new ArrayList<State>();
        scanner = new Scanner(System.in);
    }
    
    //Create states from 0 to n-1 with console input
    public void createStates()
    {
        System.out.println("Cuantos estados tiene su AFND?");
        int stateAmount = scanner.nextInt();
        for (int i = 0; i < stateAmount; i++) {
            State state = new State(Integer.toString(i));
            statesNDFA.add(state);
        }
    }
    
    // Create states from processing GUI
    public String createStatesGUI(int stateAmount)
    {
        statesNDFA = new ArrayList<State>();
        for (int i = 0; i < stateAmount; i++) {
            State state = new State(Integer.toString(i));
            statesNDFA.add(state);
        }
        return statesNDFA.toString();
    }
    
    
    
    // Ask for initial state index in console
    public void setInitialState()
    {
        System.out.println("Coloque el indice del estado inicial:");
        int in = scanner.nextInt();
        scanner.nextLine();
        initialState = new HashSet<State>();
        initialState.add(statesNDFA.get(in));
    }
    
    // Ask for initial state index in GUI
    public String setInitialStateGUI(int index)
    {
        initialState = new HashSet<State>();
        initialState.add(statesNDFA.get(index));
        for(State state : initialState)
        {
          return state.toString();
        }
        return "";
    }
    
    // Ask for amount and indices of acceptance states separated by comma
    public void setAcceptanceStates()
    {
        System.out.println("Introduzca los indices de los estados de aceptacion separados por comas: ");
        String indices = scanner.nextLine();
        String[] indicesArr = indices.split(","); 
        finalStates = new HashSet<State>();
    
        for (String index : indicesArr)
        {
            finalStates.add(statesNDFA.get(Integer.parseInt(index)));
        }
    }
    
     // Get acceptance states from GUI
    public String setAcceptanceStatesGUI(String indices)
    {
        String[] indicesArr = indices.split(","); 
        finalStates = new HashSet<State>();
    
        for (String index : indicesArr)
        {
          
            finalStates.add(statesNDFA.get(Integer.parseInt(index)));
        }
        return finalStates.toString();
    }
    
    
    // Ask for amount and elements of the alphabet separated by comma
    public void setAlphabet()
    {
        System.out.println("Introduzca los simbolos del alfabeto separados por coma:");
        String symbols = scanner.nextLine();
        alphabet = symbols.split(","); 
    }
    
    // Ask for alphabet elements in GUI
    public String setAlphabetGUI(String symbols)
    {
        alphabet = symbols.split(","); 
        return "[" + symbols + "]";
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
    
    // Helper function to check a state in the state set is final
    private boolean hasFinalState(HashSet<State> originSet)
    {
        for (State finalState : finalStates)
        {
            if (originSet.contains(finalState))
                return true;
        }
        return false;
    }
    
    @Override
    public String toString()
    {
        String result = "\n";
        result += "----\n";
        result += "NDFA\n";
        result += "----\n\n";
        
        for (State state : statesNDFA)
        {
            HashSet<State> originSet = new HashSet<State>();
            originSet.add(state);
            
            for (State inState : initialState)
            {
                //Check if state is initial
                if(state==inState)
                    result += "->";
                else
                    result += "  ";
                break;
            }
            
            //Check if state is final
            if (hasFinalState(originSet))
                result+="*";
            else
                result+=" ";
            
            result+= state;
            result += " | ";
            
            
            for (String symbol : alphabet)
            {


                
                result += symbol + ": ";
                result += findDestinationSetWithSymbol(originSet, symbol);
                result += " | ";
            }
            result += "\n";
        }
        
        result += "\n---\n";
        result += "DFA\n";
        result += "---\n\n";
        
        int newStateIndex = 0;
        for (HashSet<State> originSet : statesDFA)
        {
            //Check if state is initial
            if (originSet == initialState)
                result += "->";
            else
                result += "  ";
            
            //Check if state is final
            if (hasFinalState(originSet))
                result+="*";
            else
                result+=" ";
            
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
