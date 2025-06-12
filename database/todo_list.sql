-- phpMyAdmin SQL Dump
-- version 5.2.2
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Jun 12, 2025 at 06:07 PM
-- Server version: 8.0.30
-- PHP Version: 8.1.10

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `todo_list_db`
--

-- --------------------------------------------------------

--
-- Table structure for table `cache`
--

CREATE TABLE `cache` (
  `key` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` mediumtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `expiration` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `cache_locks`
--

CREATE TABLE `cache_locks` (
  `key` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `owner` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `expiration` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `failed_jobs`
--

CREATE TABLE `failed_jobs` (
  `id` bigint UNSIGNED NOT NULL,
  `uuid` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `connection` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `jobs`
--

CREATE TABLE `jobs` (
  `id` bigint UNSIGNED NOT NULL,
  `queue` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `attempts` tinyint UNSIGNED NOT NULL,
  `reserved_at` int UNSIGNED DEFAULT NULL,
  `available_at` int UNSIGNED NOT NULL,
  `created_at` int UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `job_batches`
--

CREATE TABLE `job_batches` (
  `id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `total_jobs` int NOT NULL,
  `pending_jobs` int NOT NULL,
  `failed_jobs` int NOT NULL,
  `failed_job_ids` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `options` mediumtext COLLATE utf8mb4_unicode_ci,
  `cancelled_at` int DEFAULT NULL,
  `created_at` int NOT NULL,
  `finished_at` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

CREATE TABLE `migrations` (
  `id` int UNSIGNED NOT NULL,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '0001_01_01_000000_create_users_table', 1),
(2, '0001_01_01_000001_create_cache_table', 1),
(3, '0001_01_01_000002_create_jobs_table', 1),
(4, '2025_05_30_151305_create_tasks_table', 1),
(5, '2025_05_31_043951_remove_priority_from_tasks_table', 1),
(6, '2025_05_31_085902_add_completed_at_to_tasks_table', 2),
(7, '2025_05_31_182314_change_due_date_and_completed_at_to_date_in_tasks_table', 3),
(8, '2025_06_01_140150_create_personal_access_tokens_table', 4),
(9, '2025_06_01_160048_create_personal_access_tokens_table', 5),
(10, '2025_06_01_171030_create_personal_access_tokens_table', 6),
(12, '2025_06_06_144231_add_user_id_to_tasks_table', 7),
(13, '2025_06_08_140444_change_completed_at_to_timestamp_in_tasks_table', 8);

-- --------------------------------------------------------

--
-- Table structure for table `password_reset_tokens`
--

CREATE TABLE `password_reset_tokens` (
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `personal_access_tokens`
--

CREATE TABLE `personal_access_tokens` (
  `id` bigint UNSIGNED NOT NULL,
  `tokenable_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tokenable_id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `abilities` text COLLATE utf8mb4_unicode_ci,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `personal_access_tokens`
--

INSERT INTO `personal_access_tokens` (`id`, `tokenable_type`, `tokenable_id`, `name`, `token`, `abilities`, `last_used_at`, `expires_at`, `created_at`, `updated_at`) VALUES
(2, 'App\\Models\\User', 2, 'api-token', 'c6c4eba5863f0c912a2b4b4d3eb138f28dcb2b19f4fe602dc40e39c5dbba1253', '[\"*\"]', '2025-06-06 06:47:01', NULL, '2025-06-06 06:46:06', '2025-06-06 06:47:01'),
(4, 'App\\Models\\User', 3, 'api-token', 'c7b693af6f4d6bb874d7f59c0602a655a791f91eeb5d9ce8767d2906188ef2c8', '[\"*\"]', '2025-06-06 07:02:41', NULL, '2025-06-06 07:02:41', '2025-06-06 07:02:41'),
(8, 'App\\Models\\User', 4, 'api-token', '6a0dbd941068b87dedd511d0f91d69d5b40de684723446fda258091a56a15b58', '[\"*\"]', '2025-06-06 08:11:57', NULL, '2025-06-06 08:10:01', '2025-06-06 08:11:57'),
(10, 'App\\Models\\User', 5, 'api-token', 'd386a8ce57d3b26a53f0920dbe15fe2d74840c6f0175bc8c03c47072774e03c4', '[\"*\"]', '2025-06-06 08:31:54', NULL, '2025-06-06 08:29:35', '2025-06-06 08:31:54'),
(19, 'App\\Models\\User', 6, 'api-token', 'c88c8b28627ddd6661455015a1e5872b37e855312c719e0cff86eb0385a0b04d', '[\"*\"]', '2025-06-08 08:14:42', NULL, '2025-06-08 07:58:48', '2025-06-08 08:14:42'),
(21, 'App\\Models\\User', 7, 'api-token', '194e9bf0696d68fdc00d9c6120504d257e693bc70ddcfb94619927cc6e0cd1c8', '[\"*\"]', '2025-06-08 08:16:46', NULL, '2025-06-08 08:15:44', '2025-06-08 08:16:46'),
(24, 'App\\Models\\User', 8, 'api-token', '77c293e3d2a528262a5d9703600922782936122673ca5312714c2a546be8b327', '[\"*\"]', '2025-06-08 12:00:10', NULL, '2025-06-08 11:57:52', '2025-06-08 12:00:10'),
(27, 'App\\Models\\User', 10, 'api-token', 'bc54e33154b87d4d8d25ab7901594d396de4fe8a026e262bdbc35aad066eb344', '[\"*\"]', NULL, NULL, '2025-06-08 12:18:09', '2025-06-08 12:18:09'),
(30, 'App\\Models\\User', 12, 'api-token', '05bf3a8e3407f742f8ecb5d40f7145c111e69d706f8e899fda15e8c1daecaedc', '[\"*\"]', NULL, NULL, '2025-06-08 12:35:01', '2025-06-08 12:35:01'),
(31, 'App\\Models\\User', 9, 'api-token', '5f1e78af943062b8169ac25afc01ebfb186d067284e411e1dd6b8e44f1120dec', '[\"*\"]', '2025-06-08 12:37:49', NULL, '2025-06-08 12:37:48', '2025-06-08 12:37:49'),
(32, 'App\\Models\\User', 11, 'api-token', 'f5ce686d54a1416e55dceb5fec132560c15ad0ae03acf1b183cc2f1778b30bf8', '[\"*\"]', '2025-06-08 12:38:09', NULL, '2025-06-08 12:38:08', '2025-06-08 12:38:09'),
(33, 'App\\Models\\User', 13, 'api-token', 'baca4d409b1308c5966e7a94f38fd5b028c78c499a4941f2bbf46fc0868cf457', '[\"*\"]', NULL, NULL, '2025-06-08 12:38:40', '2025-06-08 12:38:40'),
(34, 'App\\Models\\User', 14, 'api-token', '2fef0cef8f79e5d13fa10c6d7185f48d20cce07117745c7ea905a6a74fcc9d18', '[\"*\"]', NULL, NULL, '2025-06-08 12:39:11', '2025-06-08 12:39:11'),
(35, 'App\\Models\\User', 15, 'api-token', 'e769145abc6c28c0e867a7053a56066eec14cbff04fa529505b848f2f2a58d80', '[\"*\"]', NULL, NULL, '2025-06-08 12:44:07', '2025-06-08 12:44:07'),
(36, 'App\\Models\\User', 16, 'api-token', 'f6b2dbf64b480a4d77f878259bd6b5f0984b02e6790a45ea9c930ad502c13aa3', '[\"*\"]', NULL, NULL, '2025-06-08 12:46:40', '2025-06-08 12:46:40'),
(38, 'App\\Models\\User', 17, 'api-token', '16a812e38a6488a5617baab518c5da6bc23308278c54301463388d4ed5ec7425', '[\"*\"]', '2025-06-08 12:49:11', NULL, '2025-06-08 12:49:11', '2025-06-08 12:49:11'),
(40, 'App\\Models\\User', 18, 'api-token', '5b17aebe17373ef6918a03984a37507805d94fdeb4a2f39b2e98d890a33031d4', '[\"*\"]', '2025-06-08 13:07:13', NULL, '2025-06-08 13:06:37', '2025-06-08 13:07:13'),
(42, 'App\\Models\\User', 19, 'api-token', '66bb9e730c299620807c63cf0f7a9b60ee6e26136b7c3217a64f03dcdc0f0f49', '[\"*\"]', '2025-06-08 13:11:30', NULL, '2025-06-08 13:11:05', '2025-06-08 13:11:30'),
(44, 'App\\Models\\User', 20, 'api-token', '138b5215d160d641c816f24e1c76baabc6b16a28f318ebdb2f08021ff64b6151', '[\"*\"]', '2025-06-12 17:46:10', NULL, '2025-06-12 17:44:00', '2025-06-12 17:46:10');

-- --------------------------------------------------------

--
-- Table structure for table `sessions`
--

CREATE TABLE `sessions` (
  `id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint UNSIGNED DEFAULT NULL,
  `ip_address` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_agent` text COLLATE utf8mb4_unicode_ci,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_activity` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tasks`
--

CREATE TABLE `tasks` (
  `id` bigint UNSIGNED NOT NULL,
  `user_id` bigint UNSIGNED DEFAULT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `due_date` date NOT NULL,
  `is_done` tinyint(1) NOT NULL DEFAULT '0',
  `completed_at` timestamp NULL DEFAULT NULL,
  `is_important` tinyint(1) NOT NULL DEFAULT '0',
  `description` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `email_verified_at`, `password`, `remember_token`, `created_at`, `updated_at`) VALUES
(20, 'rufie', 'rufie@gmail.com', NULL, '$2y$12$RZLwgjgb4nf5NUicj/kRs.OgXFMXE.6.Pu6xpZJGZP1jIUnjx5KvW', NULL, '2025-06-12 17:43:39', '2025-06-12 17:43:39');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `cache`
--
ALTER TABLE `cache`
  ADD PRIMARY KEY (`key`);

--
-- Indexes for table `cache_locks`
--
ALTER TABLE `cache_locks`
  ADD PRIMARY KEY (`key`);

--
-- Indexes for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`);

--
-- Indexes for table `jobs`
--
ALTER TABLE `jobs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `jobs_queue_index` (`queue`);

--
-- Indexes for table `job_batches`
--
ALTER TABLE `job_batches`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `password_reset_tokens`
--
ALTER TABLE `password_reset_tokens`
  ADD PRIMARY KEY (`email`);

--
-- Indexes for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  ADD KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`);

--
-- Indexes for table `sessions`
--
ALTER TABLE `sessions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sessions_user_id_index` (`user_id`),
  ADD KEY `sessions_last_activity_index` (`last_activity`);

--
-- Indexes for table `tasks`
--
ALTER TABLE `tasks`
  ADD PRIMARY KEY (`id`),
  ADD KEY `tasks_user_id_foreign` (`user_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_email_unique` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `jobs`
--
ALTER TABLE `jobs`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=45;

--
-- AUTO_INCREMENT for table `tasks`
--
ALTER TABLE `tasks`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=52;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `tasks`
--
ALTER TABLE `tasks`
  ADD CONSTRAINT `tasks_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
