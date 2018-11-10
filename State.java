import java.util.List;
import java.util.HashMap;
import java.util.HashSet;

public class State {
    
    public String id;
    public boolean isInitial;
    public boolean isAccepted;
    
    public boolean inicial, aceptacion;    
    HashMap<String, HashSet<State>> transitions = new HashMap<String, HashSet<State>>();

    public State(String id)
    {
        this.id = id;
        System.out.println("Creado el estado q" + id);
    }
    
    
    @Override
    public String toString(){
        return "q" + id;
    }
}
