public class Main 
{
    public static void main(String args[]) 
    {
        Automata automata = new Automata();
        automata.createStates();
        automata.setInitialState();
        automata.setAcceptanceStates();
        automata.setAlphabet();
        automata.setTransitionTable();
        automata.convertToDFA();
        System.out.print(automata);
    }
}
