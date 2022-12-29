/* Mostre anos de nascimento �nicos de pacientes e ordene-os em ordem crescente. */

select 
	distinct year (birth_date)
from patients
order by birth_date asc

/*Mostra nomes �nicos da tabela de pacientes que ocorrem apenas uma vez na lista.

Por exemplo, se duas ou mais pessoas tiverem o nome 'John' na coluna first_name,
n�o inclua seus nomes na lista de sa�da. Se apenas 1 pessoa for chamada de 'Leo',
inclua-a na sa�da.*/

select 
	first_name
from patients
group by first_name
having
	count (first_name) = 1

/*Mostra o Patient_id e o first_name dos pacientes onde o first_name come�a e
termina com 's' e tem pelo menos 6 caracteres.*/

select patient_id, first_name
from patients
where first_name like 's____%s'


/*Mostra o Patient_id, first_name, last_name de pacientes cujo diagn�stico � 
'Dementia'.
O diagn�stico prim�rio � armazenado na tabela de admiss�es.*/

select 
	patients.patient_id, 
    first_name, 
    last_name
from patients
join admissions 
	on patients.patient_id = admissions.patient_id
where diagnosis = 'Dementia'


/*Exibe o nome de cada paciente.
Ordene a lista pelo comprimento de cada nome e depois por ordem alfab�tica*/
select first_name 
from patients
order by 
	len(first_name),
	first_name

/*Mostre a quantidade total de pacientes do sexo masculino e a quantidade total 
de pacientes do sexo feminino na tabela de pacientes.
Exiba os dois resultados na mesma linha.*/

select
	(select count(*)  from patients where gender = 'M') as totalM,
    (select count(*)  from patients where gender = 'F') as totalF
    
/*Mostrar nome e sobrenome, alergias de pacientes que t�m alergia a 'Penicillin' 
ou 'Morphine'. Mostrar resultados ordenados por alergias, depois por first_name
e por last_name.*/    

select 
	first_name, 
    last_name, 
    allergies
from patients
where 
	allergies = 'Morphine' OR allergies = 'Penicillin'
order by 
	allergies , 
    first_name,
    last_name   
    
/*Mostra o ID do paciente, diagn�stico das admiss�es. Encontre pacientes 
admitidos v�rias vezes para o mesmo diagn�stico.*/    

select 
	patient_id, 
    diagnosis
from admissions
group by 
	patient_id,
    diagnosis
having count (*) >1
    
    
/*Mostra a cidade e o n�mero total de pacientes na cidade.
Ordene de mais para menos pacientes e, em seguida, pelo nome da cidade em 
ordem crescente.*/   

select 
	city, 
    count (patient_id)  AS total_pacientes
from patients
group by 
	city
order by 
	total_pacientes desc, 
    city

/*Mostre o nome, o sobrenome e a fun��o de cada pessoa que � paciente ou m�dico.
As fun��es s�o "pacientes" ou "Doctor"*/

select 
	first_name, 
    last_name , 
    'pacientes' as funcao  from patients
union all 
select 
	first_name, 
    last_name ,
    'medico'  from patients


/*Mostrar todas as alergias ordenadas por popularidade. Remova os valores 
NULL da consulta.*/

select 
	allergies 
    , count (patient_id) as total_diag
from patients
where 
	allergies is not null
group by allergies 
order by total_diag desc

/*Mostre o nome, sobrenome e data de nascimento de todos os pacientes que 
nasceram na d�cada de 1970. Classifique a lista a partir da data de nascimento
mais antiga.*/

select 
	first_name, 
    last_name, 
    birth_date
from patients
where 
	year(birth_date) like '197%'
order by birth_date 
    
/*Queremos exibir o nome completo de cada paciente em uma �nica coluna. 
Seu sobrenome em letras mai�sculas deve aparecer primeiro, depois o primeiro nome 
em letras min�sculas. 
Separe o last_name e o first_name com uma v�rgula. 
Ordene a lista pelo first_name em ordem decrescente
EX: SMITH,jane*/    

select 
	concat ( upper( last_name), ',',lower( first_name)) as nome_completo
from patients
order by first_name desc

/*Mostrar o(s) province_id(s), soma da altura; onde a soma total da altura 
de seu paciente � maior ou igual a 7.000.*/

select 
	province_id, 
    sum(height)
from patients
group by province_id
having  
	sum(height) >= 7000

/*Mostrar a diferen�a entre o maior peso e o menor peso para pacientes com 
o sobrenome 'Maroni'*/

select( max(weight) - min(weight)) as diferenca
from patients
where last_name = 'Maroni'


/*Mostra todos os dias do m�s (1-31) e quantas datas de admiss�o ocorreram 
naquele dia. 
Classifique pelo dia com mais admiss�es para menos admiss�es.*/

select 
	day(admission_date) as dias, 
    count (admission_date) AS registros
from admissions
group by dias
order by registros desc

/*Mostra todas as colunas para a data de admiss�o mais recente do 
Patient_id 542.*/

select * 
from admissions
where patient_id = 542 
group by patient_id
having 
	admission_date = max(admission_date)

/*Mostre o Patient_id, attending_doctor_id e o diagn�stico para admiss�es que
correspondam a um dos dois crit�rios:
1. Patient_id � um n�mero �mpar e Attend_doctor_id � 1, 5 ou 19.
2. Attend_doctor_id cont�m um 2 e o comprimento de Patient_id � 3 caracteres*/

SELECT
  patient_id,
  attending_doctor_id,
  diagnosis
FROM admissions
WHERE
  (
    attending_doctor_id IN (1, 5, 19)
    AND patient_id % 2 != 0
  )
  OR 
  (
    attending_doctor_id LIKE '%2%'
    AND len(patient_id) = 3
  )

/*Mostra first_name, last_name e o n�mero total de interna��es atendidas 
por cada m�dico.
Cada interna��o foi acompanhada por um m�dico.*/

select 
	first_name, 
    last_name, 
    count( attending_doctor_id) as atendimento_total
from admissions as adm
join doctors as doc 
	on adm.attending_doctor_id = doc.doctor_id
group by first_name

/*Para cada m�dico, exiba sua identifica��o, nome completo e a primeira e a 
�ltima data de interna��o em que compareceram.*/

select 
	doctor_id,
	concat(ph.first_name,' ', ph.last_name) as nome_completo,
    min( admission_date),
    max( admission_date)
from doctors as ph
join admissions as adm on ph.doctor_id = adm.attending_doctor_id
group by nome_completo

/*Exiba a quantidade total de pacientes para cada prov�ncia. 
Ordem decrescente.*/

select 
	province_name, 
	count(patient_id) as total_pacientes
from province_names as pn
join patients on pn.province_id = patients.province_id
group by province_name 
order by total_pacientes desc

/*Para cada admiss�o, exiba o nome completo do paciente, o diagn�stico de 
admiss�o e o nome completo do m�dico que diagnosticou o problema.*/

select 
	concat (pat.first_name,' ', pat.last_name) as nome_paciente
    , diagnosis 
	,concat (ph.first_name,' ', ph.last_name) as nome_medico
from patients as pat
join admissions	 as adm on pat.patient_id = adm.patient_id
join doctors as ph on ph.doctor_id = adm.attending_doctor_id

/*exibir o n�mero de pacientes duplicados com base em seu nome e sobrenome.*/

select
	count(*) as nomes_duplicados, 	 
	first_name,
    last_name
from patients 
group by 
	first_name,
    last_name
having count(*)  = 2



