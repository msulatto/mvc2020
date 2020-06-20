<?php
namespace MVC2020\Models;

require_once('../config.php');

class Conexao
{

  /**
   * @return $conn Atributo que será retornado qdo a função connect() for chamada.
   */
  private $conn;
  protected function connect()
  {
    try {
      $this->conn = new \PDO('mysql:host=' . DATABASE['host'] . ';dbname=' . DATABASE['dbname'] . '; charset=utf8', DATABASE['user'], DATABASE['password'], DATABASE['options']);
      return $this->conn;
    } catch (\Exception $erro) {
      die('Erro ao conectar<br>' . $erro->getMessage());
    }
  }
  /**
   * @param $sql query a ser executado
   * @param $params 
   */
  public function SelectAll($sql, $params)
  {
    $result = $this->connect()->prepare($sql);
    $result->execute($params);
    $data = $result->fetchAll(\PDO::FETCH_ASSOC);
    return $data;
  }
}



//instancia da classe
$testeCon = new Conexao();

$resultado = $testeCon->SelectAll('SELECT * FROM categoria ', []);

echo "<pre>";
print_r($resultado);
echo "<pre>";
