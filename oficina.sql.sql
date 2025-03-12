-- Criação do Banco de Dados
DROP DATABASE IF EXISTS oficina;
CREATE DATABASE oficina;
USE oficina;

-- Tabela de Clientes
CREATE TABLE clientes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    cpf CHAR(11) UNIQUE NOT NULL,
    telefone VARCHAR(20),
    email VARCHAR(100)
);

-- Tabela de Veículos
CREATE TABLE veiculos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    cliente_id INT NOT NULL,
    placa CHAR(7) UNIQUE NOT NULL,
    marca VARCHAR(50) NOT NULL,
    modelo VARCHAR(50) NOT NULL,
    ano YEAR,
    FOREIGN KEY (cliente_id) REFERENCES clientes(id)
);

-- Tabela de Serviços
CREATE TABLE servicos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    descricao TEXT,
    preco DECIMAL(10,2) NOT NULL
);

-- Tabela de Mecânicos
CREATE TABLE mecanicos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    especialidade VARCHAR(100),
    telefone VARCHAR(20)
);

-- Tabela de Ordens de Serviço
CREATE TABLE ordens_servico (
    id INT AUTO_INCREMENT PRIMARY KEY,
    veiculo_id INT NOT NULL,
    mecanico_id INT NOT NULL,
    data_abertura DATE NOT NULL,
    data_conclusao DATE,
    status ENUM('ABERTA', 'EM ANDAMENTO', 'CONCLUIDA') DEFAULT 'ABERTA',
    FOREIGN KEY (veiculo_id) REFERENCES veiculos(id),
    FOREIGN KEY (mecanico_id) REFERENCES mecanicos(id)
);

-- Tabela de Peças
CREATE TABLE pecas (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    descricao TEXT,
    preco DECIMAL(10,2) NOT NULL,
    estoque INT DEFAULT 0
);

-- Tabela de Fornecedores
CREATE TABLE fornecedores (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    cnpj CHAR(14) UNIQUE NOT NULL,
    telefone VARCHAR(20)
);

-- Tabelas de Relacionamento
CREATE TABLE servicos_ordem (
    ordem_id INT NOT NULL,
    servico_id INT NOT NULL,
    PRIMARY KEY (ordem_id, servico_id),
    FOREIGN KEY (ordem_id) REFERENCES ordens_servico(id),
    FOREIGN KEY (servico_id) REFERENCES servicos(id)
);

CREATE TABLE pecas_ordem (
    ordem_id INT NOT NULL,
    peca_id INT NOT NULL,
    quantidade INT NOT NULL,
    PRIMARY KEY (ordem_id, peca_id),
    FOREIGN KEY (ordem_id) REFERENCES ordens_servico(id),
    FOREIGN KEY (peca_id) REFERENCES pecas(id)
);

CREATE TABLE pecas_fornecedor (
    peca_id INT NOT NULL,
    fornecedor_id INT NOT NULL,
    PRIMARY KEY (peca_id, fornecedor_id),
    FOREIGN KEY (peca_id) REFERENCES pecas(id),
    FOREIGN KEY (fornecedor_id) REFERENCES fornecedores(id)
);