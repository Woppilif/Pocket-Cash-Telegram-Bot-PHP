<?php
require_once 'database/rb.php';

define('WEBHOOK_URL', 'https://summersde.000webhostapp.com/');
R::setup( 'mysql:host=localhost;dbname=id1115530_summers', 'id1115530_summers', 'blink182' );

$book  = R::findOne( 'languages', ' phrase = ? AND lang = ?', [ 'Привет этот бот поможет тебе считать твои деньги','en' ] );


echo($book['translate']);