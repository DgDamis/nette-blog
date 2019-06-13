-- phpMyAdmin SQL Dump
-- version 4.8.0.1
-- https://www.phpmyadmin.net/
--
-- Počítač: 127.0.0.1
-- Vytvořeno: Čtv 13. čen 2019, 23:12
-- Verze serveru: 10.1.32-MariaDB
-- Verze PHP: 7.2.5

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Databáze: `nette_blog`
--

-- --------------------------------------------------------

--
-- Struktura tabulky `comments`
--

CREATE TABLE `comments` (
  `id` int(11) NOT NULL,
  `post_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `content` text COLLATE utf8_czech_ci NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_czech_ci;

--
-- Vypisuji data pro tabulku `comments`
--

INSERT INTO `comments` (`id`, `post_id`, `user_id`, `content`, `created_at`) VALUES
(2, 10, 4, 'super', '2019-06-13 20:45:41');

-- --------------------------------------------------------

--
-- Struktura tabulky `posts`
--

CREATE TABLE `posts` (
  `id` int(11) NOT NULL,
  `title` varchar(22) COLLATE utf8_czech_ci NOT NULL,
  `content` text COLLATE utf8_czech_ci NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_czech_ci;

--
-- Vypisuji data pro tabulku `posts`
--

INSERT INTO `posts` (`id`, `title`, `content`, `created_at`) VALUES
(2, 'Article Two', 'Lorem ipsum dolor two', '2019-06-10 19:25:47'),
(3, 'Article Three', 'Lorem ipsum dolor three', '2019-06-10 19:25:47'),
(10, 'Lorem', 'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean id metus id velit ullamcorper pulvinar. Praesent id justo in neque elementum ultrices. Nullam rhoncus aliquam metus. Fusce aliquam vestibulum ipsum. Integer imperdiet lectus quis justo. Curabitur vitae diam non enim vestibulum interdum. Nunc auctor. Quisque tincidunt scelerisque libero. Aenean fermentum risus id tortor. Integer lacinia. Curabitur bibendum justo non orci. In laoreet, magna id viverra tincidunt, sem odio bibendum justo, vel imperdiet sapien wisi sed libero. Integer vulputate sem a nibh rutrum consequat.\n\nAliquam erat volutpat. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos hymenaeos. In sem justo, commodo ut, suscipit at, pharetra vitae, orci. Integer rutrum, orci vestibulum ullamcorper ultricies, lacus quam ultricies odio, vitae placerat pede sem sit amet enim. Donec vitae arcu. Aenean vel massa quis mauris vehicula lacinia. Suspendisse nisl. Fusce consectetuer risus a nunc. Donec quis nibh at felis congue commodo. Aenean id metus id velit ullamcorper pulvinar. Suspendisse nisl. Praesent id justo in neque elementum ultrices. Nam libero tempore, cum soluta nobis est eligendi optio cumque nihil impedit quo minus id quod maxime placeat facere possimus, omnis voluptas assumenda est, omnis dolor repellendus.\n\nAenean id metus id velit ullamcorper pulvinar. Suspendisse nisl. Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Mauris dolor felis, sagittis at, luctus sed, aliquam non, tellus. Praesent vitae arcu tempor neque lacinia pretium. Etiam dictum tincidunt diam. Donec iaculis gravida nulla. In dapibus augue non sapien. Sed convallis magna eu sem. In rutrum. Donec ipsum massa, ullamcorper in, auctor et, scelerisque sed, est. Etiam quis quam. Fusce suscipit libero eget elit. Nam sed tellus id magna elementum tincidunt.', '2019-06-13 16:26:42');

-- --------------------------------------------------------

--
-- Struktura tabulky `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `username` varchar(50) COLLATE utf8_czech_ci NOT NULL,
  `password` varchar(100) COLLATE utf8_czech_ci NOT NULL,
  `role` enum('guest','publisher','admin','') COLLATE utf8_czech_ci NOT NULL DEFAULT 'guest',
  `email` varchar(100) COLLATE utf8_czech_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_czech_ci;

--
-- Vypisuji data pro tabulku `users`
--

INSERT INTO `users` (`id`, `username`, `password`, `role`, `email`) VALUES
(2, 'admin', '$2y$10$AfWcuEzEBBslOzNZRkdNE.Y51Evvz6L0MXKpWpnAJMU.ZFaFJi3eK', 'admin', 'admin@example.com'),
(4, 'petr', '$2y$10$C8b4eMcytqFdSSrA4bP2JOe8wkg6odUZAkbCh5t4YjFdGpXC3prNa', 'guest', 'petr@example.com');

--
-- Klíče pro exportované tabulky
--

--
-- Klíče pro tabulku `comments`
--
ALTER TABLE `comments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `konektor` (`post_id`),
  ADD KEY `konekce` (`user_id`);

--
-- Klíče pro tabulku `posts`
--
ALTER TABLE `posts`
  ADD PRIMARY KEY (`id`);

--
-- Klíče pro tabulku `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT pro tabulky
--

--
-- AUTO_INCREMENT pro tabulku `comments`
--
ALTER TABLE `comments`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT pro tabulku `posts`
--
ALTER TABLE `posts`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT pro tabulku `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- Omezení pro exportované tabulky
--

--
-- Omezení pro tabulku `comments`
--
ALTER TABLE `comments`
  ADD CONSTRAINT `comments_ibfk_1` FOREIGN KEY (`post_id`) REFERENCES `posts` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `comments_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
