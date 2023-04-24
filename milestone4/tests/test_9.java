public class alpha {
    public int val1;
}
public class beta {
    private int val2;
}

public class test_9 {
    public void main(){
        alpha a = new alpha();
        beta b = new beta();
        a.val1 = 100;
        // b.val2 = 2;
        int ans = a.val1;
        System.out.println(ans);
    }
}
