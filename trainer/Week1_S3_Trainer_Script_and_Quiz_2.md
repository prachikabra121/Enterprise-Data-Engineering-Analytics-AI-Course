# 📘 TRAINER SCRIPT & QUIZ PACK
## Week 1, Session 3 — SQL & Data Engineering Concepts
### Data Types · Modern Storage Systems · The Data Engineer's Role
**Duration:** 1 Hour  |  Foundation Phase  |  Trainer: [Your Name]

---

## ⏱ SESSION TIMING MAP

| Time        | Activity                                                     | Slide |
|-------------|--------------------------------------------------------------|-------|
| 0:00 – 0:04 | Welcome & session promise                                    | 1–2   |
| 0:04 – 0:10 | Why data types matter — the consequences hook                | 3     |
| 0:10 – 0:22 | SQL data types — full map + table design in action           | 4–5   |
| 0:22 – 0:36 | Modern storage systems — Database, Warehouse, Lake, Lakehouse | 6     |
| 0:36 – 0:42 | Datamart — the focused layer                                 | 7     |
| 0:42 – 0:46 | ⚡ MID-SESSION QUIZ                                          | 9     |
| 0:46 – 0:50 | Which system — when? Comparison table                        | 8     |
| 0:50 – 0:55 | Where the data engineer lives + real-world scenarios         | 10–11 |
| 0:55 – 0:58 | Session summary                                              | 12    |
| 0:58 – 1:00 | Q&A and close                                                | 13    |

---

## 🎤 SLIDE-BY-SLIDE TRAINER SCRIPT

---

### SLIDE 1 — Title *(0:00 – 0:02)*

> **[Let the slide land. The SQL code on the right panel is intentional — say this:]**

"Welcome to Session 3. By the end of this hour, you'll understand what that code on the right actually means — why those words, why those types, why those constraints. And why getting it wrong costs companies millions.

Today we're going hands-on with two things that underpin everything else in this programme: SQL data types and modern storage systems."

> **[Advance to Slide 2]**

---

### SLIDE 2 — Objectives *(0:02 – 0:04)*

"Five things by the end of this session. Read them quickly.

Notice the fifth one — 'connect to the bigger picture.' I'll be telling you throughout this session exactly where each concept reappears in Weeks 2 through 16. Nothing today is standalone."

> **[Don't read all five — learners can read. Just point to the fifth one and land the preview comment, then move.]**

> **[Advance to Slide 3]**

---

### SLIDE 3 — Why Data Types Matter *(0:04 – 0:10)*

> **[This is your hook — read each scenario with energy. Pause after each.]**

"Before I show you a single data type, I want to show you what happens when you pick the wrong one.

**First scenario — a bank stores loan amounts as TEXT.**
Not DECIMAL. Not INT. TEXT. Why? Maybe someone was in a hurry. Maybe they copied the wrong column definition.

Now the system tries to calculate the total loan book. It adds '50000' + '50000'. In text concatenation, that's '5000050000'. The report shows ₹500 crore more than reality. That report reaches the board. Decisions are made.

**Second scenario — a hospital stores patient admission dates as VARCHAR.**
It works fine for storing dates. But the moment someone runs 'sort by admission date' — '9th January' comes after '10th January' alphabetically. The queue is wrong. Triage decisions are made in the wrong order.

**Third scenario — a login system has no length constraint on a VARCHAR password field.**
A malicious user submits a 2MB password string. The auth service tries to hash it. The server chokes. The site goes down.

These are not hypothetical stories. These are patterns that appear in real post-mortems.

The right data type enforces correctness at the storage level — before any application code runs. Your first design decision as a data engineer is always: what type does this column need?"

> **[Advance to Slide 4]**

---

### SLIDE 4 — SQL Data Types *(0:10 – 0:18)*

"Now let's learn the types. I've grouped them into four families. Let me walk through each.

**Numeric types:**
- `INT` and `BIGINT` — for whole numbers. Order IDs, employee counts, ratings. If it will never have a decimal, use INT.
- `DECIMAL(p,s)` — precision and scale. DECIMAL(10,2) means 10 total digits, 2 after the decimal. This is your money type. Always. Every price, every salary, every financial figure.
- `FLOAT` and `REAL` — approximate decimals. Used in science. Never for money — we'll come back to this in the quiz.
- `SMALLINT` and `TINYINT` — same idea as INT but uses less storage. Use for ratings, flags, status codes.

**Text types:**
- `VARCHAR(n)` — variable length. If you say VARCHAR(100) and store 'Ravi', it only uses 4 characters of storage. Most common text type.
- `CHAR(n)` — fixed length. If you say CHAR(2) and store 'IN', it's always 2 characters. Used for country codes, gender codes, fixed identifiers.
- `NVARCHAR(n)` — the N stands for Unicode. Use this when your data may contain Hindi, Arabic, Chinese, or emoji. Always for customer names in India.
- `TEXT` — for long content. Product descriptions, comments. Don't use for short, indexed fields.

**Date and time:**
- `DATE` — date only. Date of birth, order date. No time component.
- `DATETIME` — date and time together. Transaction timestamp, login time.
- `TIMESTAMP` — similar to DATETIME, often set automatically by the database when a record is created or updated.
- `TIME` — time only, no date. Shift start, meeting time.

**The essentials:**
- `BIT` or `BOOLEAN` — true or false. IsActive, IsDeleted, IsVerified.
- `JSON` — stores semi-structured data directly in a column. API payloads, configuration objects.
- `UNIQUEIDENTIFIER` — UUID or GUID. Used when IDs need to be globally unique across multiple systems or databases.
- `BINARY` / `BLOB` — raw bytes. Images, PDFs, encrypted content.

**[Quick check — show of hands]:**
'If I'm storing a customer's profile picture in a database column, which type do I use?'
*(Answer: BLOB / BINARY — or better, store the file path as VARCHAR and the file itself in Blob Storage)*"

> **[Advance to Slide 5]**

---

### SLIDE 5 — Data Types in Action *(0:18 – 0:22)*

"Let's put this into practice. Look at the CREATE TABLE statement on the left — a real Customers table.

Notice every choice is deliberate:
- `CustomerID INT` — IDs are whole numbers. No decimals. INT.
- `FullName NVARCHAR(150)` — Unicode because Indian names can contain regional characters.
- `Email VARCHAR(255)` — 255 is the de facto standard email max length.
- `PhoneNumber VARCHAR(15)` — phone numbers look like numbers but they're not. You never add or multiply phone numbers. You never want leading zeros stripped. VARCHAR.
- `DateOfBirth DATE` — date only, no time needed.
- `CreditLimit DECIMAL(12,2)` — financial value, exact precision required.
- `IsActive BIT` — only two states possible. 1 bit of storage.
- `CreatedAt DATETIME DEFAULT GETDATE()` — the database fills this automatically when the record is inserted.

**[Ask the room — 60 seconds]:**
'What would break if PhoneNumber was stored as INT?'

*Expected answers: Leading zeros disappear — +91 numbers lose the 0. You can't store +91. Arithmetic becomes possible — someone accidentally multiplies two phone numbers. Formatting breaks.*

All of that breaks silently — the INSERT might still succeed. The damage shows up later, when data is wrong but no error was raised.

That's the danger of wrong data types."

> **[Advance to Slide 6]**

---

### SLIDE 6 — The Modern Data Storage Stack *(0:22 – 0:36)*

> **[This is the centrepiece of the session — spend the most time here]**

"SQL data types tell us how to store individual values. Now — where does all this data actually live at scale?

There are four systems in the modern data stack. Every enterprise you will ever work for uses some combination of all four.

**Database — OLTP: Online Transaction Processing.**
This is your relational database. SQL Server, MySQL, PostgreSQL. It is built for speed on individual reads and writes. When a customer buys something, that transaction is written to a database. When they log in, their credentials are checked from a database. It is the beating heart of any live application.

But here's the limitation: databases are optimised for fast individual writes. They are NOT designed for analytical queries across millions of rows. Try running 'what was our total revenue by product category across 3 years' on a live transactional database — it will lock tables, slow down the app, and probably time out.

This is why the Warehouse exists.

**Data Warehouse — OLAP: Online Analytical Processing.**
The Warehouse is built for analytical queries. Snowflake, Azure Synapse, BigQuery. It holds historical, structured, cleaned data — and it is optimised to aggregate millions of rows quickly. When a CFO asks for last quarter's revenue breakdown — that comes from the Warehouse, not the database.

The Warehouse doesn't handle fast writes. It handles fast reads at scale.

**Data Lake — Raw Storage.**
A Data Lake stores everything. Structured, semi-structured, unstructured. JSON files, CSV dumps, images, CCTV footage, IoT sensor data, server logs. Azure ADLS, AWS S3.

The key property: very low cost, enormous scale. A company can store petabytes here for almost nothing compared to a Warehouse.

The limitation: it is not designed for fast queries. You don't run dashboards off a Data Lake. You land data here first — then process it.

You may remember from Session 2 that we talked about Medallion Architecture — Bronze, Silver, Gold. The Data Lake is where those layers live.

**Lakehouse — The Best of Both.**
The Lakehouse is a newer architecture that combines the scale of a Data Lake with the performance of a Warehouse. Databricks Delta Lake, Microsoft Fabric, Apache Iceberg. It supports both SQL queries and Python/Spark workloads. It is ACID compliant. You can run streaming and batch in one platform.

This is where we are going in Week 12 and 13 — we will build a real Lakehouse on Databricks.

**[Discussion question — 90 seconds]:**
'If you had to store every UPI transaction in India — roughly 10 billion per day — which system do you start with, and what's the problem with using just one?'

*Expected answer: Database for the live writes — each transaction needs to succeed or fail atomically. But a database can't hold 10 billion rows and be fast. So you need the Warehouse for historical analysis. And a Data Lake to archive the raw transaction logs at low cost.*

That's why mature enterprises use all four — not one."

> **[Advance to Slide 7]**

---

### SLIDE 7 — Datamart *(0:36 – 0:42)*

"One more system — the Datamart. And the best way to understand it is with this analogy on the slide.

A Data Warehouse is a supermarket — it has everything. A Datamart is the dairy aisle. Same building. Same stock. But curated, organised and accessible for one specific purpose.

Look at the four examples:
- **Sales Datamart** — revenue, pipeline, conversions, top customers. Only sales data.
- **Finance Datamart** — P&L, cost centres, budget vs actual. Only finance data.
- **HR Datamart** — headcount, attrition, hiring velocity. Only HR data.
- **Marketing Datamart** — campaign ROI, click-through, segments. Only marketing data.

Why not just let everyone query the Warehouse directly?

Three reasons: **performance** — the Warehouse is big, shared queries slow it down; **governance** — you don't want Finance seeing HR salary data; **simplicity** — a business analyst shouldn't need to understand a 500-table Warehouse schema to get their weekly report.

A Datamart is the data team's gift to the business — pre-modelled, governed, fast and focused.

**[Quick pair activity — 60 seconds]:**
'If you were building a Datamart for a hospital's Operations team, name three metrics you'd include and three you'd deliberately leave out.'

*Leave out: anything clinical (patient diagnosis), anything HR (staff salaries), anything Finance (hospital revenue). Include: bed occupancy rate, average patient wait time, discharge rate, staff-to-patient ratio.*"

> **[Advance to Slide 9 — Quiz. Skip Slide 8 for now — you'll return to it after the quiz.]**

---

### SLIDE 9 — MID-SESSION QUIZ *(0:42 – 0:46)*

> **[Energise the room — stand up, use a timer if you have one]**

"Quiz time. Three questions. Four minutes. Individual answers — no talking yet.

**Q1:** A column stores product prices like ₹1,499.99. Which SQL data type should you use — and specifically, why should you NOT use FLOAT?

**Q2:** Your company runs 10 million daily sales transactions AND needs monthly revenue reports for the board. Name the two storage systems you need and explain why you need both.

**Q3:** What is a Datamart, and how is it different from a Data Warehouse?

Go — four minutes."

> **[Walk the room. After 4 minutes:]**

"Let's go through them.

**Q1:** `DECIMAL` — specifically DECIMAL(10,2) or similar. NOT FLOAT because FLOAT is an approximation. Floating point arithmetic can produce results like 1499.9999999999998 instead of 1500.00. For financial data that rounds up or down silently, you get wrong totals. Courts, auditors and customers do not accept 'it's an approximation.'

**Q2:** You need a **Database** (SQL Server/MySQL) for the live transactions — each one needs to write in real time, succeed or fail atomically. You need a **Data Warehouse** (Snowflake/Synapse) for the monthly reports — analytical queries across 300 million rows are too slow and too costly on the transactional database. Different jobs, different tools.

**Q3:** A Datamart is a subject-focused subset of a Warehouse. The Warehouse holds all company data. A Datamart holds one department's data — pre-modelled, governed and fast. Finance sees Finance. HR sees HR. Neither sees the other."

> **[Advance to Slide 8]**

---

### SLIDE 8 — Comparison Table *(0:46 – 0:50)*

"Now that you've answered those questions, let's codify it all in one view.

This table — six dimensions, five systems. I want you to memorise three rows in particular:

**Query Speed:** Database is fastest for individual queries. Data Lake is slowest for analytics. Lakehouse closes the gap.

**Who uses it:** This tells you who you're building for. When you build a Datamart — you're building for a business user who should never need to write SQL. When you build a Data Lake — you're building for other data engineers and scientists.

**Data State:** This is subtle but critical. A database holds live, current data. A Warehouse holds historical, processed data. A Data Lake holds raw, unprocessed data. A Datamart holds a curated subset.

**[Forward reference:]**
Note the last row — Example tool. SQL Server is where we go in Week 4. Snowflake and Synapse are what Week 2 models are designed for. Databricks is Week 12–13. Power BI dataset — that's Week 3.

Everything in this table has a week in this programme."

> **[Advance to Slide 10]**

---

### SLIDE 10 — Where the Data Engineer Lives *(0:50 – 0:53)*

"Now let's place you in this picture.

Look at the six nodes in this pipeline. Source systems on the left — ERP, CRM, APIs, IoT sensors. Consumers on the right — analysts, executives, applications.

Everything in the middle is built by engineers. But specifically:

- **Ingestion Layer** — you build this. Pipelines that extract data from source systems and land it in the lake. We do this in Week 13.
- **Storage Layer** — you design this. The lake structure, the warehouse schema, the datamart model. Week 2 starts this. Week 12–13 builds it.
- **Transform & Model Layer** — you build this. SQL scripts, dbt models, Python transformations, Spark jobs. Weeks 5, 6, 7, 9, 10.

The Serve Layer and Consumer layer — BI tools, analysts, dashboards — those consume what you build. You make their work possible.

A data engineer is not a database administrator. A data engineer is not a data analyst. A data engineer is the person who builds the infrastructure that everyone else depends on.

What do you actually build day to day?

- Pipelines that move data from source to lake
- SQL scripts that transform raw data into clean tables
- Models that shape data for analysts to query
- Jobs that schedule and automate all of the above

That is your job description."

> **[Advance to Slide 11]**

---

### SLIDE 11 — Real World Scenarios *(0:53 – 0:55)*

"Four real scenarios. Cover the right column — and before I tell you the answer, try to match each one.

**Scenario 1 — bank, 5 million credit card transactions per day, each must succeed or fail atomically.**
Database. OLTP. ACID guarantees. No exceptions.

**Scenario 2 — manufacturing company, 3 years of production data, find machines with highest failure rates.**
Data Warehouse. OLAP. Historical aggregation. Complex query. Millions of rows.

**Scenario 3 — data science team needs to train a model on 10TB of raw CCTV footage, IoT logs and social media data.**
Data Lake. Unstructured at scale. Low cost. No schema enforced.

**Scenario 4 — CFO wants a self-service dashboard showing only Finance KPIs.**
Datamart. Subject-focused. Governed. Fast. The CFO should never see HR salary data in the same view.

The pattern is the same every time: understand the use case, understand who queries it, understand what speed and format is needed — then pick the system."

> **[Advance to Slide 12]**

---

### SLIDE 12 — Summary *(0:55 – 0:58)*

"Six takeaways — one for each card.

1 — Wrong data type = silent corruption. The database won't always tell you. It will just store the wrong thing.
2 — Know your types by family: Numeric, Text, Date/Time, Essentials. DECIMAL for money. NVARCHAR for multilingual text. BIT for flags.
3 — Database for live transactions. Warehouse for historical analytics. Not interchangeable.
4 — Data Lake for raw everything. Lakehouse for modern unified platforms.
5 — Datamart for department-specific, governed, fast reporting.
6 — You — as a data engineer — build the middle three layers of the stack.

Your homework before Week 2: think of one real table you'd create for any company you know. Name five columns and write the correct SQL data type for each. No SQL needed — just column names and types. We'll review a few at the start of Week 2."

> **[Advance to Slide 13]**

---

### SLIDE 13 — Q&A / Close *(0:58 – 1:00)*

"Any questions?

**[If quiet, use one of these prompts:]**
- 'We covered five storage systems today. Which one surprised you most — and why?'
- 'Based on what you heard today — which storage system does your current or previous company use? Which ones are they missing?'

See you in Week 2 — we go from storage systems to data modelling. Fact tables, dimension tables, star schemas, snowflake schemas. The architecture of how data is actually organised for analysis."

---
---

# ⚡ FULL QUIZ PACK — WEEK 1, SESSION 3

---

## PART A — MID-SESSION QUIZ (Slide 9 — at ~42 min mark)

### Q1. A column stores product prices like ₹1,499.99. Which data type — and why NOT FLOAT?
**Answer:** `DECIMAL(10,2)`. FLOAT is an approximation — it can produce rounding errors like 1499.9999999998 instead of 1500.00. Financial data requires exact precision. DECIMAL stores exact values.

### Q2. Your company runs 10 million daily transactions AND needs monthly revenue reports. Name the two storage systems and explain why you need both.
**Answer:** **Database** (SQL Server/MySQL) for live transactions — real-time writes, ACID compliance, millisecond response. **Data Warehouse** (Snowflake/Synapse) for monthly reports — built for analytical queries across millions of historical rows without impacting the live application.

### Q3. What is a Datamart and how is it different from a Data Warehouse?
**Answer:** A Datamart is a subject-focused subset of a Warehouse built for one department or use case. The Warehouse holds all company data. A Datamart holds one team's data — pre-modelled, governed and optimised for fast, self-service queries. A Finance Datamart contains only Finance data; HR cannot see it.

---

## PART B — EXTENDED QUIZ

---

### SECTION 1 — Multiple Choice (1 mark each)

**Q1.** A developer stores customer phone numbers as `INT`. What is the most critical problem this causes?
- A) Phone numbers take more storage as INT
- B) The database will reject phone numbers
- C) ✅ Leading zeros are stripped and formatting breaks (e.g., +91 prefix is lost)
- D) INT is slower than VARCHAR for lookups

---

**Q2.** Which SQL data type is most appropriate for storing the exchange rate between USD and INR (e.g., 83.4521)?
- A) INT
- B) VARCHAR(10)
- C) FLOAT
- D) ✅ DECIMAL(10,4)

---

**Q3.** OLAP stands for:
- A) Online Application Processing
- B) Offline Logical Analysis Platform
- C) ✅ Online Analytical Processing
- D) Operational Large-scale Analytics Pipeline

---

**Q4.** A Data Lake's primary design advantage over a Data Warehouse is:
- A) Faster query performance on structured data
- B) Built-in data governance and access control
- C) ✅ Ability to store any data format at very low cost and massive scale
- D) Native support for relational schemas

---

**Q5.** Which storage system would a data scientist use to train a machine learning model on raw, unprocessed web clickstream logs?
- A) Relational Database
- B) Datamart
- C) Data Warehouse
- D) ✅ Data Lake

---

**Q6.** A Lakehouse differs from a Data Warehouse primarily because it:
- A) Stores only structured data
- B) Is always slower than a Warehouse
- C) ✅ Combines the scale of a Data Lake with Warehouse-level query performance
- D) Cannot run SQL queries

---

**Q7.** The `NVARCHAR` data type is preferred over `VARCHAR` when:
- A) The column will store numbers
- B) Storage space must be minimised
- C) ✅ The data may contain Unicode characters (Hindi, Arabic, emoji, etc.)
- D) The column requires a fixed length

---

**Q8.** A Data Engineer's primary responsibility in the modern data stack is:
- A) Writing business reports for executives
- B) Training machine learning models
- C) Designing customer-facing application UI
- D) ✅ Building pipelines, transformations and storage infrastructure that others depend on

---

### SECTION 2 — True or False (1 mark each)

**Q9.** A relational database is the best choice for running historical analytical queries across 3 years of transaction data.
**Answer:** ❌ FALSE — A Data Warehouse is designed for this. Analytical queries across millions of rows on a live transactional database will slow or crash the application.

**Q10.** DECIMAL(10,2) can store the value 1,234,567.89 correctly.
**Answer:** ✅ TRUE — 10 total digits, 2 after decimal = up to 99,999,999.99. 1,234,567.89 has 9 total digits and fits.

**Q11.** A Datamart can exist independently without a Data Warehouse.
**Answer:** ✅ TRUE — but in practice, most Datamarts are sourced from a Warehouse. Standalone Datamarts are possible but harder to govern.

**Q12.** FLOAT should always be used instead of DECIMAL for currency values because it is more precise.
**Answer:** ❌ FALSE — FLOAT is an approximation. DECIMAL provides exact precision. FLOAT should never be used for currency.

**Q13.** The `CreatedAt DATETIME DEFAULT GETDATE()` constraint means the programmer must manually set the date when inserting records.
**Answer:** ❌ FALSE — `DEFAULT GETDATE()` means the database automatically populates the timestamp with the current date and time. No manual entry required.

---

### SECTION 3 — Scenario Short Answer (2–3 marks each)

**Q14.** Design a simple `Products` table for an e-commerce company. Name 6 columns and specify the correct SQL data type for each, with a brief justification.

**Model Answer:**
```sql
CREATE TABLE Products (
  ProductID       INT              -- Whole number, auto-increment primary key
  ProductName     NVARCHAR(200)    -- Unicode for multilingual product names
  Price           DECIMAL(10,2)    -- Exact financial value, 2 decimal places
  StockQuantity   INT              -- Whole number, never fractional
  IsAvailable     BIT              -- Boolean flag: available or not
  CreatedAt       DATETIME         -- Timestamp of record creation
)
```

---

**Q15.** A retail company has three requirements: (a) process online orders in real time, (b) run a quarterly sales report across 2 years of data, (c) store all raw web server logs for future ML use. Which three storage systems do they need and why?

**Model Answer:**
- (a) **Relational Database** — real-time order writes require OLTP with ACID guarantees
- (b) **Data Warehouse** — quarterly report is an analytical query across historical, structured data at scale
- (c) **Data Lake** — web logs are unstructured/semi-structured and massive in volume; low-cost raw storage before any schema is enforced

---

**Q16.** Explain why a company would create a separate Finance Datamart from their central Data Warehouse, rather than letting Finance analysts query the Warehouse directly.

**Model Answer (any 3 of these points):**
- **Performance:** Shared Warehouse queries from many teams slow each other down; a Datamart is optimised for Finance queries only
- **Governance:** Finance analysts should not see HR salary bands, customer PII, or operations data that exists in the Warehouse
- **Simplicity:** A Warehouse may have 500+ tables; a Finance Datamart has 20–30 tables that Finance analysts actually need
- **Stability:** Warehouse schema can change with new data sources; a Datamart provides a stable, curated view
- **Self-service:** Finance users can query the Datamart without understanding the full Warehouse model

---

### SECTION 4 — Rapid Fire (Verbal — no writing needed)

Read these out. Learners shout the answer.

| Question | Answer |
|----------|--------|
| Data type for employee salary? | `DECIMAL` |
| Data type for IsDeleted flag? | `BIT` |
| Data type for country code 'IN'? | `CHAR(2)` |
| OLTP stands for? | Online Transaction Processing |
| Which system stores raw IoT data cheaply? | Data Lake |
| Which system do BI dashboards query? | Data Warehouse or Datamart |
| Databricks Delta Lake is an example of? | Lakehouse |
| Data type for a product description (long text)? | `TEXT` or `NVARCHAR(MAX)` |
| Which system is ACID compliant for transactions? | Relational Database |
| What does the 2 in DECIMAL(10,2) mean? | 2 digits after the decimal point |

---

## 🎮 INTERACTIVE ACTIVITY IDEAS

### 1. "Type the Column" (Pairs — 5 minutes)
Give each pair a printed card with a fictional company (hospital, airline, supermarket, bank). They must design a 6-column table for that company with correct types. Share back — trainer corrects and explains any wrong choices.

### 2. "Which System?" Card Game (Groups of 3 — 5 minutes)
Print 8 scenario cards. Each group has 5 coloured cards: DB, DW, Lake, Lakehouse, Datamart. Trainer reads a scenario — first group to hold up the right card wins the point. Fast, energetic, no preparation needed.

### 3. "Break the Table" (Whole group — 3 minutes)
Trainer shows a deliberately badly designed table on the whiteboard:
```
CustomerID: VARCHAR
PhoneNumber: INT  
DOB: FLOAT
Salary: TEXT
IsActive: VARCHAR(3) storing 'yes'/'no'
```
Class races to find all five errors and name the correct type. First to get all five wins.

### 4. "Stack Map" (Solo — 3 minutes then share)
Each learner draws the data stack for their current or previous company — which of the five systems does it use? Which is missing? What would they add? Share with a partner. Trainer facilitates a 2-minute whole-group debrief.

### 5. Kahoot (End of session — 5 minutes)
Run Q1–Q8 from Section 1 as a live Kahoot. The rapid-fire format after 55 minutes of content helps consolidate memory through active recall.

---

## 💡 TRAINER TIPS FOR THIS SESSION

1. **The PhoneNumber as INT question (Slide 5)** almost always generates the most discussion. Give it a full 90 seconds — learners often don't immediately think of leading zeros, then when someone says it, others have an 'aha' moment.

2. **On Slide 6**, if learners ask "why not just use a Lakehouse for everything?" — say: "Lakehouse is newer. Most enterprises already have Databases and Warehouses in production. Lakehouse doesn't replace — it extends." Then move on.

3. **FLOAT vs DECIMAL** is the single most commonly tested concept in data engineering interviews. Mention this explicitly — learners are motivated when they know something will come up in a job interview.

4. **The comparison table (Slide 8)** works better after the quiz than before it. Learners have already reasoned through the answers — the table confirms and codifies. Don't front-load it.

5. **Connect to the programme map at every opportunity.** Every time you say "Warehouse", follow it with "Week 2 and 3." Every time you say "Databricks", follow it with "Week 12–13." Learners' anxiety drops significantly when they can see where each unfamiliar concept will be addressed in full.

6. **Homework is low stakes but high value.** The table design task takes 10 minutes and primes learners for Week 2's data modelling session. Ask for 3–4 volunteers to share at the start of Week 2, S1 — it creates continuity and rewards effort.

---

*End of Trainer Script & Quiz Pack — Week 1, Session 3*
