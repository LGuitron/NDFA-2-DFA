import java.util.List;

public class Estado {
    
    public String id;
    public boolean inicial, aceptacion;
    List<Transicion> transiciones;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }
}
