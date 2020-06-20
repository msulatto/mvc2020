<?php

/**
 * @constante DATABASE Valores para conexao ao banco de dados em produção
 */
define('DATABASE', [
    'host' =>     'den1.mysql1.gear.host',
    'dbname' =>   'dbkirby',
    'user' =>     'dbkirby',
    'password' => 'Bi37?lg1Bj5~',
    'options' => [
        PDO::MYSQL_ATTR_INIT_COMMAND => 'SET NAMES utf8',
        PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION,
        PDO::ATTR_CASE => PDO::CASE_NATURAL,
        PDO::ATTR_EMULATE_PREPARES => false
    ],
]);

// timezone
date_default_timezone_set('America/Sao_Paulo');

// urls
define('ROOT', 'http://localhost/mvc2020/app/views/assets/');

/*
define('DATABASE', [
    'host' => 'localhost',
    'dbname' => 'id13594392_aulab3',
    'user' => 'id13594392_thiago',
    'password' => '/a01^e|T{ivBf6Hs',
    'options' => [
        PDO::MYSQL_ATTR_INIT_COMMAND => 'SET NAMES utf8',
        PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION,
        PDO::ATTR_CASE => PDO::CASE_NATURAL,
        PDO::ATTR_EMULATE_PREPARES, false
    ],
]);
*/
