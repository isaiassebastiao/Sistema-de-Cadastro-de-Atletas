<?php
class DataBase{
    private $dbname;
    private $host;
    private $user;
    private $pass;

    public function __construct($host, $dbname, $user, $pass){
        $this->host = $host;
        $this->dbname = $dbname;
        $this->user = $user;
        $this->pass = $pass;
    }
    
    public function Connect(){
        try{
            $pdo = new PDO("mysql:host=$this->host;dbname=$this->dbname", "$this->user", "$this->pass");
            return $pdo;
        }catch(Exception $e){
            throw new Exception("Erro ao comunicar com o banco de dados " . $e->getMessage());
        }
    }

}
$conx = new DataBase("localhost", "dbatletas", "root", "");
$pdo = $conx->Connect();
