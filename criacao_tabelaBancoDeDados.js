
--CRIANDO UMBANCO DE DADOS
--CREATE DATA BASE aula 312

--Criando uma tabela
-- CREATE TABLE IF NOT EXISTS PRODUTO(

--     ID int PRIMARY KEY,
--     COD VARCHAR(4) NOT NULL UNIQUE,
--     NOME VARCHAR (100) NOT NULL,
--     PRECO real CHECK(PRECO>0)
-- );

-- CREATE TABLE IF NOT EXISTS PRODUTO1( 

--     ID int PRIMARY KEY,
--     COD VARCHAR(4) NOT NULL UNIQUE,
--     NOME VARCHAR (100) NOT NULL,
--     PRECO real CHECK(PRECO>0)
-- );


-- \dt;

-- \d PRODUTO;
--Deletando uma base de DADOS
-- DROP DATEBASE aula0312;

--Deletando uma tabela
-- DROP TABLE PRODUTO;
-- \dt;

----------------------------------------------------------------------------------------------
--CRIAR DUAS TABELAS
--PROFESSOR (ID,NOME,CPF)
--TURMA (id*,numero*, duracao_dias)


-- CREATE TABLE IF NOT EXISTS  PROFESSOR(
-- ID int PRIMARY KEY,
-- NOME VARCHAR (100) NOT NULL,
-- CPF CHAR(11) UNIQUE NOT NULL
-- );
 
-- CREATE TABLE IF NOT EXISTS TURMA( 
--   id int,
--   numero INT,
--   duracao_dias INT,
--   ID_PROFESSOR INT,
--   PRIMARY KEY(ID,NUMERO),
-- CONSTRAINT fk_prof FOREIGN KEY (ID_PROFESSOR) REFERENCES PROFESSOR (ID)
-- );
 
-- \dt;
-- \d PROFESSOR  --para aparecer dados do professor
-- \d TURMA     --aparecendo dados de TURMA
 
 
 ----------------------------------------------------------------------------------------------
 --defina as tabelas abaixo utilizando SQL
-- *fornecedor (id, nome, cidade)
-- *peca (id, nome, descricao)
-- *venda (idfornecedor, idpeca, data, quantidade)
 
-- è obrigatório que o nome da peça e do fornecedor não sejam valores nulos
 
 CREATE TABLE IF NOT EXISTS FORNECEDOR(
  id int PRIMARY KEY,
  NOME VARCHAR (100) NOT NULL,
  CIDADE VARCHAR (100)
  );
  
  CREATE TABLE IF NOT EXISTS PECA(
  id int PRIMARY KEY,
  NOME VARCHAR (100) NOT NULL,
  descricao TEXT
  );
  
  CREATE TABLE IF NOT EXISTS VENDA(
  id_fornecedor int,
  id_peca int,
  data date,
  quantidade char (11),
  PRIMARY KEY(id_fornecedor, id_peca),
  FOREIGN KEY (id_fornecedor) REFERENCES fornecedor(ID),
  FOREIGN KEY (id_peca) REFERENCES PECA(id)
  );
  
  ALTER TABLE FORNECEDOR ADD TELEFONE CHAR (11);  --adicionar telefone na coluna
  ALTER TABLE PECA ADD PRECO REAL;               -- adicionar preço
  ALTER TABLE FORNECEDOR DROP CIDADE;             -- remover CIDADE
  
  
  
\dt
\d FORNECEDOR
\d PECA
\d VENDA
 
 