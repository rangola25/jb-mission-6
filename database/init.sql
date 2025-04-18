-- phpMyAdmin SQL Dump
-- version 5.2.2
-- https://www.phpmyadmin.net/
--
-- Host: db
-- Generation Time: Apr 17, 2025 at 06:16 PM
-- Server version: 9.2.0
-- PHP Version: 8.2.27

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `vacations`
--

-- --------------------------------------------------------

--
-- Table structure for table `follows`
--

CREATE TABLE `follows` (
  `user_id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `vacation_id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `follows`
--

INSERT INTO `follows` (`user_id`, `vacation_id`, `created_at`, `updated_at`) VALUES
('6b99cbe0-1fe8-47c0-b557-613d7dcedae2', '1500ff46-5349-497d-8e42-c6c5bcbde89e', '2025-04-13 20:01:42', '2025-04-13 20:01:42'),
('6b99cbe0-1fe8-47c0-b557-613d7dcedae2', '3ecb00b8-c175-4a87-af21-7fd73b8eac8e', '2025-04-13 20:01:48', '2025-04-13 20:01:48'),
('6b99cbe0-1fe8-47c0-b557-613d7dcedae2', '64ade4c0-dc50-4902-87a0-3e5be6efa197', '2025-04-13 20:01:45', '2025-04-13 20:01:45'),
('6b99cbe0-1fe8-47c0-b557-613d7dcedae2', 'dc238254-e1ca-469d-8f22-5fd3917ed821', '2025-04-13 20:01:35', '2025-04-13 20:01:35'),
('7d4f5bdd-8ade-4a88-a1c1-ab5f7cdd941a', '64ade4c0-dc50-4902-87a0-3e5be6efa197', '2025-04-13 20:01:59', '2025-04-13 20:01:59'),
('7d4f5bdd-8ade-4a88-a1c1-ab5f7cdd941a', 'bea0a936-cca8-498e-a12d-0c64c0fb7ec1', '2025-04-13 20:02:01', '2025-04-13 20:02:01'),
('7d4f5bdd-8ade-4a88-a1c1-ab5f7cdd941a', 'c941282d-9273-4a9b-a044-3f205e31bdd1', '2025-04-13 20:02:03', '2025-04-13 20:02:03'),
('7d4f5bdd-8ade-4a88-a1c1-ab5f7cdd941a', 'dc238254-e1ca-469d-8f22-5fd3917ed821', '2025-04-13 20:01:57', '2025-04-13 20:01:57');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `first_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `role` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'user',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `password`, `role`, `created_at`, `updated_at`) VALUES
('456c9679-b095-42d4-8b9a-f029b5011b9f', 'Ran', 'eli', 'Eliyahuran303@gmail.com', '7f7737fddd2842bc2afdbf1868aaa8e986b83133a1f010fe96535c15e4584628', 'user', '2025-03-29 10:45:42', '2025-03-29 10:45:42'),
('6b99cbe0-1fe8-47c0-b557-613d7dcedae2', 'Ran', 'Golani', 'rango2001@gmail.com', '7f7737fddd2842bc2afdbf1868aaa8e986b83133a1f010fe96535c15e4584628', 'user', '2025-03-11 17:38:30', '2025-03-11 17:38:30'),
('7d4f5bdd-8ade-4a88-a1c1-ab5f7cdd941a', 'Cristiano', 'Ronaldo', 'CR7@gmail.com', '7f7737fddd2842bc2afdbf1868aaa8e986b83133a1f010fe96535c15e4584628', 'user', '2025-03-16 21:54:29', '2025-03-16 21:54:29'),
('b6dbe5ed-d980-46f4-87fe-4142b4220cfb', 'King', 'Admin', 'onlyKing@gmail.com', '7f7737fddd2842bc2afdbf1868aaa8e986b83133a1f010fe96535c15e4584628', 'admin', '2025-03-11 17:36:27', '2025-03-11 17:36:27');

-- --------------------------------------------------------

--
-- Table structure for table `vacations`
--

CREATE TABLE `vacations` (
  `id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `destination` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `start_date` date NOT NULL,
  `end_date` date NOT NULL,
  `price` decimal(10,0) NOT NULL,
  `file` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `vacations`
--

INSERT INTO `vacations` (`id`, `destination`, `description`, `start_date`, `end_date`, `price`, `file`, `created_at`, `updated_at`) VALUES
('01b4cc0e-9426-4205-8327-b371f9e543a2', 'Prague', 'A fairytale city with medieval architecture, cobbled streets, and a magical Old Town Square. Prague is perfect for wandering, with a beer culture to match.', '2025-05-15', '2025-05-25', 1750, 'il.co.johnbryce.rango25/8d055279-d71b-46bc-8fcf-b932003108de.png', '2025-04-13 19:54:58', '2025-04-13 19:54:58'),
('1500ff46-5349-497d-8e42-c6c5bcbde89e', 'Buenos Aires', 'The Paris of South America, known for tango, steak, and passionate football. It’s a city of wide boulevards, colorful neighborhoods, and rich cultural life.', '2025-10-10', '2025-10-20', 2200, 'il.co.johnbryce.rango25/5e2f2cbe-f35c-4b41-adf0-2b07f738f45f.png', '2025-04-13 19:56:03', '2025-04-13 19:56:03'),
('31991695-15c6-48d4-9368-179d5c2a925b', 'Marrakech', 'A city of spices, souks, and stunning Islamic architecture. Wander through the medina and explore the rich colors and flavors of Moroccan culture.', '2025-10-01', '2025-10-11', 1700, 'il.co.johnbryce.rango25/d50a9535-b730-477b-b6af-a1048f0c828f.png', '2025-04-13 20:01:06', '2025-04-13 20:01:06'),
('3ecb00b8-c175-4a87-af21-7fd73b8eac8e', 'Kyoto', 'Known for its classical Buddhist temples, gardens, imperial palaces, and traditional wooden houses. Kyoto is a peaceful blend of history and culture with stunning cherry blossoms in spring.', '2025-04-20', '2025-04-30', 2150, 'il.co.johnbryce.rango25/4f2f3bb4-2242-47c4-91b0-d7367a925a6b.png', '2025-04-13 19:48:36', '2025-04-13 19:48:36'),
('49968482-2e42-4a17-9992-1cd73c08e781', 'Reykjavík', 'Iceland’s capital is the perfect base for Northern Lights, geothermal spas, and dramatic landscapes. It’s a charming, artsy city with a love for music and nature.', '2025-11-01', '2025-11-10', 2400, 'il.co.johnbryce.rango25/b1e73746-7bc0-40ad-b8d2-45e5f7768135.png', '2025-04-13 19:50:47', '2025-04-13 19:50:47'),
('578c16fd-52a7-4f8b-a59f-85a00d884789', 'Vancouver', 'A coastal city with ocean, mountains, and forests all in reach. It’s a modern, diverse city known for outdoor activities, great food, and scenic views.', '2025-07-20', '2025-07-30', 2000, 'il.co.johnbryce.rango25/c400e764-ba2e-44ed-8de9-152c7254c4ec.png', '2025-04-13 19:58:49', '2025-04-13 19:58:49'),
('61dbb0a1-497a-4b8c-8718-d16f85c7a950', 'Cape Town', 'Surrounded by mountains and ocean, Cape Town boasts stunning views, vibrant culture, and world-class wines. Visit Table Mountain and the Cape of Good Hope.', '2025-09-05', '2025-09-15', 2300, 'il.co.johnbryce.rango25/f03fdcf7-b858-465f-a3a6-9dd4b2e6f4ae.png', '2025-04-13 19:51:50', '2025-04-13 19:51:50'),
('64ade4c0-dc50-4902-87a0-3e5be6efa197', 'Florence', 'The heart of the Renaissance, Florence is packed with world-class art, museums, and historic cathedrals. Its cobblestone streets are filled with charm and gourmet food.', '2025-07-01', '2025-07-10', 1950, 'il.co.johnbryce.rango25/9027978f-3b68-47fb-8755-f9bb39e24025.png', '2025-04-13 19:53:02', '2025-04-13 19:53:02'),
('a5cd557f-923c-4953-9037-e99cb3667fd8', 'Queenstown', 'Set on the shores of Lake Wakatipu and surrounded by mountains, it\'s a haven for outdoor lovers. Queenstown is famous for adventure sports and breathtaking scenery.', '2025-12-01', '2025-12-14', 2600, 'il.co.johnbryce.rango25/32711693-c1b6-4ce4-85c9-c3598f21520b.png', '2025-04-13 19:54:04', '2025-04-13 19:54:04'),
('bea0a936-cca8-498e-a12d-0c64c0fb7ec1', 'Barcelona', 'A lively city famous for Gaudí’s architecture, sunny beaches, and delicious tapas. Barcelona offers a mix of vibrant nightlife and historical beauty in every neighborhood.', '2025-06-10', '2025-06-20', 1800, 'il.co.johnbryce.rango25/bf1a56a6-6b3b-4549-a40f-3f7123cc6f25.png', '2025-04-13 19:49:57', '2025-04-13 19:49:57'),
('c941282d-9273-4a9b-a044-3f205e31bdd1', 'Hoi An', 'A charming riverside town with lantern-lit streets, preserved ancient buildings, and delicious street food. Hoi An blends culture, beaches, and tradition beautifully.', '2025-08-01', '2025-08-12', 1600, 'il.co.johnbryce.rango25/ac9fd4f8-fdf4-4369-b395-f912bc6b41c4.png', '2025-04-13 19:57:20', '2025-04-13 19:57:20'),
('dc238254-e1ca-469d-8f22-5fd3917ed821', 'Lisbon', 'A sun-drenched city of hills, trams, and pastel buildings. Lisbon offers rich history, coastal views, and a vibrant music and food scene.', '2025-06-05', '2025-06-15', 1850, 'il.co.johnbryce.rango25/b1972eeb-e565-4a5e-8ff3-fa57e826fc1d.png', '2025-04-13 19:59:52', '2025-04-13 19:59:52');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `follows`
--
ALTER TABLE `follows`
  ADD PRIMARY KEY (`user_id`,`vacation_id`),
  ADD UNIQUE KEY `follows_userId_vacationId_unique` (`user_id`,`vacation_id`),
  ADD KEY `vacation_id` (`vacation_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `vacations`
--
ALTER TABLE `vacations`
  ADD PRIMARY KEY (`id`);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `follows`
--
ALTER TABLE `follows`
  ADD CONSTRAINT `follows_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `follows_ibfk_2` FOREIGN KEY (`vacation_id`) REFERENCES `vacations` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
