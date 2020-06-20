<?php

namespace MVC2020\Models;
//Classe é um MODELO, um exemplo, um modelo onde vc define valores, comportamentos e açoes que essa Classe compartilha toda vez que é usada.
class Produto
{
  public function __construct()
  {
    echo "<h1>estou na classe Produto</h1>";
  }

  private function retornaMsg($msg)
  {
    return "msg do dia -> $msg";
  }

  public function mensagem($msg)
  {
    echo $this->retornaMsg($msg);
  }
}
