-- phpMyAdmin SQL Dump
-- version 4.6.6
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Apr 17, 2017 at 11:37 AM
-- Server version: 10.1.20-MariaDB
-- PHP Version: 7.0.8

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `id1077330_karsten`
--

-- --------------------------------------------------------

--
-- Table structure for table `accounts`
--

CREATE TABLE `accounts` (
  `id` int(11) UNSIGNED NOT NULL,
  `chat_id` int(11) UNSIGNED DEFAULT NULL,
  `account_name` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `account_balance` double DEFAULT NULL,
  `account_currency` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `accounts`
--

INSERT INTO `accounts` (`id`, `chat_id`, `account_name`, `account_balance`, `account_currency`) VALUES
(1, 144914652, 'default', 500, '₽'),
(2, 356749344, 'default', 2867, '₽'),
(3, 191704871, 'default', 0, '₽');

-- --------------------------------------------------------

--
-- Table structure for table `daily`
--

CREATE TABLE `daily` (
  `id` int(11) UNSIGNED NOT NULL,
  `chat_id` int(11) UNSIGNED DEFAULT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `price` decimal(10,2) UNSIGNED DEFAULT NULL,
  `rating` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `languages`
--

CREATE TABLE `languages` (
  `id` int(11) NOT NULL,
  `lang` varchar(15) COLLATE utf8_unicode_ci NOT NULL,
  `phrase` text COLLATE utf8_unicode_ci NOT NULL,
  `translate` text COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `languages`
--

INSERT INTO `languages` (`id`, `lang`, `phrase`, `translate`) VALUES
(1, 'en', 'Привет, этот бот поможет тебе считать твои деньги\nHello, this bot can help you count your cash!\n/setlang - to choose language', 'Hello, this bot can help you count your cash'),
(2, 'en', 'Стандартные действия :\n\n +<сумма> - пополнение счета\n  -<сумма> - расход\n\nСтандартные команды:\n\n/setname <имя> - установить ваше имя\n/sb <сумма> - установить баланс\n/balance - узнать баланс \n/setlang - установить язык\n/setcurr - установить валюту\n/daily - Список ежедневных трат \n/dailyadd - добавление события \n/d <Событие> - исполнение события\n/get - узнать последние события за период\n/rdaily - удалить ежедневное действие', 'Standard actions:\n\n  + <Amount> - account replenishment\n   - <amount> - expense\n\nStandard commands:\n\n/setname <name> - set your name\n/sb <amount> - set the balance\n/balance - find out the balance\n/setlang - set the language\n/setcurr - set currency\n/daily - List of daily expenses\n/dailyadd - add an event\n/d <Event> - event execution\n/get - find out the latest events for the period\n/rdaily - delete daily event'),
(3, 'en', 'Хорошо', 'Okay'),
(4, 'en', 'Укажите параметр!', 'Please, set parameter!'),
(5, 'en', 'Текущий баланс:', 'Your balance:'),
(6, 'en', 'Пополнение', 'Profit'),
(7, 'en', 'Расход', 'Spending'),
(8, 'en', 'Возможные события', 'Possible events'),
(9, 'en', 'Выберите язык', 'Select language'),
(10, 'en', 'Выберите валюту', 'Select currency'),
(11, 'en', 'Выполнено', 'Done!'),
(12, 'en', 'Неизвестный параметр!', 'Unknown parameter!'),
(13, 'en', 'Успешно Выполнено!', 'Successfully Done!'),
(14, 'en', 'Такое действие уже есть!', 'Such an action already exists!'),
(15, 'en', 'Вы можете ввести /daily для просмотра событий', 'You can enter /daily to view events'),
(16, 'en', 'Ежедневные траты', 'Daily spendings'),
(17, 'en', '<Название> <сумма>', '<Name> <amount>'),
(18, 'de', 'Привет, этот бот поможет тебе считать твои деньги\nHello, this bot can help you count your cash!\n/setlang - to choose language', 'Hallo, dieser Bot kann dir helfen, dein Geld zu zählen'),
(19, 'de', 'Стандартные действия :\n\n +<сумма> - пополнение счета\n  -<сумма> - расход\n\nСтандартные команды:\n\n/setname <имя> - установить ваше имя\n/sb <сумма> - установить баланс\n/balance - узнать баланс \n/setlang - установить язык\n/setcurr - установить валюту\n/daily - Список ежедневных трат \n/dailyadd - добавление события \n/d <Событие> - исполнение события\n/get - узнать последние события за период\n/rdaily - удалить ежедневное действие', 'Standardaktionen:\n\n+ <Betrag> - Konto Nachschub\n- <Betrag> - Aufwand\n\nStandardbefehle:\n\n/setname <name> - setze deinen Namen ein\n/sb <Menge> - Gleichgewicht setzen\n/balance - finde das Gleichgewicht\n/setlang - setze die Sprache ein\n/setcurr - währung setzen\n/daily - Liste der täglichen Ausgaben\n/dailyadd - füge eine Veranstaltung hinzu\n/d <Ereignis> - Ereignisausführung\n/get - finden Sie die letzten Ereignisse für den Zeitraum\n/rdaily - Tägliche Veranstaltung löschen'),
(20, 'de', 'Хорошо', 'Okay'),
(21, 'de', 'Укажите параметр!', 'Bitte setzen Sie den Parameter!'),
(22, 'de', 'Текущий баланс:', 'Dein Kontostand:'),
(23, 'de', 'Пополнение', 'Profitieren'),
(24, 'de', 'Расход', 'Ausgaben'),
(25, 'de', 'Возможные события', 'Mögliche Ereignisse'),
(26, 'de', 'Выберите язык', 'Sprache auswählen\n'),
(27, 'de', 'Выберите валюту', 'Währung wählen\n'),
(28, 'de', 'Выполнено', 'Erledigt!'),
(29, 'de', 'Неизвестный параметр!', 'Unbekannter Parameter!'),
(30, 'de', 'Успешно Выполнено!', 'Erfolgreich getan!'),
(31, 'de', 'Такое действие уже есть!', 'Eine solche Aktion existiert schon!'),
(32, 'de', 'Вы можете ввести /daily для просмотра событий', 'Sie können /daily eingeben, um Ereignisse anzuzeigen'),
(33, 'de', 'Ежедневные траты', 'Tägliche Ausgaben'),
(34, 'de', '<Название> <сумма>', '<Name> <Menge>'),
(35, 'en', 'Доход', 'Income'),
(36, 'de', 'Доход', 'Einnahmen');

-- --------------------------------------------------------

--
-- Table structure for table `transactions`
--

CREATE TABLE `transactions` (
  `id` int(11) UNSIGNED NOT NULL,
  `chat_id` int(11) UNSIGNED DEFAULT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `price` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `type` int(11) UNSIGNED DEFAULT NULL,
  `date` int(11) UNSIGNED DEFAULT NULL,
  `account_id` int(11) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `transactions`
--

INSERT INTO `transactions` (`id`, `chat_id`, `name`, `price`, `type`, `date`, `account_id`) VALUES
(1, 144914652, '', '0.1', 1, 1490486020, 1),
(2, 356749344, '221', '', 0, 1490653990, 2),
(3, 356749344, '', '221₽', 0, 1490654000, 2),
(4, 356749344, 'alc', '500', 0, 1490699364, 2),
(5, 356749344, 'Еда', '162', 0, 1490711870, 2),
(6, 356749344, 'стрижка', '350', 0, 1490795408, 2),
(7, 356749344, '', '2500', 1, 1490892616, 2),
(8, 356749344, '', '300', 0, 1490892630, 2),
(9, 356749344, 'еда', '100', 0, 1490892655, 2);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) UNSIGNED NOT NULL,
  `chat_id` int(11) UNSIGNED DEFAULT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `balance` decimal(10,2) DEFAULT NULL,
  `password` tinyint(1) UNSIGNED DEFAULT NULL,
  `reg_date` int(11) UNSIGNED DEFAULT NULL,
  `language` varchar(15) COLLATE utf8mb4_unicode_ci NOT NULL,
  `currency` varchar(15) COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_update` int(11) UNSIGNED DEFAULT NULL,
  `account_id` int(11) UNSIGNED DEFAULT NULL,
  `allow_messages` int(11) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `chat_id`, `name`, `balance`, `password`, `reg_date`, `language`, `currency`, `last_update`, `account_id`, `allow_messages`) VALUES
(1, 144914652, 'Sergey', 0.00, NULL, 1490484897, 'en', '₽', 1492188619, 1, 1),
(2, 356749344, 'Ernest', 0.00, NULL, 1490653839, 'en', '₽', 1490892658, 2, 1),
(3, 191704871, 'Amina', 0.00, NULL, 1490705417, 'ru', '₽', 1490705511, 3, 1);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `accounts`
--
ALTER TABLE `accounts`
  ADD PRIMARY KEY (`id`),
  ADD KEY `index_foreignkey_accounts_chat` (`chat_id`);

--
-- Indexes for table `daily`
--
ALTER TABLE `daily`
  ADD PRIMARY KEY (`id`),
  ADD KEY `index_foreignkey_daily_chat` (`chat_id`);

--
-- Indexes for table `languages`
--
ALTER TABLE `languages`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `transactions`
--
ALTER TABLE `transactions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `index_foreignkey_transactions_chat` (`chat_id`),
  ADD KEY `index_foreignkey_transactions_account` (`account_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD KEY `index_foreignkey_users_chat` (`chat_id`),
  ADD KEY `index_foreignkey_users_account` (`account_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `accounts`
--
ALTER TABLE `accounts`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT for table `daily`
--
ALTER TABLE `daily`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `languages`
--
ALTER TABLE `languages`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=37;
--
-- AUTO_INCREMENT for table `transactions`
--
ALTER TABLE `transactions`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;
--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
