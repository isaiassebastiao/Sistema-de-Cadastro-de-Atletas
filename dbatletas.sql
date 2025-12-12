-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Tempo de geração: 12/12/2025 às 15:41
-- Versão do servidor: 10.4.32-MariaDB
-- Versão do PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Banco de dados: `dbatletas`
--

-- --------------------------------------------------------

--
-- Estrutura para tabela `atletas`
--

CREATE TABLE `atletas` (
  `id` int(11) NOT NULL,
  `nome` varchar(100) NOT NULL,
  `municipio` varchar(100) NOT NULL,
  `data_nascimento` date DEFAULT NULL,
  `nivel_equipa` int(11) DEFAULT NULL,
  `id_clube` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `atletas`
--

INSERT INTO `atletas` (`id`, `nome`, `municipio`, `data_nascimento`, `nivel_equipa`, `id_clube`) VALUES
(7, 'Isaías Sebastião', 'Uíge', '2004-01-01', 3, 6),
(8, 'Isaías Sebastião', 'Uíge', '2005-01-01', 3, 6),
(9, 'Isaías Sebastião', 'Soyo', '2009-03-02', 2, 7),
(12, 'Isaías Sebastião', 'Uíge', '2002-12-12', 3, 1);

-- --------------------------------------------------------

--
-- Estrutura para tabela `categorias`
--

CREATE TABLE `categorias` (
  `id` int(11) NOT NULL,
  `categoria` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `categorias`
--

INSERT INTO `categorias` (`id`, `categoria`) VALUES
(1, 'Infantil'),
(2, 'Júnior'),
(3, 'Sênior');

-- --------------------------------------------------------

--
-- Estrutura para tabela `clubes`
--

CREATE TABLE `clubes` (
  `id` int(11) NOT NULL,
  `nome` varchar(100) NOT NULL,
  `municipio` varchar(100) NOT NULL,
  `vagas` int(11) DEFAULT 25
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `clubes`
--

INSERT INTO `clubes` (`id`, `nome`, `municipio`, `vagas`) VALUES
(1, 'Petro de Luanda', 'Luanda', 22),
(2, '1º de Agosto', 'Cacuaco', 25),
(3, 'Académica do Lobito', 'Lobito', 25),
(4, 'Progresso Associação do Sambizanga', 'Viana', 25),
(5, 'Sporting Clube de Benguela', 'Benguela', 25),
(6, 'Recreativo do Libolo', 'Uíge', 0),
(7, 'Sagrada Esperança', 'Soyo', 24),
(8, 'Desportivo da Huila', 'Lubango', 25),
(9, 'Kabuscorp Sport Clube do Palanca', 'Malanje', 25),
(10, 'Grupo Desportivo Interclube', 'Huambo', 25);

--
-- Índices para tabelas despejadas
--

--
-- Índices de tabela `atletas`
--
ALTER TABLE `atletas`
  ADD PRIMARY KEY (`id`),
  ADD KEY `nivel_equipa` (`nivel_equipa`),
  ADD KEY `id_clube` (`id_clube`);

--
-- Índices de tabela `categorias`
--
ALTER TABLE `categorias`
  ADD PRIMARY KEY (`id`);

--
-- Índices de tabela `clubes`
--
ALTER TABLE `clubes`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT para tabelas despejadas
--

--
-- AUTO_INCREMENT de tabela `atletas`
--
ALTER TABLE `atletas`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT de tabela `categorias`
--
ALTER TABLE `categorias`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de tabela `clubes`
--
ALTER TABLE `clubes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- Restrições para tabelas despejadas
--

--
-- Restrições para tabelas `atletas`
--
ALTER TABLE `atletas`
  ADD CONSTRAINT `atletas_ibfk_1` FOREIGN KEY (`id_clube`) REFERENCES `clubes` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `atletas_ibfk_2` FOREIGN KEY (`nivel_equipa`) REFERENCES `categorias` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
