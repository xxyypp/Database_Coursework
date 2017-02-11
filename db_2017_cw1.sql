-- Q1 returns (name,dod)
SELECT person.name, person.dod
FROM person, person
WHERE mother = (SELECT name
		FROM person)
AND (

;

-- Q2 returns (name)
SELECT name
FROM person
WHERE (father is not NULL)
AND (gender = 'M')
;

-- Q3 returns (name)

;

-- Q4 returns (name,father,mother)

;

-- Q5 returns (name,popularity)

;

-- Q6 returns (name,forties,fifties,sixties)

;


-- Q7 returns (father,mother,child,born)

;

-- Q8 returns (father,mother,male)

;

