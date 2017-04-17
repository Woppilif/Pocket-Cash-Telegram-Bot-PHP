<?php
require_once 'database/rb.php';
R::setup( 'mysql:host=localhost;dbname=id1077330_karsten', 'id1077330_karsten', 'blink182' );


define('BOT_TOKEN', '347721857:AAEkAGJ8cvxeKzmYFzXKLhI8okfoylkE0YQ');
define('API_URL', 'https://api.telegram.org/bot'.BOT_TOKEN.'/');
define('WEBHOOK_URL', 'https://karsten.000webhostapp.com/');
/*define('BOT_TOKEN', '311147139:AAEpmrpjq6W2rOX9lzjJtSESgZbdrvf7cK8');
define('API_URL', 'https://api.telegram.org/bot'.BOT_TOKEN.'/');
define('WEBHOOK_URL', 'https://summersde.000webhostapp.com/');
R::setup( 'mysql:host=localhost;dbname=id1115530_summers', 'id1115530_summers', 'blink182' );*/

require_once 'request.php';
require_once 'user.php';
require_once 'message.php';
require_once 'languages.php';
require_once 'transactions.php';
require_once 'daily.php';
require_once 'account.php';
$request = new Request();


if (php_sapi_name() == 'cli') {
  // if run from console, set or delete webhook
	$request->apiRequest('setWebhook', array('url' => isset($argv[1]) && $argv[1] == 'delete' ? '' : WEBHOOK_URL));
	exit;
}
$content = file_get_contents("php://input");
$update = json_decode($content, true);
if (!$update) {
  // receive wrong update, must not happen
	exit;
}
if (isset($update["message"])) {
  //$request->processMessage($update["message"]);
	$message = new Message($update["message"]);

	
	$user = new User($message->getChatId());

	$account = new Account($message->getChatId(),$user->GetUserAccountId());
	$lang = new Languages($user->getLanguage());
	$trans = new Transactions($message->getChatId());
	$request->getChatId($message->getChatId());
	$daily = new Daily($message->getChatId());
	switch($message->getMessage())
	{
		case '/start':
			$request->sendMessage(''.$lang->lang("Привет, этот бот поможет тебе считать твои деньги\nHello, this bot can help you count your cash!\n/setlang - to choose language").' ');
		break;
		case '/setname':
		if (!$message->getMessageParam(1)) return $request->sendMessage(''.$lang->lang('Укажите параметр!').'');
		$user->setName($message->getMessageParam(1));

		$request->sendMessage(''.$lang->lang('Хорошо').', '.$message->getMessageParam(1).' ');

		break;
		case '/balance':
		$request->sendMessage(''.$lang->lang('Текущий баланс:').' '.$account->getBalance().' '.$account->getCurrency().' ');

		break;
		case '/sb':
		if (!$message->getMessageParam(1)) return $request->sendMessage(''.$lang->lang('Укажите параметр!').'');
		$account->setBalance($message->getMessageParam(1));
		$request->sendMessage(''.$lang->lang('Выполнено').'');
		break;
		case substr($message->getMessage(),0,1) == '+':
		if (!substr($message->getMessage(),1)) return $request->sendMessage(''.$lang->lang('Укажите параметр!').'');
		$request->sendMessage(''.$lang->lang('Пополнение').': '.substr($message->getMessage(),1).' '.$account->getCurrency().'');
		$trans->Transaction($message->getMessageParam(1),substr($message->getMessage(),1),1,$account->GetAccountId());
		$account->upBalance(floatval(substr($message->getMessage(),1)));
		break;
		case substr($message->getMessage(),0,1) == '-':
		$request->sendMessage(''.$lang->lang('Расход').': '.substr($message->getMessage(),1).' '.$account->getCurrency().'');
		$trans->Transaction($message->getMessageParam(1),substr($message->getMessage(),1),0,$account->GetAccountId());
		$account->downBalance(floatval(substr($message->getMessage(),1)));
		break;
		case '/get':
		if (!$message->getMessageParam(1)) return $request->sendMessageWK(''.$lang->lang('Возможные события').'',array(array('/get today'),array('/get yesterday'),array('/get week')));
		$data = $trans->GetTransactions($message->getMessageParam(1));
		for($i=0;$i<count($data);$i++)
		{
			if($data[$i]['type']==0) { $data[$i]['type'] = $lang->lang('Расход');} else {$data[$i]['type'] = $lang->lang('Доход');}
			if(!empty($data[$i]['name'])) {$data[$i]['name'] = '"'.$data[$i]['name'].'" '; } 

			$text = $text."" .$data[$i]['type']."  ".$data[$i]['price']." ".$user->getCurrency()."\n ".$data[$i]['name']."".date("Y-m-d H:i:s",$data[$i]['date'])." \n\n";
		}
			$request->sendMessage($text);
		break;
		case '/setlang':
		
		if (!$message->getMessageParam(1)) return $request->sendMessageWK(''.$lang->lang('Выберите язык').'',array(array('/setlang Русский'),array('/setlang English'),array('/setlang Deutsch')));
		$user->setLanguage($message->getMessageParam(1));
		$request->sendMessage(''.$lang->lang('Выполнено').'');

		break;
		case '/setcurr':
		
		if (!$message->getMessageParam(1)) return $request->sendMessageWK(''.$lang->lang('Выберите валюту').'',array(array('/setcurr ₽'),array('/setcurr $'),array('/setcurr €'),array('/setcurr £')));
		$account->setCurrency($message->getMessageParam(1));
		$request->sendMessage(''.$lang->lang('Выполнено').'');
		break;
		case '/daily':
		$data = $daily->getDaily();
		$request->sendMessageWK(''.$lang->lang('Ежедневные траты').'',$data);
		break;
		case '/d':
		if (!$message->getMessageParam(1)) return $request->sendMessage(''.$lang->lang('Укажите параметр!').'');
		$price = $daily -> executeDaily($message->getMessageParam(1));
		if(!$price) return $request->sendMessage(''.$lang->lang('Неизвестный параметр!').'');
		$account->downBalance(floatval($price));
		$request->sendMessage(''.$lang->lang('Успешно Выполнено!').'');
		$request->sendMessage(''.$lang->lang('Текущий баланс:').' '.$account->getBalance().' '.$account->getCurrency().' ');
		break;
		case '/dailyadd':
		if (!$message->getMessageParam(1) || !$message->getMessageParam(2)) return $request->sendMessage('/dailyadd '.$lang->lang('<Название> <сумма>').'');
		$data = $daily->AddDaily(array($message->getMessageParam(1),$message->getMessageParam(2)));
		if(!$data) return $request->sendMessage(''.$lang->lang('Такое действие уже есть!').'');
		$request->sendMessage("".$lang->lang('Успешно Выполнено!')."\n".$lang->lang('Вы можете ввести /daily для просмотра событий')."");
		break;
		case '/rdaily':
			if (!$message->getMessageParam(1)) return $request->sendMessage(''.$lang->lang('Укажите параметр!').'');
			$data = $daily -> RemoveDaily($message->getMessageParam(1));
			if($data) return $request->sendMessage(''.$lang->lang('Успешно Выполнено!').'');
		break;
		case '/help':
		$request->sendMessage("".$lang->lang("Стандартные действия :\n\n +<сумма> - пополнение счета\n  -<сумма> - расход\n\nСтандартные команды:\n\n/setname <имя> - установить ваше имя\n/sb <сумма> - установить баланс\n/balance - узнать баланс \n/setlang - установить язык\n/setcurr - установить валюту\n/daily - Список ежедневных трат \n/dailyadd - добавление события \n/d <Событие> - исполнение события\n/get - узнать последние события за период\n/rdaily - удалить ежедневное действие")."");
		break;
		case '/create':
		
		if (!$message->getMessageParam(1)) return $request->sendMessage('/create '.$lang->lang('<Название>').'');
		$data = $account->CreateAccount($message->getMessageParam(1));
		if(!$data) return $request->sendMessage(''.$lang->lang('Такое действие уже есть!').'');
		$user->SetUserAccountId($data);
		$request->sendMessage("".$lang->lang('Успешно Выполнено!')."");

		break;
		case '/accounts':
			$data = $account->GetAccounts();
		if (!$message->getMessageParam(1)) return $request->sendMessageWK(''.$lang->lang('Все аккаунты').'',$data);
		$price = $user -> SetUserAccountId($message->getMessageParam(1));
		if(!$price) return $request->sendMessage(''.$lang->lang('Неизвестный параметр!').'');
		$request->sendMessage(''.$lang->lang('Выполнено').'');

		break;

		case '/sendmessage':
		if (!$message->getMessageParam(1)) return $request->sendMessage(''.$lang->lang('Укажите параметр!').'');
		$request->sendMessageTo(''.$message->getWholeMessage().'',370130478);
			

		break;
		
		default: $request->sendMessage("".$lang->lang("Стандартные действия :\n\n +<сумма> - пополнение счета\n  -<сумма> - расход\n\nСтандартные команды:\n\n/setname <имя> - установить ваше имя\n/sb <сумма> - установить баланс\n/balance - узнать баланс \n/setlang - установить язык\n/setcurr - установить валюту\n/daily - Список ежедневных трат \n/dailyadd - добавление события \n/d <Событие> - исполнение события\n/get - узнать последние события за период\n/rdaily - удалить ежедневное действие")."");
	}


}