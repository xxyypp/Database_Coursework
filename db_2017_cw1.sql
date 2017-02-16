-- Q1 returns (name,dod)
SELECT p_b.name,
			 p_a.dod
FROM 	 person AS p_a, person AS p_b
WHERE  p_a.name = p_b.mother
AND		 p_a.dod IS NOT NULL
ORDER BY p_b.name ASC
;

-- Q2 returns (name)
SELECT name
FROM person
WHERE gender = 'M'
AND name IS NOT NULL
AND name NOT IN (SELECT father
								 FROM person
								 WHERE father IS NOT NULL)
ORDER BY name ASC
;

-- Q3 returns (name)
SELECT DISTINCT p_mom.name
FROM person AS p_chi,
		 person AS p_mom
WHERE (p_mom.name = p_chi.mother)
AND		(p_chi.gender = 'M')
INTERSECT
SELECT DISTINCT p_mom.name
FROM person AS p_chi,
		 person AS p_mom
WHERE (p_mom.name = p_chi.mother)
AND		(p_chi.gender = 'F')
ORDER BY name ASC
;

-- Q4 returns (name,father,mother)
SELECT DISTINCT p_first.name,p_first.father,p_first.mother
FROM person AS p_first,
		 person AS p_other
WHERE p_first.father = p_other.father
AND p_first.mother = p_other.mother
AND p_first.name <> p_other.name
AND p_first.dob <= ALL (SELECT DISTINCT p_other.dob
												FROM person AS p_other
												WHERE p_first.father = p_other.father
												AND p_other.mother = p_first.mother)
ORDER BY p_first.father ASC
;

-- Q5 returns (name,popularity)
SELECT SUBSTRING(name FROM '[a-zA-Z]+') AS firstname,
			 COUNT(SUBSTRING(name FROM '[a-zA-Z]+')) AS popularity
FROM person
WHERE SUBSTRING(name FROM '[a-zA-Z]+') <> ''
GROUP BY firstname
HAVING COUNT(SUBSTRING(name FROM '[a-zA-Z]+')) > 1
ORDER BY popularity DESC
;

--SUBSTRING(name FROM '[a-zA-Z]+')

-- Q6 returns (name,forties,fifties,sixties)
SELECT father as name,
			 COUNT(CASE WHEN dob <= '1949-12-31' AND dob >= '1940-01-01' THEN father ELSE NULL END) AS forties,
			 COUNT(CASE WHEN dob <= '1959-12-31' AND dob >= '1950-01-01' THEN father ELSE NULL END) AS fifties,
			 COUNT(CASE WHEN dob <= '1969-12-31' AND dob >= '1960-01-01' THEN father ELSE NULL END) AS sixties
FROM person
WHERE father IS NOT NULL
GROUP BY father
HAVING COUNT(CASE WHEN dob <= '1949-12-31' AND dob >= '1940-01-01' THEN father ELSE NULL END) > 1
OR 		COUNT(CASE WHEN dob <= '1959-12-31' AND dob >= '1950-01-01' THEN father ELSE NULL END) > 1
OR		COUNT(CASE WHEN dob <= '1969-12-31' AND dob >= '1960-01-01' THEN father ELSE NULL END) > 1
ORDER BY FATHER
;
-- Q7 returns (father,mother,child,born)
SELECT father,
			 mother,
			 name AS child,
			 RANK() OVER (PARTITION BY father ORDER BY dob DESC) AS born
FROM person
WHERE father IS NOT NULL
AND mother IS NOT NULL
ORDER BY father,mother,born
;

-- Q8 returns (father,mother,male)
SELECT DISTINCT father,mother,
		ROUND (100*COUNT(CASE WHEN gender = 'M' THEN name ELSE NULL END)	OVER (PARTITION BY father) / (COUNT(CASE WHEN gender = 'M' THEN name ELSE NULL END)	OVER (PARTITION BY father) +
		COUNT(CASE WHEN gender = 'F' THEN name ELSE NULL END)	OVER (PARTITION BY father)),1) AS percentage
FROM person
WHERE father IS NOT NULL
AND mother IS NOT NULL
GROUP BY father,mother,name
ORDER BY father,mother
;
