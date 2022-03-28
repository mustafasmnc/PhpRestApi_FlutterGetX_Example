<?php

class Category{
    //DB Stuff
    private $conn;
    private $table='categories';

    //CAtegory Properties
    public $id;
    public $name;
    
    //Constructor with DB
    public function __construct($db){
        $this->conn=$db;
    }

    //get categories
    public function read(){
        //create query
        $query='SELECT 
                c.id,
                c.name 
            FROM '.$this->table.' c
            ORDER BY c.created_at 
            ASC';

        //Prepare statement
        $stmt=$this->conn->prepare($query);

        //Execute query
        $stmt->execute();

        return $stmt;
    }

    //Get single category
    public function read_single(){
         //create query
        $query='SELECT 
                c.id,
                c.name 
            FROM '.$this->table.' c
            WHERE
                c.id=:id
            LIMIT 0,1';

        //Prepare statement
        $stmt=$this->conn->prepare($query);

        //Bind ID
        $stmt->bindParam(':id', $this->id);

        //Execute query
        $stmt->execute();

        $row=$stmt->fetch(PDO::FETCH_ASSOC);

        //Set Properties
        $this->id=$row['id'];
        $this->name=$row['name'];
    }

    //Create category
    public function create(){
        //Create query
        $query='INSERT INTO '.$this->table.'
            SET 
                name=:name';

        //Prepare statement
        $stmt=$this->conn->prepare($query);

        //Clean data
        $this->name=htmlspecialchars(strip_tags($this->name));

        //Bind data
        $stmt->bindParam(':name',$this->name);

        //Execute query
        if($stmt->execute()){
            return true;
        }
        
        //Print error if something goes wrong
        printf("Error: %s.\n",$stmt->error);
        
        return false;

    }

    //update category
    public function update(){
        //Create query
        $query='UPDATE '. $this->table .' 
            SET
                name=:name
            WHERE
                id=:id';

        //Prepare statement
        $stmt=$this->conn->prepare($query);

        //Clean data
        $this->name=htmlspecialchars(strip_tags($this->name));

        //Bind data
        $stmt->bindParam(':name',$this->name);
        $stmt->bindParam(':id',$this->id);

        //Execute query
        if($stmt->execute()){
            return true;
        }
        
        //Print error if something goes wrong
        printf("Error: %s.\n",$stmt->error);
        
        return false;
    }

    //delete category
    public function delete(){
        
        $query='DELETE FROM '. $this->table .' 
        WHERE
        id=:id';

        //Prepare statement
        $stmt=$this->conn->prepare($query);

        //Clean data
        $this->id=htmlspecialchars(strip_tags($this->id));

        //Bind data
        $stmt->bindParam(':id',$this->id);

        //Execute query
        if($stmt->execute()){
        return true;
        }

        //Print error if something goes wrong
        printf("Error: %s.\n",$stmt->error);

        return false;
        
    }

    //Check ID in database
    public function checkID($myID){
        //Create query
        $query='SELECT id FROM '. $this->table .' 
            WHERE 
                id='. $myID .'';
        
        //Prepare statement
        $stmt=$this->conn->prepare($query);

        //Execute query
        $stmt->execute();
        
        $row=$stmt->fetch(PDO::FETCH_ASSOC);

        if($row){
            return true;
        }else{
            return false;
        }
    }
}

?>