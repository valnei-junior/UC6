Create Table if not exists Clients(
	id Serial primary key,
	nome VARCHAR(100) NOT NULL,
	email VARCHAR(100) NOT NULL UNIQUE,
	telefone VARCHAR(20) NOT NULL UNIQUE,
	data_cadastro DATE DEFAULT (CURRENT_DATE) NOT NULL
);

Create Table if not exists Servicos(
	id SERIAL primary key,
	nome VARCHAR(100) NOT NULL,
	descricao TEXT NOT NULL,
	preco DECIMAL(10,2) NOT NULL,
	tipo_servico VARCHAR(50) NOT NULL
);

Create Table if not exists Tecnico(
	id Serial primary key,
	nome VARCHAR(100) NOT NULL,
	especialidade VARCHAR(50) NOT NULL,
	data_contratacao DATE NOT NULL
);


Create Table if not exists chamados(

	id Serial primary key,
	cliente_id INT,
	tecnico_id INT,
	servico_id INT,
	data_chamado DATE NOT NULL,
	status VARCHAR(20) NOT NULL,
	Constraint fk_clients foreign key (cliente_id) references Clients(id) on delete cascade,
	Constraint fk_tecnico foreign key (tecnico_id) references Tecnico(id) on delete cascade,
	Constraint fk_servico foreign key (servico_id) references Servicos(id) on delete cascade
);

Create Table if not exists pagamentos(
	id Serial primary key,
	cliente_id INT,
	chamado_id INT,
	valor_pago DECIMAL(10,2) NOT NULL,
	data_pagamento DATE NOT NULL,
	Constraint fk_clients_pagamentos foreign key (cliente_id) references Clients(id) on delete cascade,
	Constraint fk_chamado_id foreign key (chamado_id) references chamados(id) on delete cascade
); 
	
ALTER TABLE Servicos add constraint preco check (preco > 0);

ALTER TABLE chamados ADD CONSTRAINT chk_tipo CHECK (status IN ('Pendente', 'Finalizado'));

ALTER TABLE pagamentos add constraint valor_pago check (valor_pago > 0);

ALTER TABLE Servicos add constraint tipo_servico check (tipo_servico in('Consultoria', 'Suporte', 'Manutenção'));

ALTER TABLE chamados add COLUMN descricao text check (descricao <> '');

ALTER TABLE pagamentos add COLUMN forma_pagamento varchar(10) not null;

ALTER TABLE pagamentos add constraint forma_pagamentos check (forma_pagamento in ('Pix', 'Especie', 'Cartão'));



Insert into Clients ( nome, email, telefone, data_cadastro) 
values ('João Silva','joao@email.com','(11) 98765-4321', '2023-01-15');

Insert into Clients ( nome, email, telefone, data_cadastro)
values('Maria Oliveira', 'maria@email.com', '(21) 99654-3210', '2023-02-20');

Insert into Clients ( nome, email, telefone, data_cadastro)
values('Pedro Souza',  'pedro@email.com', '(31) 99765-1234', '2023-03-10');

Insert into Clients ( nome, email, telefone, data_cadastro)
values('Ana Costa', 'ana@email.com', '(41) 98888-9999', '2023-04-25'),

Insert into Clients ( nome, email, telefone, data_cadastro)
values('Lucas Almeida', 'lucas@email.com', '(61) 99123-4567', '2023-05-30');


Insert into Servicos (nome, descricao, preco, tipo_servico)
values('Consultoria em TI', 'Consultoria especializada em infraestrutura de T', '500.00', 'Consultoria');

Insert into Servicos (nome, descricao, preco, tipo_servico)
values ('Manutenção de Equipamentos', 'Manutenção preventiva e corretiva de equipamentos', '300.00', 'Manutenção');

Insert into Servicos (nome, descricao, preco, tipo_servico)
values ('Suporte Técnico', 'Suporte remoto e presencial para empresas', '200.00', 'Suporte');

Insert into Tecnico (nome, especialidade, data_contratacao)
values ('Carlos Oliveira', 'Consultoria TI', '2022-10-10');

Insert into Tecnico (nome, especialidade, data_contratacao)
values ('Fernanda Souza', 'Manutenção', '2021-06-15');

Insert into Tecnico (nome, especialidade, data_contratacao)
values ('Roberto Costa', 'Suporte Técnico', '2020-08-20');


Insert into Chamados (id, cliente_id, tecnico_id, servico_id, data_chamado, status, descricao)
values(1, 1, 1, 1, '2023-06-01', 'Pendente', 'Reparo no cabeamento de rede');

Insert into Chamados (id,cliente_id, tecnico_id, servico_id, data_chamado, status, descricao)
values(2, 2, 2, 2, '2023-07-10', 'Pendente', 'Manutenção no Servidor');

Insert into Chamados (id,cliente_id, tecnico_id, servico_id, data_chamado, status, descricao)
values(3, 3, 3, 3, '2023-08-05', 'Finalizado', 'Configuração de software empresarial');

Insert into Chamados (id,cliente_id, tecnico_id, servico_id, data_chamado, status, descricao)
values(4, 4, 1, 2, '2023-09-20',  'Pendente', 'Manutenção de computador');

Insert into Chamados (id, cliente_id, tecnico_id, servico_id, data_chamado, status, descricao)
values(5, 5, 2, 1, '2023-10-15', 'Finalizado', 'Suporte para software');


Insert into pagamentos (cliente_id, chamado_id, valor_pago, data_pagamento, forma_pagamento)
values(1, 1, '350.00', '2023-06-15', 'Pix');

Insert into pagamentos (cliente_id, chamado_id, valor_pago, data_pagamento, forma_pagamento)
values(2, 2, '450.00', '2023-07-15', 'Pix');

Insert into pagamentos (cliente_id, chamado_id, valor_pago, data_pagamento, forma_pagamento)
values(3, 3,'600.00', '2023-08-10', 'Cartão');

Insert into pagamentos (cliente_id, chamado_id, valor_pago, data_pagamento, forma_pagamento)
values(4, 4, '300.00', '2023-09-25', 'Pix');



QUESTÃO 4 Liste o nome e e-mail de todos os clientes cadastrados
SELECT nome,email FROM Clients;
 
--QUESTÃO 5 Recupere os nomes dos serviços disponíveis e seus respectivos preços.
SELECT tipo_servico,preco FROM Servicos
 
--QUESTÃO 6 Exiba os nomes e especialidades de todos os técnicos.
SELECT nome,especialidade FROM Tecnico
 
--QUESTÃO 7 Mostre a descrição e o status de todos os chamados registrados
SELECT descricao,status FROM Chamados
 
--QUESTÃO 8 Liste os valores pagos e as datas de pagamento de todos os registros na tabela de pagamentos.
SELECT valor_pago,data_pagamento FROM Pagamentos
 
--QUESTÃO 9 Liste os nomes dos clientes e as descrições de seus chamados que estão com o status "Em Andamento".
SELECT clients.nome, chamados.descricao
FROM Clients
JOIN Chamados ON Clients.id = Chamados.cliente_id
WHERE Chamados.status = 'Em andamento';
 
--QUESTÃO 10 Recupere os nomes dos técnicos que realizaram serviços com o tipo "Manutenção"
SELECT nome,especialidade FROM Tecnico WHERE especialidade = 'Manutenção';
 
--QUESTÃO 11 Mostre os nomes dos clientes e o valor total pago por cada um deles.
SELECT Clients.nome, Pagamentos.valor_pago
FROM Clients
JOIN Pagamentos ON Clients.id = pagamentos.cliente_id;
 
--QUESTÃO 12 Liste os clientes e os serviços que eles solicitaram, incluindo a descrição do serviço.
SELECT Clients.nome, Servicos.tipo_servico, Servicos.descricao, Servicos.nome, Servicos.preco
FROM Clients
JOIN Servicos ON Clients.id = Servicos.id
 
--QUESTÃO 13 Recupere os nomes dos técnicos que realizaram chamados para serviços com o preço superior a 400, e exiba também o nome do serviço.
SELECT Tecnico.nome, Servicos.preco, Servicos.nome
FROM Tecnico
JOIN Servicos ON Tecnico.id = Servicos.id
WHERE preco > 400.00;
 
--QUESTÃO 14 Atualize o preço de todos os serviços do tipo "Manutenção" para 350, se o preço atual for inferior a 350.

UPDATE Servicos
SET preco = 350
WHERE tipo_servico = 'Manutenção' AND preco < 350;

SELECT * FROM Servicos
 
--QUESTÃO 15 Exclua todos os técnicos que não têm chamados registrados.
SELECT * FROM Tecnico
WHERE id NOT IN (SELECT DISTINCT tecnico_id FROM chamados);

SELECT * FROM Tecnico

SELECT * FROM chamados