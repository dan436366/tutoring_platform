-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Хост: 127.0.0.1
-- Время создания: Июн 12 2025 г., 01:00
-- Версия сервера: 10.4.32-MariaDB
-- Версия PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- База данных: `tutoring_platform`
--
CREATE DATABASE IF NOT EXISTS `tutoring_platform` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `tutoring_platform`;

-- --------------------------------------------------------

--
-- Структура таблицы `lessons`
--

DROP TABLE IF EXISTS `lessons`;
CREATE TABLE `lessons` (
  `id` int(11) NOT NULL,
  `tutor_id` int(11) NOT NULL,
  `subject` varchar(100) DEFAULT NULL,
  `price` decimal(10,2) DEFAULT NULL,
  `duration` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `lesson_requests`
--

DROP TABLE IF EXISTS `lesson_requests`;
CREATE TABLE `lesson_requests` (
  `id` int(11) NOT NULL,
  `student_id` int(11) NOT NULL,
  `tutor_id` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `status` enum('Очікує','Прийнята','Відхилена') DEFAULT 'Очікує'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Дамп данных таблицы `lesson_requests`
--

INSERT INTO `lesson_requests` (`id`, `student_id`, `tutor_id`, `created_at`, `status`) VALUES
(1, 2, 8, '2025-06-11 21:57:12', 'Прийнята'),
(2, 2, 9, '2025-06-11 21:57:19', 'Прийнята'),
(3, 3, 8, '2025-06-11 22:03:51', 'Прийнята'),
(4, 3, 9, '2025-06-11 22:03:57', 'Очікує'),
(5, 3, 18, '2025-06-11 22:04:08', 'Прийнята');

-- --------------------------------------------------------

--
-- Структура таблицы `messages`
--

DROP TABLE IF EXISTS `messages`;
CREATE TABLE `messages` (
  `id` int(11) NOT NULL,
  `request_id` int(11) NOT NULL,
  `sender_id` int(11) NOT NULL,
  `message` text NOT NULL,
  `sent_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `seen` tinyint(1) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Дамп данных таблицы `messages`
--

INSERT INTO `messages` (`id`, `request_id`, `sender_id`, `message`, `sent_at`, `seen`) VALUES
(1, 2, 9, 'Добрий день', '2025-06-11 21:58:06', 1),
(2, 2, 9, 'Що вас цікавить', '2025-06-11 21:58:10', 1),
(3, 1, 8, 'Привіт', '2025-06-11 21:59:01', 1),
(4, 1, 8, 'який предмет?', '2025-06-11 21:59:06', 1),
(5, 2, 2, 'добрий', '2025-06-11 21:59:54', 0),
(6, 2, 2, 'біологія', '2025-06-11 21:59:57', 0),
(7, 1, 2, 'привіт', '2025-06-11 22:00:06', 1),
(8, 1, 2, 'історія цікавить', '2025-06-11 22:00:12', 1),
(9, 1, 2, 'розкажіть більше', '2025-06-11 22:00:17', 1),
(10, 1, 8, 'потім', '2025-06-11 22:24:32', 1);

-- --------------------------------------------------------

--
-- Структура таблицы `orders`
--

DROP TABLE IF EXISTS `orders`;
CREATE TABLE `orders` (
  `id` int(11) NOT NULL,
  `student_id` int(11) NOT NULL,
  `lesson_id` int(11) NOT NULL,
  `status` enum('pending','confirmed','done') DEFAULT 'pending',
  `created_at` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `ratings`
--

DROP TABLE IF EXISTS `ratings`;
CREATE TABLE `ratings` (
  `id` int(11) NOT NULL,
  `student_id` int(11) NOT NULL,
  `tutor_id` int(11) NOT NULL,
  `rating` int(11) DEFAULT NULL CHECK (`rating` >= 1 and `rating` <= 5),
  `comment` text DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Дамп данных таблицы `ratings`
--

INSERT INTO `ratings` (`id`, `student_id`, `tutor_id`, `rating`, `comment`, `created_at`) VALUES
(1, 2, 8, 4, 'супер', '2025-06-12 01:01:31'),
(2, 2, 9, 3, 'непогано', '2025-06-12 01:02:04'),
(3, 3, 18, 2, 'норм', '2025-06-12 01:19:43'),
(4, 3, 8, 5, 'чудово', '2025-06-12 01:21:18');

-- --------------------------------------------------------

--
-- Структура таблицы `specializations`
--

DROP TABLE IF EXISTS `specializations`;
CREATE TABLE `specializations` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `description` text DEFAULT NULL,
  `icon` varchar(10) DEFAULT '?',
  `created_at` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Дамп данных таблицы `specializations`
--

INSERT INTO `specializations` (`id`, `name`, `description`, `icon`, `created_at`) VALUES
(1, 'Математика', 'Алгебра, геометрія, математичний аналіз', '🔢', '2025-06-03 13:53:36'),
(2, 'Фізика', 'Механіка, термодинаміка, електродинаміка', '⚛️', '2025-06-03 13:53:36'),
(3, 'Хімія', 'Органічна та неорганічна хімія', '🧪', '2025-06-03 13:53:36'),
(4, 'Біологія', 'Ботаніка, зоологія, анатомія', '🧬', '2025-06-03 13:53:36'),
(5, 'Англійська мова', 'Граматика, розмовна практика, підготовка до іспитів', '🇬🇧', '2025-06-03 13:53:36'),
(6, 'Українська мова', 'Граматика, література, культура мови', '🇺🇦', '2025-06-03 13:53:36'),
(7, 'Історія', 'Всесвітня та українська історія', '📜', '2025-06-03 13:53:36'),
(8, 'Географія', 'Фізична та економічна географія', '🌍', '2025-06-03 13:53:36'),
(9, 'Інформатика', 'Програмування, алгоритми, комп\'ютерні науки', '💻', '2025-06-03 13:53:36'),
(10, 'Економіка', 'Мікро- та макроекономіка, фінанси', '💰', '2025-06-03 13:53:36');

-- --------------------------------------------------------

--
-- Структура таблицы `tutor_specializations`
--

DROP TABLE IF EXISTS `tutor_specializations`;
CREATE TABLE `tutor_specializations` (
  `id` int(11) NOT NULL,
  `tutor_id` int(11) NOT NULL,
  `specialization_id` int(11) NOT NULL,
  `experience_years` int(11) DEFAULT 0,
  `price_per_hour` decimal(8,2) DEFAULT 0.00,
  `description` text DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Дамп данных таблицы `tutor_specializations`
--

INSERT INTO `tutor_specializations` (`id`, `tutor_id`, `specialization_id`, `experience_years`, `price_per_hour`, `description`, `created_at`) VALUES
(1, 18, 5, 10, 100.00, '0', '2025-06-12 00:27:07'),
(2, 8, 9, 15, 150.00, '0', '2025-06-12 00:34:12'),
(3, 8, 3, 5, 200.00, '0', '2025-06-12 00:34:21'),
(4, 9, 7, 20, 299.99, '0', '2025-06-12 00:37:42'),
(5, 9, 4, 5, 99.99, '0', '2025-06-12 00:38:29'),
(6, 9, 1, 20, 499.99, '0', '2025-06-12 00:38:41'),
(7, 10, 6, 27, 249.98, '0', '2025-06-12 00:39:57'),
(8, 10, 8, 3, 69.99, '0', '2025-06-12 00:40:11'),
(9, 16, 10, 30, 399.99, '0', '2025-06-12 00:41:02'),
(10, 16, 2, 10, 349.99, '0', '2025-06-12 00:41:55'),
(11, 8, 6, 2, 55.00, '0', '2025-06-12 00:55:51'),
(12, 8, 5, 14, 370.00, '0', '2025-06-12 00:56:02');

-- --------------------------------------------------------

--
-- Структура таблицы `users`
--

DROP TABLE IF EXISTS `users`;
CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `name` varchar(100) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `bio` text DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `role` enum('student','tutor') DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Дамп данных таблицы `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `bio`, `phone`, `password`, `role`, `created_at`) VALUES
(1, 'Олег', 'oleg@gmail.com', NULL, NULL, '$2y$10$dnK4HOofgoqWXa3ymewsCOeflZ1zfm77hh58UEyLauANMJ30l2k5O', 'student', '2025-06-12 00:02:42'),
(2, 'Даніїл ', 'daniil@gmail.com', NULL, NULL, '$2y$10$5GRN0gWbv4kIbLQCbG/qbei5TGdEMQt5mt6Gcuu9KuTJWDy0424Qa', 'student', '2025-06-12 00:03:56'),
(3, 'Максим', 'maksim@gmail.com', NULL, NULL, '$2y$10$CdFFplEtgVFEarr/s2u0x.RDQnGMn7wHEF.CkjWaVDlE.gbVhCyou', 'student', '2025-06-12 00:04:23'),
(4, 'Олександр', 'oleksandr@gmail.com', NULL, NULL, '$2y$10$1xMn20zX3ZcPME/zuAtjg.raCI/06MklJvn4e9vPrbUmyz6QkJ0m.', 'student', '2025-06-12 00:05:08'),
(5, 'Марія', 'maria@gmail.com', NULL, NULL, '$2y$10$UP4/8SvPDy/MxPvouvMj5eSvPWZMUFSaUq9YYR9GAmzfe.JvnYBAm', 'student', '2025-06-12 00:05:40'),
(6, 'Анна', 'anna@gmail.com', NULL, NULL, '$2y$10$Rn.7.GPbUj25msxWeTmzKe.NRtrjYx8EK48ErDbO8mzDjkZaVZfbm', 'student', '2025-06-12 00:06:18'),
(7, 'Анастасія', 'anastasia@gmail.com', NULL, NULL, '$2y$10$cnKvWTf6QVht4o5tV84xaeLVJ8.2CIsE43YhN8M1IguWQa7il6y5O', 'student', '2025-06-12 00:07:36'),
(8, 'Олександр Олександрович', 'oleksandrovich@gmail.com', 'вчився десь', '+380732003456', '$2y$10$rp9W/TdcjsPFNdHROm/zv.SyYqL./HdKE3A3sIaxPfISmu.EAtV4e', 'tutor', '2025-06-12 00:09:38'),
(9, 'Анна Миколаївна', 'mykolaivna@gmail.com', 'вчилась в чдту', '+380675673990', '$2y$10$H9ShU/RZ9uQsDd9oOS3Pyuo0o7zFdtDswy70AICbLxSIvCfM8aZhK', 'tutor', '2025-06-12 00:10:22'),
(10, 'Лариса Володимирівна', 'volodymirivna@gmail.com', 'вчилась в кпі', '+380674562890', '$2y$10$HKpsIeXm2blOGC0y3YKm4u2uWN0WyBUmT/akn2vuxl7EDvfAyqsdO', 'tutor', '2025-06-12 00:11:21'),
(11, 'Олег Петрович', 'petrovich@gmail.com', NULL, NULL, '$2y$10$bWpmyFergj6HeQGetk8KweqYqQiRxqflgskihkk4iQiMdaz8mLPFi', 'tutor', '2025-06-12 00:12:03'),
(12, 'Максим Борисович', 'borisovich@gmail.com', NULL, NULL, '$2y$10$drN6mT1VqM4vm.HD.pYX1Ohz1WMkEgWevvCXwHoZ6fSziEyQbeRnC', 'tutor', '2025-06-12 00:13:10'),
(13, 'Марія Анатоліївна', 'anatoliivna@gmail.com', NULL, NULL, '$2y$10$3NYULpzHOYmOT4hzYuwu2OU/zorJ/o4sdtbjHzzhnQ2kx42WFTiNe', 'tutor', '2025-06-12 00:14:33'),
(14, 'Богдан Вікторович', 'viktorovich@gmail.com', NULL, NULL, '$2y$10$J8avSynkBFtR49q5yC78f.E28iwYMl2Izya0vVPTA57G2glLwqaS6', 'tutor', '2025-06-12 00:15:25'),
(15, 'Юлія Богданівна', 'bogdanivna@gmail.com', NULL, NULL, '$2y$10$KDsCmW8AEIE.haWcd1cndeMRdc3l1JOxryEifR1VnZnLHqVU7UkoW', 'tutor', '2025-06-12 00:17:08'),
(16, 'Іван Мар\'янович', 'marianovich@gmail.com', 'навчався в кну', '+3800936571093', '$2y$10$obDEZOUvRROAK.bRn8hRO.xIEWIL1tfpPo6l.kfNBvf.mDy81npSG', 'tutor', '2025-06-12 00:18:41'),
(17, 'Максим Іванович', 'ivanovich@gmail.com', NULL, NULL, '$2y$10$cxKsi/GMl89A8HQ/ZnhL5uuX1MBwAv1vtA.R9JdSqY2ILTW8ldfoa', 'tutor', '2025-06-12 00:20:25'),
(18, 'Олександр Даніїлович', 'daniilovich@gmail.com', 'навчався в чну', '+380672176747', '$2y$10$DA333b6rh/bv8/FI8sSIFu.dJjGq0ZtQpiXk0GqYN198yRnralq7a', 'tutor', '2025-06-12 00:22:31');

--
-- Индексы сохранённых таблиц
--

--
-- Индексы таблицы `lessons`
--
ALTER TABLE `lessons`
  ADD PRIMARY KEY (`id`),
  ADD KEY `tutor_id` (`tutor_id`);

--
-- Индексы таблицы `lesson_requests`
--
ALTER TABLE `lesson_requests`
  ADD PRIMARY KEY (`id`),
  ADD KEY `student_id` (`student_id`),
  ADD KEY `tutor_id` (`tutor_id`);

--
-- Индексы таблицы `messages`
--
ALTER TABLE `messages`
  ADD PRIMARY KEY (`id`),
  ADD KEY `request_id` (`request_id`),
  ADD KEY `sender_id` (`sender_id`);

--
-- Индексы таблицы `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`id`),
  ADD KEY `student_id` (`student_id`),
  ADD KEY `lesson_id` (`lesson_id`);

--
-- Индексы таблицы `ratings`
--
ALTER TABLE `ratings`
  ADD PRIMARY KEY (`id`),
  ADD KEY `student_id` (`student_id`),
  ADD KEY `tutor_id` (`tutor_id`);

--
-- Индексы таблицы `specializations`
--
ALTER TABLE `specializations`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Индексы таблицы `tutor_specializations`
--
ALTER TABLE `tutor_specializations`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique_tutor_specialization` (`tutor_id`,`specialization_id`),
  ADD KEY `specialization_id` (`specialization_id`);

--
-- Индексы таблицы `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT для сохранённых таблиц
--

--
-- AUTO_INCREMENT для таблицы `lessons`
--
ALTER TABLE `lessons`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT для таблицы `lesson_requests`
--
ALTER TABLE `lesson_requests`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT для таблицы `messages`
--
ALTER TABLE `messages`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT для таблицы `orders`
--
ALTER TABLE `orders`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT для таблицы `ratings`
--
ALTER TABLE `ratings`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT для таблицы `specializations`
--
ALTER TABLE `specializations`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT для таблицы `tutor_specializations`
--
ALTER TABLE `tutor_specializations`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT для таблицы `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- Ограничения внешнего ключа сохраненных таблиц
--

--
-- Ограничения внешнего ключа таблицы `lessons`
--
ALTER TABLE `lessons`
  ADD CONSTRAINT `lessons_ibfk_1` FOREIGN KEY (`tutor_id`) REFERENCES `users` (`id`);

--
-- Ограничения внешнего ключа таблицы `lesson_requests`
--
ALTER TABLE `lesson_requests`
  ADD CONSTRAINT `lesson_requests_ibfk_1` FOREIGN KEY (`student_id`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `lesson_requests_ibfk_2` FOREIGN KEY (`tutor_id`) REFERENCES `users` (`id`);

--
-- Ограничения внешнего ключа таблицы `messages`
--
ALTER TABLE `messages`
  ADD CONSTRAINT `messages_ibfk_1` FOREIGN KEY (`request_id`) REFERENCES `lesson_requests` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `messages_ibfk_2` FOREIGN KEY (`sender_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Ограничения внешнего ключа таблицы `orders`
--
ALTER TABLE `orders`
  ADD CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`student_id`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `orders_ibfk_2` FOREIGN KEY (`lesson_id`) REFERENCES `lessons` (`id`);

--
-- Ограничения внешнего ключа таблицы `ratings`
--
ALTER TABLE `ratings`
  ADD CONSTRAINT `ratings_ibfk_1` FOREIGN KEY (`student_id`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `ratings_ibfk_2` FOREIGN KEY (`tutor_id`) REFERENCES `users` (`id`);

--
-- Ограничения внешнего ключа таблицы `tutor_specializations`
--
ALTER TABLE `tutor_specializations`
  ADD CONSTRAINT `tutor_specializations_ibfk_1` FOREIGN KEY (`tutor_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `tutor_specializations_ibfk_2` FOREIGN KEY (`specialization_id`) REFERENCES `specializations` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
