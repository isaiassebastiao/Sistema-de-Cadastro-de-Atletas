<?php
require_once('model/Model.php');

class Controller{
    
    public function Router(){

        if($_SERVER['REQUEST_METHOD'] == 'POST'){

            $name = $_POST['nome'];
            $adress = $_POST['municipio'];
            $birthDate = $_POST['data-nascimento'];
          
            
            $birth_date = DateTime::createFromFormat('Y-m-d', $birthDate);

            $today = new DateTime();

            $age = $today->diff($birth_date)->y;

            if($age > 6 && $age < 12){
                $idCategory = 1;
            }
            else if($age > 11 && $age <18){
                $idCategory = 2;
            }
            else if($age > 17 && $age < 30){
                $idCategory = 3;
            }else{
                echo json_encode(['success'=>false, 'message'=>'Idade não permitida, tenha pelo menos uma idade entre 7 à 29 anos']);
                return;
            }

            $model = new Model();

            $idClub = $model->getClubId($adress);

            $response = $model->insertAthlete($name, $adress, $birthDate, $idCategory, $idClub['id']);

            echo json_encode($response);
            //exit;
        }else if($_SERVER['REQUEST_METHOD'] == 'GET'){
            
            $model = new Model();
            
            $athletes = $model->getAllAthletes();
            echo json_encode($athletes);
            return;
        }
        header('Location: view/home.html');
    }
}

$controller = new Controller();
$controller->Router();