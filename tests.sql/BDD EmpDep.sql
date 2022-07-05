CREATE TABLE Employes (
    emp_id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    emp_matricule INT NOT NULL,
    emp_nom VARCHAR(50) NOT NULL,
    emp_prenom VARCHAR(50) NOT NULL,
    emp_dep CHAR(3) NOT NULL,
    emp_salaire DECIMAL(6,2)
);
INSERT INTO Employes (emp_matricule, emp_nom, emp_prenom, emp_dep, emp_salaire)
VALUES
(666, 'FER', 'Lucie', 42, 2130),
(42, 'MATIK', 'Otto', 50, Null)