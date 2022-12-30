
/*Selecione todos os registros da Customerstabela, classifique o resultado em ordem alfabética, 
primeiro pela coluna Countrye depois pela coluna City.*/
SELECT * FROM Customers
ORDER BY 
	Country,
	City


/*Insira um novo registro na Customerstabela.*/
INSERT INTO
 Customers (
	CustomerName, 
	Address, 
	City, 
	PostalCode,
	Country
	)
VALUES (
	'Hekkan Burger',
	'Gateveien 15',
	'Sandnes',
	'4306',
	'Norway'
	)


/*Selecione todos os registros de Customersonde a PostalCodecoluna NÃO está vazia.*/
SELECT * FROM Customers
WHERE PostalCode IS NOT NULL


/*Atualize a Citycoluna de todos os registros na Customerstabela.*/
UPDATE  
	Customers
SET 
	City = 'Oslo'

/*Defina o valor das Citycolunas como 'Oslo', mas apenas aquelas em que a Countrycoluna tem o 
valor "Noruega".*/
UPDATE
 Customers
SET
 City = 'Oslo'
WHERE
 Country = 'Norway'

 
 /*Atualize o Cityvalor e o Countryvalor.*/
UPDATE Customers
SET
	City = 'Oslo',
	Country = 'Norway'
WHERE 
	CustomerID = 32


/*Exclua todos os registros da Customerstabela onde o Countryvalor é 'Noruega'.*/
DELETE FROM Customers
WHERE Country = 'Norway'


/*Exclua todos os registros da Customerstabela.*/
DELETE FROM = Customers


/*------------------FUNCAO-------------*/
/*Use a MINfunção para selecionar o registro com o menor valor da Pricecoluna.*/
SELECT MIN(Price)
FROM Products

/*Use a função correta para retornar o número de registros com o Pricevalor definido como 18.*/
SELECT COUNT (*)
FROM Products
WHERE
 Price = 18


/*Use uma função SQL para calcular o preço médio de todos os produtos.*/
 SELECT AVG(Price)
 FROM Products


/*Selecione todos os registros onde o valor da Citycoluna contém a letra "a".*/
SELECT * FROM Customers
WHERE City LIKE '%a%'


/*Selecione todos os registros onde o valor da Citycoluna começa com a letra "a" e termina com a 
letra "b".*/
SELECT * FROM Customers
WHERE City LIKE 'a%b'


/*Selecione todos os registros onde o valor da Citycoluna NÃO comece com a letra "a".*/
SELECT 
	* 
	FROM Customers
WHERE 
	City NOT LIKE 'a%'


/*Selecione todos os registros em que a segunda letra do Cityé um "a".*/
SELECT * FROM Customers
WHERE City LIKE '_a%'


/*Selecione todos os registros em que a primeira letra do Cityé um "a" ou um "c" ou um "s".*/
SELECT 
	*
	FROM Customers
WHERE 
	City LIKE '[acs]%'


/*Selecione todos os registros em que a primeira letra Citycomeça com qualquer coisa, de "a" a "f".*/
SELECT 
	* 
	FROM Customers
WHERE 
	City LIKE '[a-f]%'


/*Selecione todos os registros em que a primeira letra CityNÃO seja "a" ou "c" ou "f".*/
SELECT 
	* 
	FROM Customers
WHERE 
	City LIKE '[!acf]%'


/*Use o INoperador para selecionar todos os registros onde Country está "Noruega" ou "França".*/
SELECT 
	* 
	FROM Customers
WHERE Country 
	IN ('Norway', 'France')


/*Use o INoperador para selecionar todos os registros onde Country NÃO é "Noruega" e NÃO é "França".*/
SELECT 
* 
FROM Customers
WHERE Country 
	NOT IN ('Norway', 'France')


/*Use o BETWEENoperador para selecionar todos os registros onde o valor da Pricecoluna está 
entre 10 e 20.*/
SELECT 
	* 
	FROM Products
WHERE Price 
	BETWEEN 10 AND 20

/*Use o BETWEENoperador para selecionar todos os registros onde o valor da Pricecoluna NÃO está 
entre 10 e 20.*/
SELECT 
	* 
	FROM Products
WHERE Price 
	NOT BETWEEN 10 AND 20

/*Use o BETWEENoperador para selecionar todos os registros onde o valor da ProductNamecoluna está 
alfabeticamente entre 'Geitost' e 'Pavlova'.*/
SELECT 
	* 
	FROM Products
WHERE ProductName 
	BETWEEN 'Geitost' AND 'Pavlova'


	 
/*Ao exibir a tabela Customers , renomeir a coluna PostalCode,por Pno .*/
SELECT 
	CustomerName,
	Address,
	PostalCode AS Pno
FROM Customers


/*INNER JOIN: Retorna registros que possuem valores correspondentes em ambas as tabelas
LEFT JOIN: Retorna todos os registros da tabela da esquerda e os registros correspondentes da 
tabela da direita
RIGHT JOIN: Retorna todos os registros da tabela da direita e os registros correspondentes da
tabela da esquerda
FULL JOIN: Retorna todos os registros quando há uma correspondência na tabela esquerda ou direita*/


/*faça a junçao das duas tabelas Orders e Customers, usando o CustomerIDcampo em ambas as tabelas 
como o relacionamento entre as duas tabelas.*/
SELECT *
FROM Orders
LEFT JOIN Customers
	ON Orders.CustomerID = Customers.CustomerID

/*selecionar todos os registros das duas tabelas onde há uma correspondência em ambas as tabelas.*/
SELECT *
FROM Orders
INNER JOIN Customers
	ON Orders.CustomerID=Customers.CustomerID

/*selecionar todos os registros da tabela Customers e todas as correspondências na tabela Orders.*/
SELECT *
FROM Orders
RIGHT JOIN Customers
	ON Orders.CustomerID=Customers.CustomerID


/*Liste o número de clientes em cada país, ordenados primeiro pelo país com mais clientes.*/
SELECT 
	COUNT (CustomerID),
	Country
FROM Customers
GROUP BY Country
ORDER BY 
	COUNT(CustomerID) DESC


/*Escreva a instrução SQL correta para criar um novo banco de dados chamado testDB*/
CREATE DATABASE testDB


/*Escreva a instrução SQL correta para excluir um banco de dados chamado testDB*/
DROP DATABASE testDB


/*Escreva a instrução SQL correta para criar uma nova tabela chamada Persons*/
CREATE TABLE 
	Persons (
		 PersonID int,
		 LastName varchar(255),
		 FirstName varchar(255),
		 Address varchar(255),
		 City varchar(255) 
)



/*Escreva a instrução SQL correta para excluir uma tabela chamada Persons.*/
DROP TABLE  Persons


/*Use a TRUNCATEinstrução para excluir todos os dados dentro de uma tabela.*/
TRUNCATE TABLE Persons

/*Adicione uma coluna do tipo DATEchamada Birthday.*/
ALTER TABLE	Persons
ADD Birthday DATE


/*Exclua a coluna Birthdayda Personstabela.*/
ALTER TABLE Persons
DROP COLUMN Birthday




