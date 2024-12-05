-- Tabela USUARIOS
CREATE TABLE IF NOT EXISTS USUARIOS (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    data_cadastro TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
-- Tabela EDITORA
CREATE TABLE IF NOT EXISTS EDITORA (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL UNIQUE
);
--Tabela Gênero
CREATE TABLE  IF NOT EXISTS  GENERO (
    id SERIAL PRIMARY KEY,
    descricao VARCHAR(50) NOT NULL UNIQUE
);

-- Tabela LIVROS
CREATE TABLE  IF NOT EXISTS  LIVROS (
    id SERIAL PRIMARY KEY,
    titulo VARCHAR(150) NOT NULL,
    quantidade_disponivel INT NOT NULL CHECK (quantidade_disponivel > 0),
    id_editora INT NOT NULL,
    id_genero INT NOT NULL,
    CONSTRAINT fk_livros_editora FOREIGN KEY (id_editora) REFERENCES editora (id) ON DELETE CASCADE,
    CONSTRAINT fk_livros_genero FOREIGN KEY (id_genero) REFERENCES genero (id) ON DELETE CASCADE
);

-- Tabela EMPRESTIMOS
CREATE TABLE  IF NOT EXISTS  EMPRESTIMOS (
    id SERIAL PRIMARY KEY,
    id_usuario INT NOT NULL,
    id_livro INT NOT NULL,
    data_emprestimo TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    data_devolucao TIMESTAMP NOT NULL,
    CONSTRAINT fk_emprestimos_usuarios FOREIGN KEY (id_usuario) REFERENCES usuarios (id) ON DELETE CASCADE,
    CONSTRAINT fk_emprestimos_livros FOREIGN KEY (id_livro) REFERENCES livros (id) ON DELETE CASCADE
);
\d usuarios
-- Adicionar um campo para armazenar o telefone dos usuários
--ALTER TABLE USUARIOS ADD TELEFONE CHAR(11);
ALTER TABLE USUARIOS ADD COLUMN TELEFONE CHAR(11) DEFAULT 'NENHUM';
--Altere o tamanho do campo titulo na tabela livros para comportar até  200 caracteres.
ALTER TABLE LIVROS ALTER COLUMN  TITULO TYPE VARCHAR(200);
\d LIVROS

--Remova o campo data_cadastro da tabela usuarios, pois ele não será mais utilizado
ALTER TABLE USUARIOS DROP COLUMN DATA_CADASTRO;

-- Garanta que o mesmo título de livro não possa ser registrado na mesma editora.
ALTER TABLE LIVROS ADD CONSTRAINT uq_livros_titulo_editora UNIQUE(titulo, id_editora);

-- Garantir que as datas de emprestimo e devolução sejam distintas e válidas.
ALTER TABLE EMPRESTIMOS ADD CONSTRAINT chk_data_devolucao CHECK (data_devolucao > data_emprestimo);
\d USUARIOS

INSERT INTO USUARIOS (ID, NOME, EMAIL, TELEFONE)
VALUES(1, 'Valtemir', 'valtermir@senac.br', '9999-9999'),
(2, 'Valtemir Júnior', 'valtermirjr@senac.br', '9998-9999'); 
SELECT *FROM USUARIOS;

INSERT INTO EDITORA(ID,NOME)
VALUES(1,'Senac'), (2,'Sesc'), (3,'Mundo'), (4,'Dark Side');
SELECT *FROM EDITORA;

INSERT INTO GENERO(ID,DESCRICAO)
VALUES(1,'Teror'), (2,'Drama'), (3,'Romance'), (4,'ficção'), (5,'Infantil');
SELECT *FROM GENERO;

INSERT INTO LIVROS(titulo,quantidade_disponivel,id_editora,id_genero)
VALUES
('Gabriel',1,1,1),
('Sergio',2,1,1),
('Joel',3,2,1),
('Pedro Lucas é chato',4,4,4),
('Valnei faltou ontem',10,3,5);
SELECT *FROM LIVROS;

INSERT INTO EMPRESTIMOS(ID_USUARIO,ID_LIVRO, DATA_DEVOLUCAO)
VALUES
(1, 4, '2024-12-06'),
(1, 4, '2024-12-06');

SELECT *FROM EMPRESTIMOS;
