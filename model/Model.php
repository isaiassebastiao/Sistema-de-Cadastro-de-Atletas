<?php
require_once('config/DataBase.php');

class Model{
    
    private $name;
    private $adress;
    private $clubLevel;
    private $birthDate;
    private $idCategory;
    private $idClub;

    public function insertAthlete($name, $adress, $birthDate, $idCategory, $idClub){

        $this->name = $name;
        $this->adress = $adress;
        $this->birthDate = $birthDate;
        $this->idCategory = $idCategory;
        $this->idClub = $idClub;

        global $pdo;

        $stmt = $pdo->prepare("SELECT vagas FROM clubes WHERE id = ?");
        $stmt->execute([$this->idClub]);

        $vacancies = $stmt->fetch(PDO::FETCH_ASSOC);

        $clubsVacanciesValue = $vacancies['vagas'] - 1;

        $updateClubVacanciesValue = $this->updateClubVacancies($this->idClub, $clubsVacanciesValue);
        
        if($updateClubVacanciesValue){

            $stmt = $pdo->prepare("INSERT INTO atletas(nome, municipio, data_nascimento, nivel_equipa, id_clube) VALUES(?,?,?,?,?)");
            $sucess = $stmt->execute([$this->name, $this->adress, $this->birthDate, $this->idCategory, $this->idClub]);
    
            if($sucess){
                return ['success'=>true, 'message'=>'Atleta Cadastrado com sucesso!'];
            }
            return ['success'=>false, 'message'=>'Algo deu errado ao cadastrar este jogador!'];
        }


    }

    public function getClubId($address){
        global $pdo;
    
        $stmt = $pdo->prepare("SELECT * FROM clubes");
        $stmt->execute();
        $clubs = $stmt->fetchAll(PDO::FETCH_ASSOC);
    
        foreach($clubs as $club){
            if($club['vagas'] > 0 && $club['municipio'] == $address) {
                return ['success'=>true,'id'=>$club['id']];
            }
        }
    
        foreach($clubs as $club){
            if($club['vagas'] > 0){
                return ['success'=>true, 'id'=>$club['id']];
            }
        }
    }

    public function updateClubVacancies($idClub, $vacanyValue){
        
        global $pdo;

        $stmt = $pdo->prepare("UPDATE clubes set vagas = ? WHERE id = ?");
        return $stmt->execute([$vacanyValue, $idClub]);
        
    }

    public function getAllAthletes(){
        global $pdo;

        $stmt = $pdo->prepare("SELECT * FROM clubes");
        $stmt->execute();

        $clubs = $stmt->fetchAll(PDO::FETCH_ASSOC);

        $hasVacancies = false;

        foreach($clubs as $club){
            if($club['vagas'] > 0){
                $hasVacancies = true;
                break;
            }
        }

        if(!$hasVacancies){
            return ['success'=>false,'message'=>'Sem vagas disponíveis, volte quando o site reabrir com novas oportunidades!'];
        }

        $stmt = $pdo->prepare("SELECT atletas.nome, atletas.municipio, atletas.data_nascimento, clubes.nome as 'clube', clubes.municipio as 'clube_municipio', categorias.categoria FROM atletas JOIN clubes on atletas.id_clube = clubes.id JOIN categorias on atletas.nivel_equipa = categorias.id ORDER BY atletas.data_nascimento DESC");

        $stmt->execute();

        $athletes = $stmt->fetchAll(PDO::FETCH_ASSOC);
        return $athletes;
    }
}