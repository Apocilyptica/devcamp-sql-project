USE devcamp_sql_project_schema;

-- The average grade that is given by each professor

SELECT p.professors_name Professor,
CASE
	WHEN (ROUND(AVG(g.grades_grade_id)) = 1) THEN 'O'
    WHEN (ROUND(AVG(g.grades_grade_id)) = 2) THEN 'E'
    WHEN (ROUND(AVG(g.grades_grade_id)) = 3) THEN 'A'
    WHEN (ROUND(AVG(g.grades_grade_id)) = 4) THEN 'P'
    WHEN (ROUND(AVG(g.grades_grade_id)) = 5) THEN 'D'
    WHEN (ROUND(AVG(g.grades_grade_id)) = 6) THEN 'T'
END Grade
FROM grades g
JOIN courses c
ON c.courses_id = g.grades_courses_id
JOIN grades_scale gs
ON g.grades_grade_id = gs.grades_scale_id
JOIN professors p
ON p.professors_id = c.courses_professors_id
GROUP BY p.professors_name;

-- The top grades for each student
SELECT s.students_name, 
CASE
	WHEN(MIN(g.grades_grade_id) = 1) THEN 'O'
    WHEN(MIN(g.grades_grade_id) = 2) THEN 'E'
    WHEN(MIN(g.grades_grade_id) = 3) THEN 'A'
    WHEN(MIN(g.grades_grade_id) = 4) THEN 'P'
    WHEN(MIN(g.grades_grade_id) = 5) THEN 'D'
    WHEN(MIN(g.grades_grade_id) = 6) THEN 'T'
END Grade
FROM grades g
JOIN students s
ON g.grades_students_id = s.students_id
GROUP BY s.students_name;

-- Group students by the courses that they are enrolled in
SELECT s.students_name, c.courses_name
FROM grades g
JOIN courses c
ON g.grades_courses_id = c.courses_id
JOIN students s
ON s.students_id = g.grades_students_id
ORDER BY s.students_name;

-- Create a summary report of courses and their average grades, sorted by the most challenging course (course with the lowest average grade) to the easiest course
SELECT c.courses_name Course,
CASE
	WHEN(ROUND(g.grades_grade_id) = 1) THEN 'O'
    WHEN(ROUND(g.grades_grade_id) = 2) THEN 'E'
    WHEN(ROUND(g.grades_grade_id) = 3) THEN 'A'
    WHEN(ROUND(g.grades_grade_id) = 4) THEN 'P'
    WHEN(ROUND(g.grades_grade_id) = 5) THEN 'D'
    WHEN(ROUND(g.grades_grade_id) = 6) THEN 'T'
END Grade
FROM grades g
JOIN courses c
ON c.courses_id = g.grades_courses_id
GROUP BY c.courses_name
ORDER BY g.grades_grade_id DESC;

-- Finding which student and professor have the most courses in common
-- Not sure of what your trying to ask here I have it set up to were each professor only has one course so this isnt going to work.