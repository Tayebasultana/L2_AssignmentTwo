# PostgreSQL 
---

## PostgreSQL কী?

PostgreSQL হলো একটি শক্তিশালী, ওপেন সোর্স ডেটাবেজ সিস্টেম যা ডেটা সংরক্ষণ ও পরিচালনার জন্য ব্যবহার হয়। এটি অনেক বড় বড় কোম্পানি ও ওয়েবসাইটে ব্যবহৃত হয় কারণ এটি খুব বিশ্বাসযোগ্য এবং অনেক উন্নত ফিচার দেয়।

---

## ১. PostgreSQL কী?

PostgreSQL হলো ডেটাবেজ সফটওয়্যার যা আপনাকে বড় বড় ডেটা সহজে সংরক্ষণ করতে সাহায্য করে। এটি ডেটার মধ্যে সম্পর্ক তৈরি করে এবং দ্রুত তথ্য বের করতে পারে।

উদাহরণস্বরূপ, যদি আপনি কর্মচারীদের নাম, ডিপার্টমেন্ট ইত্যাদি সংরক্ষণ করতে চান, তাহলে আপনি একটা টেবিল তৈরি করবেন যেমন:
```sql
CREATE TABLE employees (
  id SERIAL PRIMARY KEY,
  name VARCHAR(100),
  department VARCHAR(50)
);
```
এখানে employees হলো টেবিলের নাম, আর id, name, department হলো কলাম।

---

## ২. PostgreSQL-এ Schema কী?

Schema হলো ডেটাবেজের ভিতরে একটা ফোল্ডারের মতো যা টেবিল, ভিউ ইত্যাদি বস্তুকে সংগঠিত করে। এটা বড় ডেটাবেজে কাজ সহজ করে এবং নামের দ্বন্দ্ব এড়ায়।

যেমন, আপনি sales নামে একটা স্কিমা বানাতে পারেন এবং তার ভিতরে sales.customers নামে টেবিল রাখতে পারেন।

---

## ৩. Primary Key এবং Foreign Key কী?

- **Primary Key** হলো টেবিলের এমন একটা কলাম যা প্রতিটা রেকর্ডকে আলাদা করে চিহ্নিত করে। এটি কখনো খালি (NULL) হতে পারে না।

উদাহরণ:
```sql
CREATE TABLE departments (
department_id SERIAL PRIMARY KEY,
name VARCHAR(50) NOT NULL
);
```

- **Foreign Key** হলো অন্য টেবিলের Primary Key এর রেফারেন্স, যা দুই টেবিলের মধ্যে সম্পর্ক তৈরি করে।

উদাহরণ:
```sql
CREATE TABLE employees (
employee_id SERIAL PRIMARY KEY,
name VARCHAR(100),
department_id INT,
FOREIGN KEY (department_id) REFERENCES departments(department_id)
);
```

এখানে employee টেবিলের department_id কলাম, departments টেবিলের department_id কে রেফার করছে।

---

## ৪. VARCHAR এবং CHAR এর মধ্যে পার্থক্য কী?

- **CHAR(n)** হলো স্থির দৈর্ঘ্যের স্ট্রিং। যদি কম অক্ষর থাকে, তাহলে স্পেস দিয়ে পূরণ করে নির্দিষ্ট দৈর্ঘ্য হয়।
- **VARCHAR(n)** হলো চলমান দৈর্ঘ্যের স্ট্রিং। যতটা লেখবেন, ততটাই জায়গা নেবে।

সাধারণত যেখানে ডেটার দৈর্ঘ্য সবসময় সমান (যেমন দেশ কোড) সেখানে CHAR, আর যেখানে দৈর্ঘ্য ভিন্ন (যেমন নাম) সেখানে VARCHAR ব্যবহার করা হয়।

---

## ৫. SELECT স্টেটমেন্টে WHERE ক্লজ কী কাজ করে?

WHERE ক্লজ দিয়ে আমরা ডেটা থেকে নির্দিষ্ট শর্তের উপর ভিত্তি করে তথ্য বের করতে পারি। যদি WHERE না থাকত, তাহলে সব রেকর্ড দেখাবে।

উদাহরণ:
```sql
SELECT * FROM employees WHERE department_id = 3;
```

এখানে শুধু department_id = 3 থাকা কর্মচারীর তথ্য দেখাবে।

---

## ৬. LIMIT এবং OFFSET কী?

- **LIMIT** দিয়ে আপনি দেখতে চান কতগুলো রেকর্ড পাবেন তা সীমাবদ্ধ করেন।
- **OFFSET** দিয়ে প্রথম কতগুলো রেকর্ড স্কিপ করবেন তা বলে দেন।

যা pagination বা পেজে পেজে ডেটা দেখানোর জন্য ব্যবহার হয়।

উদাহরণ:
```sql
SELECT * FROM employees LIMIT 10;
SELECT * FROM employees LIMIT 10 OFFSET 5;
```

---

## ৭. UPDATE স্টেটমেন্ট দিয়ে ডেটা কীভাবে পরিবর্তন করবেন?

UPDATE দিয়ে টেবিলের বিদ্যমান ডেটা পরিবর্তন করা হয়।

উদাহরণ:
```sql
UPDATE employees SET department_id = 2 WHERE employee_id = 5;
```

এখানে employee_id ৫ এর ডিপার্টমেন্ট ২ তে পরিবর্তিত হবে।

---

## ৮. JOIN কী এবং PostgreSQL-এ কীভাবে কাজ করে?

JOIN দুটি বা ততোধিক টেবিলকে তাদের সম্পর্কিত কলামের মাধ্যমে যোগ করে। এতে একসাথে বিভিন্ন টেবিল থেকে তথ্য নিতে পারি।

- **INNER JOIN** শুধু মিল থাকা রেকর্ড দেখায়।
- **LEFT JOIN** বাম পাশের টেবিলের সব রেকর্ড দেখায়, মিল না থাকলেও।

উদাহরণ:
```sql
SELECT e.name, d.name AS department
FROM employees e
INNER JOIN departments d ON e.department_id = d.department_id;
```

এখানে কর্মচারী ও তাদের ডিপার্টমেন্টের নাম দেখাবে।

---

## ৯. GROUP BY ক্লজ কী?

GROUP BY দিয়ে একই ধরনের ডেটা একসাথে গ্রুপ করা হয়, যাতে aggregate (গণনা) ফাংশন কাজ করতে পারে যেমন COUNT, SUM, AVG।

উদাহরণ:
```sql
SELECT department_id, COUNT(*) AS employee_count
FROM employees
GROUP BY department_id;
```

এখানে প্রতিটি ডিপার্টমেন্টে কতজন কর্মচারী আছে সেটা দেখাবে।

---

## ১০. COUNT(), SUM(), AVG() এর ব্যবহার কীভাবে করবেন?

এই ফাংশনগুলো দিয়ে আমরা ডেটার সংখ্যা, যোগফল, গড় বের করতে পারি।

উদাহরণ:
```sql
SELECT department_id,
COUNT(employee_id) AS total_employees,
SUM(salary) AS total_salary,
AVG(salary) AS average_salary
FROM employees
GROUP BY department_id;
```

---

## সারমর্ম

PostgreSQL ডেটা সংরক্ষণ, সম্পর্ক তৈরি, এবং ডেটা বিশ্লেষণে শক্তিশালী। Schema, Primary/Foreign Key, JOIN, GROUP BY ইত্যাদি বুঝলে ডেটাবেজ ডিজাইন এবং কোয়েরি লেখা অনেক সহজ হয়।

---





