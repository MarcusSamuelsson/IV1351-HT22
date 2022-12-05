CREATE VIEW lesson_per_month AS
    SELECT count(EXTRACT(month FROM time)) as month, 
    count(lesson_type) FILTER (WHERE lesson_type = 'induvidual') as induvidual_lesson, 
    count(lesson_type) FILTER (WHERE lesson_type = 'group') as group_lesson, 
    count(lesson_type) FILTER (WHERE lesson_type = 'ensemble') as ensemble 
    FROM lesson WHERE EXTRACT(year FROM time) = '2021' GROUP BY EXTRACT(MONTH FROM time) ORDER BY EXTRACT(MONTH FROM time) ASC;

CREATE VIEW student_nr_of_siblings
    SELECT nr_of_siblings, count(1) as students_with_nr_of_siblings 
    FROM (SELECT count(sibling.student_id) 
        FROM student LEFT JOIN sibling ON student.student_id = sibling.student_id  
        GROUP BY student.student_id) as nr_of_siblings 
    GROUP BY nr_of_siblings ORDER BY nr_of_siblings ASC;

CREATE VIEW instructor_holding_lessons
    SELECT lesson.instructor_id, count(lesson.instructor_id) 
    FROM lesson LEFT JOIN instructor ON instructor.instructor_id = lesson.instructor_id 
    WHERE EXTRACT(month FROM time) = EXTRACT(month FROM now()) AND EXTRACT(year FROM time) = EXTRACT(year FROM now()) 
    GROUP BY lesson.instructor_id HAVING count(lesson.instructor_id) > 1;
    

CREATE MATERIALIZED VIEW upcoming_ensembles AS
    SELECT lesson_type, genre, time, 
    CASE 
        WHEN nr_of_students::INTEGER = minimum_nr_of_students::INTEGER THEN 'full' 
        WHEN nr_of_students::INTEGER = minimum_nr_of_students::INTEGER - 1 THEN 'One seat left' 
        WHEN nr_of_students::INTEGER = minimum_nr_of_students::INTEGER - 2 THEN 'Two seats left' 
        ELSE 'More than two seats left' 
    END as seats_left 
    FROM lesson WHERE EXTRACT(week FROM time) = EXTRACT(week FROM now()) + 1 AND EXTRACT(year FROM time) = EXTRACT(year FROM now()) AND lesson_type = 'ensemble' ORDER BY genre, EXTRACT(day FROM time);