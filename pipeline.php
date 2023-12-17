
<!DOCTYPE html> 
<html> 
      
<head> 
    <title> 
        CI/CD Pipeline
    </title> 
</head> 
  
<body> 
      
  
    <?php
        if(isset($_POST['button1'])) { 
            button1(); 
            unset($_POST['button1']);
        } 
        function button1() { 
            $output = shell_exec("./pipeline.sh dev dev");
            echo $output;
        } 
    ?> 
  
    <form method="post"> 
        <input type="submit" name="button1"
                class="button" value="Fetch, test and deploy" /> 
          
    </form>
    <script>
    if ( window.history.replaceState ) {
        window.history.replaceState( null, null, window.location.href );
    }

    </script>
</body> 
  
</html> 
