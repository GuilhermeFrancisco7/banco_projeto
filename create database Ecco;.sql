CREATE DATABASE ecco;

CREATE TABLE produto(
    id INT PRIMARY KEY,
    produto VARCHAR(100) NOT NULL,
    tipo VARCHAR(100) NOT NULL,
    quant INT NOT NULL,
    valorunidade DECIMAL(6,2) NOT NULL,
    data_insercao DATE DEFAULT  CURRENT_DATE,
    data_alteracao DATE DEFAULT CURRENT_DATE );

-- Inserindo no banco de dados para teste.
INSERT INTO produto(id, produto,tipo,quant,valorunidade)
VALUES(1225,'Panela de Pressão','Ferro', 5,150.00);

SELECT id, produto, tipo, quant, valorunidade FROM produto;


UPDATE produto
SET tipo = 'Cerâmica'
WHERE quant = 5;

DELETE FROM produto
WHERE id = 1225;

CREATE TABLE caixa(
   idvenda INT PRIMARY KEY AUTO_INCREMENT,
   quant INT NOT NULL,
   valortotal INT  NOT NULL,
   valorcomdesconto INT NOT NULL,
   datacompra DATE DEFAULT CURRENT_DATE, 
   id_estoque INT,
   FOREIGN KEY(id_estoque) REFERENCES produto(id) ON DELETE CASCADE
   );


INSERT INTO caixa (quant, valortotal, valorcomdesconto, id_estoque)
VALUES(225,250.00,225);

SELECT * FROM caixa;

SELECT 
caixa.idvenda,
produto.produto,
caixa.quant,
produto.valorunidade
FROM caixa
INNER JOIN produto
ON caixa.id_estoque = produto.id;