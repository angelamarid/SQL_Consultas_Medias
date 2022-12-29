/* Mostre anos de nascimento únicos de pacientes e ordene-os em ordem crescente. */

select 
	distinct year (birth_date)
from patients
order by birth_date asc

/*Mostra nomes únicos da tabela de pacientes que ocorrem apenas uma vez na lista.

Por exemplo, se duas ou mais pessoas tiverem o nome 'John' na coluna first_name,
não inclua seus nomes na lista de saída. Se apenas 1 pessoa for chamada de 'Leo',
inclua-a na saída.*/

select 
	first_name
from patients
group by first_name
having
	count (first_name) = 1

/*Mostra o Patient_id e o first_name dos pacientes onde o first_name começa e
termina com 's' e tem pelo menos 6 caracteres.*/

select patient_id, first_name
from patients
where first_name like 's____%s'


/*Mostra o Patient_id, first_name, last_name de pacientes cujo diagnóstico é 
'Dementia'.
O diagnóstico primário é armazenado na tabela de admissões.*/

select 
	patients.patient_id, 
    first_name, 
    last_name
from patients
join admissions 
	on patients.patient_id = admissions.patient_id
where diagnosis = 'Dementia'


/*Exibe o nome de cada paciente.
Ordene a lista pelo comprimento de cada nome e depois por ordem alfabética*/
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
    
/*Mostrar nome e sobrenome, alergias de pacientes que têm alergia a 'Penicillin' 
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
    
/*Mostra o ID do paciente, diagnóstico das admissões. Encontre pacientes 
admitidos várias vezes para o mesmo diagnóstico.*/    

select 
	patient_id, 
    diagnosis
from admissions
group by 
	patient_id,
    diagnosis
having count (*) >1
    
    
/*Mostra a cidade e o número total de pacientes na cidade.
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

/*Mostre o nome, o sobrenome e a função de cada pessoa que é paciente ou médico.
As funções são "pacientes" ou "Doctor"*/

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
nasceram na década de 1970. Classifique a lista a partir da data de nascimento
mais antiga.*/

select 
	first_name, 
    last_name, 
    birth_date
from patients
where 
	year(birth_date) like '197%'
order by birth_date 
    
/*Queremos exibir o nome completo de cada paciente em uma única coluna. 
Seu sobrenome em letras maiúsculas deve aparecer primeiro, depois o primeiro nome 
em letras minúsculas. 
Separe o last_name e o first_name com uma vírgula. 
Ordene a lista pelo first_name em ordem decrescente
EX: SMITH,jane*/    

select 
	concat ( upper( last_name), ',',lower( first_name)) as nome_completo
from patients
order by first_name desc

/*Mostrar o(s) province_id(s), soma da altura; onde a soma total da altura 
de seu paciente é maior ou igual a 7.000.*/

select 
	province_id, 
    sum(height)
from patients
group by province_id
having  
	sum(height) >= 7000

/*Mostrar a diferença entre o maior peso e o menor peso para pacientes com 
o sobrenome 'Maroni'*/

select( max(weight) - min(weight)) as diferenca
from patients
where last_name = 'Maroni'


/*Mostra todos os dias do mês (1-31) e quantas datas de admissão ocorreram 
naquele dia. 
Classifique pelo dia com mais admissões para menos admissões.*/

select 
	day(admission_date) as dias, 
    count (admission_date) AS registros
from admissions
group by dias
order by registros desc

/*Mostra todas as colunas para a data de admissão mais recente do 
Patient_id 542.*/

select * 
from admissions
where patient_id = 542 
group by patient_id
having 
	admission_date = max(admission_date)

/*Mostre o Patient_id, attending_doctor_id e o diagnóstico para admissões que
correspondam a um dos dois critérios:
1. Patient_id é um número ímpar e Attend_doctor_id é 1, 5 ou 19.
2. Attend_doctor_id contém um 2 e o comprimento de Patient_id é 3 caracteres*/

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

/*Mostra first_name, last_name e o número total de internações atendidas 
por cada médico.
Cada internação foi acompanhada por um médico.*/

select 
	first_name, 
    last_name, 
    count( attending_doctor_id) as atendimento_total
from admissions as adm
join doctors as doc 
	on adm.attending_doctor_id = doc.doctor_id
group by first_name

/*Para cada médico, exiba sua identificação, nome completo e a primeira e a 
última data de internação em que compareceram.*/

select 
	doctor_id,
	concat(ph.first_name,' ', ph.last_name) as nome_completo,
    min( admission_date),
    max( admission_date)
from doctors as ph
join admissions as adm on ph.doctor_id = adm.attending_doctor_id
group by nome_completo

/*Exiba a quantidade total de pacientes para cada província. 
Ordem decrescente.*/

select 
	province_name, 
	count(patient_id) as total_pacientes
from province_names as pn
join patients on pn.province_id = patients.province_id
group by province_name 
order by total_pacientes desc

/*Para cada admissão, exiba o nome completo do paciente, o diagnóstico de 
admissão e o nome completo do médico que diagnosticou o problema.*/

select 
	concat (pat.first_name,' ', pat.last_name) as nome_paciente
    , diagnosis 
	,concat (ph.first_name,' ', ph.last_name) as nome_medico
from patients as pat
join admissions	 as adm on pat.patient_id = adm.patient_id
join doctors as ph on ph.doctor_id = adm.attending_doctor_id

/*exibir o número de pacientes duplicados com base em seu nome e sobrenome.*/

select
	count(*) as nomes_duplicados, 	 
	first_name,
    last_name
from patients 
group by 
	first_name,
    last_name
having count(*)  = 2



