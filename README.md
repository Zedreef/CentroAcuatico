# Centro Acuático
La idea es realizar un sistema de gestión para una escuela de natación, que permita el registro de los alumnos, sus horarios de clase, pagos de clases y nivel del alumno. El sistema se encargará de facilitar el proceso de inscripción y seguimiento de los alumnos, así como de brindar información relevante a los administradores de la escuela.

## Características que debe tener el sistema
- **Registro de Alumnos**: El sistema debe permitir ingresar los siguientes datos de los alumnos
	- Nombre, apellido Paterno, Apellido Materno, Teléfono, Correo, Fecha Nacimiento, Contacto de emergencia con nombre, teléfono y parentesco. Dirección completa con calle, numero y Código Postal
	- Control de los papeles que se tiene de los alumnos al ingresar al centro acuático, Fotografías, certificado medico, copia INE, Electrocardiograma (Si aplica adulto mayor), Copia de credencial de la escuela (Si aplica beca), copia de la credencial de trabajadores (si aplica beca)
- **Horario de clase**: Los alumnos pueden seleccionar el horario de clase que mas le convenga, dentro de los horarios establecidos, cada clase tiene una duración de 1 hora. Es decir, que cada hora se va haciendo el cambio de clase. El alumno puede nadar dos horas seguidas, los horarios disponibles para tomar clases se describen a continuación
	- Matutino:
		- Lunes a viernes
			- 7:00 a.m. a 8:00 a.m.
			- 8:00 a.m. a 9:00 a.m.
			- 9:00 a.m. a 10:00 a.m.
		- Lunes, Miércoles y Viernes
			- 10:00 a.m. a 11:00 a.m.
		- Lunes y Miércoles
			- 11:00 a.m. a 12:00 a.m.
	- Vespertino:
		- Martes, Jueves y Viernes
			- 3:00 p.m. a 4:00 p.m.
		- Lunes a Viernes
			- 4:00 p.m. a 5:00 p.m.
			- 5:00 p.m. a 6:00 p.m.
			- 6:00 p.m. a 7:00 p.m.
		- Lunes a Jueves
			- 7:00 p.m. a 8:00 p.m.
	- Fines de semana:
		- Sábado y Domingo
			- 7:00 a.m. a 8:00 a.m.
			- 8:00 a.m. a 9:00 a.m.
			- 9:00 a.m. a 10:00 a.m.
			- 10:00 a.m. a 11:00 a.m.
		- Sábado (Exclusivo menores de 10 años)
			- 11:00 a.m. a 12:00 a.m.
- **Pagos:** Al momento de ingresar a la escuela, se realizará un pago por las clases que tomará durante el mes y el pago anual correspondiente. Posteriormente, se realizará únicamente el pago mensual hasta completar un año. Cada registro de pago incluirá el año en el que se realizó el pago y el número de recibo correspondiente.
- **Becas:** La escuela ofrece diferentes becas. El sistema distinguirá entre alumnos con beca y alumnos regulares (sin beca), permitiendo el registro de esta información para cada alumno. Las becas que se tomaran en cuenta, son las siguientes:
	- UNAM
	- UAM
	- IPN
	- DIF
	- ZARAGOZA
	- ESCUELAS PUBLICAS A NIVEL PRIMARIA, SECUNDARIA Y PREPARATORIA
	- UNIVERSIDAD PUBLICA
	- ADULTOS MAYORES INAPAM
- **Nivel de Natación:** El sistema llevará un registro del nivel de cada alumno. Los niveles disponibles son: Principiante A, Principiante B, Intermedio A, Intermedio B y Avanzado
	- Posteriormente vendrá un registro de cada alumno, donde se detalle la fecha en que se hizo la evaluación de cada nivel, para llevar un registro de cuanto dura un alumno en cada nivel. 

## Esquema de la base de datos DEER

![](https://github.com/Zedreef/CentroAcuatico/blob/master/Imagenes/DEER.png)