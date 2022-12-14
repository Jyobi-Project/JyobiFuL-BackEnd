CREATE DATABASE jyobiful;

USE jyobiful;

CREATE TABLE users(
  user_id INT PRIMARY KEY AUTO_INCREMENT,
  user_name VARCHAR(32) NOT NULL,
  user_mail VARCHAR(64) UNIQUE NOT NULL,
  user_password VARCHAR(64) NOT NULL,
  salt VARCHAR(16) NOT NULL,
  user_icon VARCHAR(128) NOT NULL
);

CREATE TABLE languages(
  language_id INT PRIMARY KEY AUTO_INCREMENT,
  language_name VARCHAR(32) NOT NULL
);

CREATE TABLE questions(
  question_id INT PRIMARY KEY AUTO_INCREMENT,
  question_user_id INT NOT NULL,
  question_title VARCHAR(64) NOT NULL,
  question_detail TEXT NOT NULL,
  input_value TEXT DEFAULT NULL,
  output_value TEXT NOT NULL,
  question_lang INT NOT NULL,
  example_answer TEXT DEFAULT NULL,
  question_view int DEFAULT 0 NOT NULL,
  create_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  update_at DATETIME DEFAULT NULL,
  FOREIGN KEY (question_user_id) REFERENCES users(user_id) ON DELETE CASCADE,
  FOREIGN KEY (question_lang) REFERENCES languages(language_id) ON DELETE CASCADE
);

CREATE TABLE question_comments(
  comment_id INT PRIMARY KEY AUTO_INCREMENT,
  question_id INT NOT NULL,
  user_id INT NOT NULL,
  comment VARCHAR(140) NOT NULL,
  create_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  update_at DATETIME DEFAULT NULL,
  FOREIGN KEY (question_id) REFERENCES questions(question_id) ON DELETE CASCADE,
  FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE
);

CREATE TABLE questions_bookmarks(
  question_id INT NOT NULL,
  user_id INT NOT NULL,
  create_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (question_id) REFERENCES questions(question_id) ON DELETE CASCADE,
  FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE,
  PRIMARY KEY (question_id, user_id)
);

CREATE TABLE question_answers(
  question_id INT NOT NULL,
  user_id INT NOT NULL,
  question_answer TEXT NOT NULL,
  create_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  update_at DATETIME DEFAULT NULL,
  FOREIGN KEY (question_id) REFERENCES questions(question_id) ON DELETE CASCADE,
  FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE,
  PRIMARY KEY (question_id, user_id)
);

-- ????????????????????????
CREATE
    USER 'select_user'@'localhost' IDENTIFIED BY 'T4tZhGDVY-GRUfDtUgF6';
GRANT
    SELECT
        ON jyobiful.* TO 'select_user'@'localhost';

-- ???????????????????????????
CREATE
    USER 'insert_user'@'localhost' IDENTIFIED BY 'wBKFXWa8JSQDXGr-GDwG';
GRANT INSERT ON jyobiful.* TO
    'insert_user'@'localhost';

-- ??????????????????????????????
CREATE
    USER 'update_user'@'localhost' IDENTIFIED BY 'CkmXM9F_hpSSKMDafFzt';
GRANT
    SELECT,
        UPDATE
        ON jyobiful.* TO 'update_select_user'@'localhost';

-- ????????????????????????
CREATE
    USER 'delete_user'@'localhost' IDENTIFIED BY 'tnXuf65XMdz8miWDiH-V';
GRANT
    SELECT,
        DELETE
        ON jyobiful.* TO 'delete_user'@'localhost';

-- ???????????????execute??????
CREATE
    USER 'select_execute_user'@'localhost' IDENTIFIED BY 'nfkajf-FSafjk';
GRANT
    SELECT,
        execute
        ON jyobiful.* TO 'select_execute_user'@'localhost';

-- execute??????
CREATE
    USER 'execute_user'@'localhost' IDENTIFIED BY 'hZiYkKHmBfy-UkMBfpf7';
GRANT EXECUTE ON jyobiful.* TO
    'execute_user'@'localhost';
