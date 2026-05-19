# 📘 TRAINER SCRIPT & QUIZ PACK
## Week 2, Session 1 — Data Modelling Concepts
### Fact Tables · Dimension Tables · Star Schema · Snowflake Schema · Modelling Decisions
**Duration:** 1 Hour  |  **Format: VIRTUAL DELIVERY**  |  Foundation Phase

---

## 🖥️ VIRTUAL DELIVERY SETUP CHECKLIST
*(Do this 10 minutes before the session starts)*

- [ ] Share your screen — slides only, not full desktop
- [ ] Open Mentimeter or Slido (free) for live polls — have the join code ready
- [ ] Keep the Participant list visible so you can spot who hasn't responded
- [ ] Enable annotation tools in your platform (Zoom: View > Annotate; Teams: whiteboard)
- [ ] Have a draw.io tab open to sketch diagrams live if needed
- [ ] Post the homework reminder from last session in the chat before you begin
- [ ] Turn ON "waiting room" so late joiners don't interrupt
- [ ] Ask a co-trainer / TA to monitor the Chat if available

---

## ⏱ SESSION TIMING MAP

| Time        | Activity                                        | Slide | Virtual Tool         |
|-------------|------------------------------------------------|-------|----------------------|
| 0:00 – 0:04 | Welcome, last session link, homework review     | 1–2   | Chat box             |
| 0:04 – 0:10 | Hook — the report behind the report             | 3     | Chat poll            |
| 0:10 – 0:16 | What is data modelling? Raw vs modelled         | 4     | Screen annotation    |
| 0:16 – 0:25 | Fact table deep dive                            | 5     | Verbal poll          |
| 0:25 – 0:33 | Dimension tables deep dive                      | 6     | Chat activity        |
| 0:33 – 0:43 | Star Schema + Snowflake Schema                  | 7–8   | Annotation exercise  |
| 0:43 – 0:48 | ⚡ MID-SESSION QUIZ                             | 9     | Mentimeter / Chat    |
| 0:48 – 0:55 | Real life example + Modelling decisions         | 10–11 | Group discussion     |
| 0:55 – 0:58 | Summary                                         | 12    | Reflection prompt    |
| 0:58 – 1:00 | Q&A, homework, close                            | 13    | Raise hand / Chat    |

---

## 🎤 SLIDE-BY-SLIDE TRAINER SCRIPT

---

### SLIDE 1 — Title *(0:00 – 0:02)*

> **[VIRTUAL TIP: Start recording if your policy requires it. Welcome people as they join.]**

"Good [morning/afternoon] everyone — welcome to Week 2, Session 1. Can everyone confirm they can see my screen and hear me clearly? Drop a thumbs up in the chat.

> **[Wait 10 seconds for responses. If someone can't hear — fix it before proceeding. In virtual sessions, audio issues waste more time than in-person ones.]**

Today we're going from 'what data is' and 'where it lives' — which we covered last week — into something that will be your daily craft as a data modeller: **how to actually design the structure of data so it answers business questions.**

Let's go."

> **[Advance to Slide 2]**

---

### SLIDE 2 — Objectives *(0:02 – 0:04)*

"Five things by the end of this hour. The most important one is the fifth — making modelling decisions. Because every company already has data. Your value is knowing HOW to organise it.

Before I move on — I asked you last session to think about an app you use and sketch a Fact table with three dimensions. Drop what you came up with in the Chat right now — even one word is fine."

> **[VIRTUAL TIP: Read 2-3 chat responses aloud. E.g., 'Rahul says Swiggy — FactOrders with DimRestaurant, DimDate, DimCustomer. Perfect.' This rewards homework, builds community, and warms up the room.]**

> **[Advance to Slide 3]**

---

### SLIDE 3 — Opening Hook *(0:04 – 0:10)*

> **[VIRTUAL TIP: This is your energy slide. Sit up, speak louder. The virtual format drains energy — compensate.]**

"Look at these three questions on screen. Every single one of them has been asked by a real CFO, a real hospital administrator, a real e-commerce director.

**E-Commerce:** 'How did each product category perform this quarter, by region?'
**Banking:** 'What is the total loan amount disbursed per branch per month?'
**Healthcare:** 'How many patients per doctor per department were seen last week?'

Each of these questions sounds simple. But behind each one is a data model that someone designed — tables, relationships, keys. Without a proper model, that question either can't be answered at all, or takes a data analyst three days of manual SQL to approximate.

**[VIRTUAL ACTION — Chat box:]**
Type in the chat: which of these three questions sounds most like work you've done or work you'll be asked to do? Banking, Healthcare, or E-Commerce? Just type one word.

> **[Read answers aloud as they come in. Acknowledge: 'Most of you said Banking — great, let's use banking examples throughout today.']**

Your job as a data modeller is to design the structure that makes these questions answerable in 30 seconds by a Power BI dashboard — not 3 days by a SQL analyst."

> **[Advance to Slide 4]**

---

### SLIDE 4 — What Is Data Modelling? *(0:10 – 0:16)*

"Let me show you why modelling matters — not just define it.

Look at the left side — raw transaction data. Every order in one giant flat table. Product name, category, region, sales rep, date, amount, discount, tax, cost — all in one row. Every. Single. Row.

**[Annotation exercise — VIRTUAL TIP:]**
'I'm going to circle something on the left panel. Watch for it.'
> **[Use your screen annotation tool to circle 'iPhone 15 | Electronics | West | Rahul' — which appears in row 1 AND row 3.]**

'Who can see the problem? Drop it in the Chat.'

> **[Expected answer: duplication — same product data repeated for every transaction.]**

'Exactly. iPhone 15 is Electronics, West, Rahul — that appears on row 1 AND row 3. If Apple changes the category name from 'Electronics' to 'Consumer Tech', you have to update EVERY row in the entire table. That's a maintenance nightmare. It's slow. It's error-prone. And in a real business with millions of rows — it's impossible.

Now look at the right side — the modelled version. We've separated the data into clean, purposeful tables. FactSales holds just the numbers and keys. DimProduct holds just product information — once, centrally. DimDate holds date context. DimRegion holds location context.

If Apple's category changes — you update one row in DimProduct. Done. Every report that references it is immediately correct.

**That** is why data modelling is not optional. It is the foundation of every enterprise analytics system."

> **[Advance to Slide 5]**

---

### SLIDE 5 — Fact Table Deep Dive *(0:16 – 0:25)*

"Let's go deep on the first half of the model — the Fact table.

A Fact table records **business events**. Every row is one thing that happened: one sale, one login, one hospital appointment, one UPI transaction.

Four rules for Fact tables that you must internalise:

**Rule 1 — It records events.** Not descriptions. Not categories. Events. Something happened at a point in time.

**Rule 2 — It contains measurable metrics.** Things you can SUM, AVERAGE, COUNT, or MIN/MAX. Quantity sold. Revenue. Tax amount. Discount percentage. If you can't aggregate it mathematically — it probably doesn't belong in the Fact table.

**Rule 3 — It holds Foreign Keys — NOT descriptive text.** Look at the table on the right. DateKey, ProductKey, CustomerKey, RegionKey, SalesRepKey. These are just integer numbers pointing to dimension tables. The Fact table does NOT store the product name, the customer's city, the region's country. It stores a key that points to where that information lives. Why? Because storing 'iPhone 15 Pro — 512GB — Space Black — Electronics — Apple — Premium' in every sales row is wasteful and brittle. Storing '1042' (a ProductKey) is fast and clean.

**Rule 4 — It grows fast.** Your DimProduct might have 10,000 products. Your FactSales might have 500 million rows. Fact tables are the biggest tables in your system.

**[VIRTUAL POLL:]**
'Which column in FactSales would you use to calculate total revenue?' — Type your answer in the chat now.

> **[Answer: TotalAmount or Revenue column — it's a metric/measurable value. NOT ProductKey or CustomerKey — those are foreign keys used to join, not to aggregate.]**

Great. That instinct — 'which columns can I aggregate, which are just pointers' — is the foundation of reading any data model."

> **[Advance to Slide 6]**

---

### SLIDE 6 — Dimension Tables *(0:25 – 0:33)*

"Now the other half — Dimension tables. If Fact tables answer 'HOW MUCH happened', Dimension tables answer 'WHO, WHAT, WHERE and WHEN it happened.'

Look at the five dimension tables on screen. Each one answers a specific question that gives your Fact table context.

- **DimDate** — WHEN? Not just the date — but the day of week, month, quarter, year, and even 'IsWeekend'. You never just store a date in a dimension — you slice it every possible way a business might want to analyse it.
- **DimProduct** — WHAT? Product name, category, sub-category, brand. All descriptive. Nothing numeric that you'd SUM.
- **DimCustomer** — WHO? Name, city, customer segment, age group. Descriptive, stable, rarely changes.
- **DimRegion** — WHERE? Region, state, country, zone.
- **DimSalesRep** — BY WHOM? Rep name, team, manager, date joined.

Here's the rule that makes Fact vs Dimension simple:

**Tall and narrow = Fact. Small and wide = Dimension.**

Fact tables have millions of rows but a manageable number of columns — mostly keys and metrics. Dimension tables have a few hundred or thousand rows but many descriptive columns.

**[VIRTUAL CHAT ACTIVITY — 60 seconds:]**
'I'm going to give you a column name. Type FACT or DIM in the chat.'

Read these out one by one, let answers come in, then reveal:
1. 'SalesAmount' → FACT (metric you sum)
2. 'ProductCategory' → DIM (descriptive)
3. 'Quantity' → FACT (measurable)
4. 'CustomerCity' → DIM (descriptive)
5. 'DateKey' → FACT (it's a foreign key — it lives IN the Fact table, but POINTS to DimDate)

> **[Note on #5: This is a common confusion point. The Foreign Key lives in the Fact table but references the Dimension table. Clarify this carefully.]**"

> **[Advance to Slide 7]**

---

### SLIDE 7 — Star Schema *(0:33 – 0:40)*

"Now let's put Fact and Dimension together — that's where schemas come in.

Look at the diagram. One Fact table at the centre. Five Dimension tables pointing outward. Each dimension connects to the Fact via a Foreign Key. The shape it forms looks like a star — so we call it a **Star Schema**.

This is the most widely used analytical data model in enterprise BI. Power BI is built for it. Tableau performs best with it. Snowflake, Synapse, BigQuery — all optimised for Star Schema queries.

Why does Star Schema win?

First — **minimal joins.** To answer 'total revenue by product category by region this quarter', you join FactSales to DimProduct, DimRegion and DimDate. Three joins. No multi-hop. Fast.

Second — **non-technical readability.** A business analyst can look at a Star Schema and understand it in 5 minutes. The Fact table is 'what happened'. Each dimension is a context provider. Clean.

Third — **maintainability.** Need to add a new dimension — say DimPromotion for discount analysis? Add one new table. Add one foreign key to FactSales. Done. No redesign required.

**[VIRTUAL ANNOTATION EXERCISE:]**
'Turn on your annotation tool right now. I want every one of you to draw a line — ANY line — from FactSales to one of the Dimension tables. Then type in the chat which one you chose and why.'

> **[Give 60 seconds. Read a few responses. E.g., 'Priya connected to DimDate because she wants to do quarterly analysis — excellent thinking. DimDate is almost always the first join in any analytics query.']**

> **[VIRTUAL TIP: The annotation exercise breaks the passive watching pattern. Even if only 5 learners do it — it creates visible activity that energises the rest.]**"

> **[Advance to Slide 8]**

---

### SLIDE 8 — Snowflake Schema *(0:40 – 0:43)*

"Star Schema is your default. But sometimes you encounter or need a Snowflake Schema — so let's understand it.

In a Star Schema, DimProduct contains everything about the product — name, category, sub-category, brand. In a Snowflake Schema, you split DimProduct further. Category goes into its own DimCategory table. Brand goes into DimBrand. DimProduct now just contains ProductKey and foreign keys pointing to DimCategory and DimBrand.

Look at the diagram on the left — notice how the connections branch like a snowflake, not a clean star.

**The trade-off is simple:**

Star Schema — less storage, fewer joins, faster queries, simpler to understand. Choose this for BI dashboards.

Snowflake Schema — less data duplication in dimensions, more joins, slightly slower, more complex to maintain. Choose this when your dimension tables are very large with many repeated attribute values, or when storage cost matters at scale.

**[VIRTUAL QUESTION — 60 seconds think, then unmute:]**
'In which specific scenario would you choose a Snowflake Schema over a Star Schema?'

> **[Accept 2-3 spoken answers after the 60-second think. Good answers: large enterprise DW with millions of product attributes; situations where storage cost is significant; when different teams own different levels of the dimension hierarchy.]**

For most of what you'll build in this programme — Star Schema is your default. We only Snowflake when there's a deliberate reason."

> **[Advance to Slide 9 — QUIZ]**

---

### SLIDE 9 — MID-SESSION QUIZ *(0:43 – 0:48)*

> **[VIRTUAL TIP: Change your energy here — smile, sit forward, create excitement.]**

"Quiz time! Three questions. Four minutes. Submit your answers in the Chat — I want to see everyone's response, not just the first person.

**[VIRTUAL TIP: Use Mentimeter for best results — www.menti.com. Create a free account, set up three open-text questions before the session. The live word cloud on Q1 is particularly engaging.]**

Q1 — What is the key difference between a Fact table and a Dimension table?

Q2 — In a Star Schema for a hospital, name three Dimension tables and their primary keys.

Q3 — A company's BI tool is running slowly. A consultant says 'your Snowflake Schema has too many joins.' What would they recommend instead — and why?

Type your answers. Four minutes. Go."

> **[VIRTUAL TIP: During the 4-minute window, do NOT go silent. Say things like: 'Good — I can see answers coming in.' 'Take your time on Q2 — think about who, what, when, where in a hospital.' Silence in virtual sessions feels like disconnection.]**

"Let's go through answers:

**Q1:** Fact table = records measurable business events (metrics + foreign keys). Dimension table = provides descriptive context (who, what, where, when). Fact is tall and narrow, Dimension is small and wide.

**Q2:** In a hospital Star Schema — good dimension tables include:
- DimDate (DateKey PK) — when the appointment was
- DimDoctor (DoctorKey PK) — the treating physician
- DimDepartment (DeptKey PK) — which ward or specialty
- DimPatient (PatientKey PK) — the WHO
- DimDiagnosis (DiagnosisKey PK) — the WHAT

**Q3:** The consultant would recommend converting to a **Star Schema** — denormalize the dimension tables (collapse sub-dimensions back into their parent dimension table). This reduces the number of joins per query, which is the primary driver of query performance in BI workloads.

Well done everyone. Let's apply this now."

> **[Advance to Slide 10]**

---

### SLIDE 10 — Real Life: E-Commerce Star Schema *(0:48 – 0:52)*

"Let's walk through a complete, real example.

Business question: 'Which product category generated the most revenue by region this quarter?'

To answer this, I need:
- Revenue data — that's my **FactOrderItem**
- Product category information — that's **DimProduct** with a Category column
- Region information — **DimRegion**
- The quarter filter — **DimDate** with a Quarter column

Look at the Fact table on the left. Notice the FK columns — DateKey, ProductKey, CustomerKey, RegionKey — these are the connections. Notice the metric columns — Quantity, UnitPrice, Discount, Revenue — these are what gets aggregated.

Now look at the SQL query in the dark box at the bottom right. This is exactly how a data engineer would write the query against this model:

SELECT Category, Region, SUM(Revenue)
FROM FactOrderItem
JOIN DimProduct, DimDate, DimRegion
WHERE Quarter = 'Q1'
GROUP BY Category, Region

Clean. Readable. Fast. And directly powered by the model design.

**[VIRTUAL TIP: Walk through the SQL slowly — point to each JOIN and match it back to the FK in the Fact table. 'DateKey here JOIN DimDate here — the model makes this join obvious.']**

**[Discussion — 60 seconds, unmute:]**
'If the CFO also wanted to know which customer segment bought most in each category — what would you need to add to this query?'

> **[Answer: Add DimCustomer to the JOIN and add Segment to the SELECT and GROUP BY. No structural model change needed — just an additional join to an existing dimension. That's the power of Star Schema.]**"

> **[Advance to Slide 11]**

---

### SLIDE 11 — Data Modelling Decisions *(0:52 – 0:55)*

"Six decisions every data modeller makes before touching a keyboard. Let me go through these fast — we'll go deep in the next sessions.

**Decision 01 — What is the business question?** Design backwards. Never start from the data, start from what the business needs to answer.

**Decision 02 — What is the grain?** The grain is the most important decision you'll make. One row = one what? One order? One order line? One daily summary? Getting this wrong corrupts every metric downstream.

**Decision 03 — Star or Snowflake?** Default is Star. Snowflake only when there's a deliberate reason.

**Decision 04 — Fact vs Dimension attributes?** Metrics and keys → Fact. Descriptive, categorical, stable attributes → Dimension. When in doubt — if you'd SUM or COUNT it, it's a Fact column.

**Decision 05 — How does the model handle change over time?** This is Slowly Changing Dimensions — SCD. What happens when a customer moves city? Does their historical sales reflect the old city or the new one? This is an advanced topic — I'm flagging it now so you know it exists. We'll revisit it later in the programme.

**Decision 06 — Who queries this model?** Power BI analyst? Python data scientist? Both need different optimisations. Know your consumer before you design.

**[VIRTUAL TIP: Don't rush this slide. Each decision is a concept they'll revisit repeatedly. Say: 'Screenshot this if you find it useful — these six questions are your modelling checklist for the rest of the programme.']**"

> **[Advance to Slide 12]**

---

### SLIDE 12 — Summary *(0:55 – 0:58)*

"Six takeaways in 90 seconds:

1 — Data modelling organises data into structures that answer business questions efficiently.

2 — Fact tables hold measurable events — metrics and foreign keys. They grow tall, fast.

3 — Dimension tables hold context — who, what, where, when. Small, wide, descriptive.

4 — Star Schema: one Fact at the centre, dimensions radiate out. Simple, fast, BI-ready. Industry default.

5 — Snowflake Schema normalises dimensions into sub-tables. More joins, less duplication. Use it deliberately.

6 — Great modelling starts with six questions — what's the question, what's the grain, who queries it?

**[VIRTUAL REFLECTION — Chat:]**
'One thing you're taking away from today — drop it in the chat right now.'

> **[Read 3-4 responses. This takes 30 seconds and creates a sense of closure and shared learning.]**"

> **[Advance to Slide 13]**

---

### SLIDE 13 — Q&A / Close *(0:58 – 1:00)*

"Any questions? Raise your hand or type in the Chat. I have 2 minutes.

**[If no hands raised, use this prompt:]**
'Let me ask you: if you had to design a data model for your bank right now — what would the Fact table measure, and what would your most important dimension be?'

**Homework for W2 S2:**
Pick any app you use daily — Swiggy, PhonePe, your company portal.
Identify: what would the Fact table be? Name 3 dimensions with their Primary Key column.
Share at the start of the next session in the chat — I'll call on 3 people.

See you in W2 S2 — ETL vs ELT, batch vs real-time, and the industry tools that move data into the models we designed today."

> **[VIRTUAL TIP: End on time. Overrunning in virtual settings destroys trust and attendance. If you're running long, drop one slide — cut Slide 10 or shorten Slide 11. Never sacrifice the quiz (Slide 9) or summary (Slide 12).]**

---
---

# ⚡ FULL QUIZ PACK — WEEK 2, SESSION 1

---

## PART A — MID-SESSION QUIZ (Slide 9 — at ~43 min mark)

### Q1. What is the key difference between a Fact table and a Dimension table?
**Answer:** A Fact table records measurable business events — it contains metrics (amounts, quantities) and foreign keys pointing to dimension tables. It grows very large (millions of rows) and is tall and narrow. A Dimension table provides descriptive context (who, what, where, when) — it is small, wide, and contains text-based categorical attributes that rarely change. Fact = HOW MUCH. Dimension = WHO/WHAT/WHERE/WHEN.

### Q2. In a Star Schema for a hospital, name three Dimension tables and their Primary Keys.
**Model Answers (any three):**
- DimDate (DateKey PK) — when the appointment occurred
- DimDoctor (DoctorKey PK) — the treating physician
- DimDepartment (DeptKey PK) — the hospital department/ward
- DimPatient (PatientKey PK) — the patient identity
- DimDiagnosis (DiagnosisKey PK) — the medical condition

### Q3. A BI tool is running slowly. The consultant says 'your Snowflake Schema has too many joins.' What do they recommend?
**Answer:** Convert to a Star Schema — denormalise the dimension sub-tables back into their parent dimension tables. This reduces the number of joins required per query, which is the primary cause of slow performance in BI workloads. Star Schema trades a small amount of storage efficiency for significantly faster query performance.

---

## PART B — EXTENDED QUIZ

---

### SECTION 1 — Multiple Choice (1 mark each)

**Q1.** Which of the following columns belongs in a Fact table?
- A) CustomerCity
- B) ProductCategory
- C) ✅ SalesAmount
- D) RegionZone

---

**Q2.** In a Star Schema, the Fact table connects to Dimension tables via:
- A) Primary Keys stored in the Dimension table
- B) ✅ Foreign Keys stored in the Fact table
- C) Natural join conditions on text columns
- D) Unique constraints on both tables

---

**Q3.** A DimDate table contains: DateKey, Date, Day, Month, Quarter, Year, IsWeekend. Why is IsWeekend included?
- A) It reduces storage space
- B) ✅ It allows analysts to filter or group data by weekend vs. weekday without computing it in SQL
- C) It is required for ACID compliance
- D) It is a Primary Key for the date dimension

---

**Q4.** What does the 'grain' of a Fact table mean?
- A) The total number of rows in the table
- B) The largest metric stored in the table
- C) ✅ The level of detail that one row represents — e.g., one row per transaction, or one row per daily summary
- D) The type of primary key used

---

**Q5.** A Snowflake Schema differs from a Star Schema primarily because:
- A) It has a different Fact table structure
- B) It cannot be queried with SQL
- C) ✅ Dimension tables are further normalised into sub-dimension tables
- D) It does not support foreign key relationships

---

**Q6.** For a Power BI dashboard showing monthly sales by product and region, which schema would you recommend?
- A) Snowflake Schema — more normalised
- B) ✅ Star Schema — fewer joins, faster BI performance
- C) Third Normal Form — for data integrity
- D) Flat file schema — simplest to implement

---

**Q7.** A table has 10,000 rows and 45 columns including ProductName, Category, SubCategory, Brand, Supplier, and Weight. This table is most likely a:
- A) Fact table
- B) ✅ Dimension table
- C) Staging table
- D) Bridge table

---

**Q8.** Which of the following best describes a Slowly Changing Dimension (SCD)?
- A) A dimension table that has fewer than 100 rows
- B) A Fact table with infrequent updates
- C) ✅ A dimension where attributes may change over time — e.g., a customer changes their city or segment
- D) A dimension that stores date-related attributes

---

### SECTION 2 — True or False (1 mark each)

**Q9.** A Fact table should store descriptive text like product names and customer addresses for easy querying.
**Answer:** ❌ FALSE — Fact tables store Foreign Keys that point to dimension tables, not descriptive text. Storing text in Fact tables causes duplication, maintenance problems and slow queries.

**Q10.** In a Star Schema, each Dimension table connects directly to the Fact table.
**Answer:** ✅ TRUE — that is the defining structure of a Star Schema. All dimension tables have a direct relationship to the central Fact table.

**Q11.** A Snowflake Schema always performs faster than a Star Schema for BI queries.
**Answer:** ❌ FALSE — Snowflake Schema typically performs slower due to more joins required to traverse sub-dimension tables.

**Q12.** The grain of a Fact table should be decided after the table is designed.
**Answer:** ❌ FALSE — the grain must be decided FIRST. It determines what every row represents and shapes the entire model design.

**Q13.** DimDate is one of the most important and commonly used dimension tables in enterprise data models.
**Answer:** ✅ TRUE — almost every business analysis involves a time dimension. DimDate enables filtering by day, week, month, quarter, year, and custom periods.

---

### SECTION 3 — Scenario Short Answer (2 marks each)

**Q14.** Design a basic Star Schema for a ride-hailing app (like Ola/Uber). Name: the Fact table, its 5 key columns, and 4 Dimension tables with their primary keys.

**Model Answer:**
- **FactRide** — RideID (PK), DateKey (FK), DriverKey (FK), CustomerKey (FK), CityKey (FK), Duration (mins), Distance (km), FareAmount (decimal), Rating (decimal)
- **DimDate** — DateKey (PK), Date, Day, Month, Year, IsWeekend
- **DimDriver** — DriverKey (PK), DriverName, VehicleType, Rating, JoinDate
- **DimCustomer** — CustomerKey (PK), Name, Email, City, MemberSince
- **DimCity** — CityKey (PK), CityName, State, Region, Country

---

**Q15.** A junior data engineer has built the following Fact table for a bank:

```
FactLoan:
LoanID, CustomerName, CustomerCity, CustomerAge,
BranchName, BranchRegion, LoanAmount, InterestRate,
LoanDuration, LoanType, ApplicationDate, ApprovalDate
```

Identify three problems with this design and suggest corrections.

**Model Answer:**
1. **CustomerName, CustomerCity, CustomerAge** — descriptive customer attributes stored directly in the Fact table. Create DimCustomer with CustomerKey and move these there. Add CustomerKey (FK) to FactLoan.
2. **BranchName, BranchRegion** — branch attributes in the Fact table. Create DimBranch with BranchKey and move these there. Add BranchKey (FK) to FactLoan.
3. **LoanType** — a categorical/descriptive attribute that could drive segmentation analysis. Move to DimLoanType with LoanTypeKey. Add LoanTypeKey (FK) to FactLoan.
4. **ApplicationDate, ApprovalDate** — two date columns that likely need time-based analysis. Each should reference DimDate as ApplicationDateKey (FK) and ApprovalDateKey (FK) rather than storing raw dates.

---

**Q16.** Explain why DimDate typically contains 30+ columns (Day, Month, Quarter, Year, IsWeekend, FiscalYear, MonthName, etc.) rather than just storing a single Date column.

**Model Answer:** DimDate contains many derived and pre-computed date attributes so that business analysts and BI tools do not need to compute them in every query. Instead of writing `MONTH(DateColumn)` in SQL or DAX, an analyst can simply filter on `DimDate.Month = 'March'`. This makes queries simpler, faster, and enables non-technical users to build their own reports in Power BI without writing code. Pre-computing fiscal year, quarter, weekend flags, and other business-specific date attributes makes the dimension a self-contained time reference that serves all business queries.

---

### SECTION 4 — Rapid Fire Verbal (read aloud, learners shout answer)

| Question | Answer |
|----------|--------|
| Fact or Dim: 'OrderQuantity'? | Fact (metric) |
| Fact or Dim: 'ProductBrand'? | Dimension (descriptive) |
| Fact or Dim: 'CustomerKey'? | Fact (foreign key that lives in Fact) |
| What is the 'grain' of a Fact table? | The level of detail each row represents |
| Which schema uses sub-dimension tables? | Snowflake Schema |
| Which schema is better for BI dashboards? | Star Schema |
| What does FK stand for in data modelling? | Foreign Key |
| Name one column you'd always find in DimDate. | DateKey / Month / Year / Quarter etc. |
| A hospital measures 'appointments per doctor per week' — what is the Fact? | FactAppointment |
| What question does DimRegion answer? | WHERE? |

---

## 🎮 INTERACTIVE ACTIVITY IDEAS (VIRTUAL)

### 1. "Classify This Column" — Live Chat Game (5 min)
Display 10 column names one by one in the chat. Learners type FACT or DIM. First correct answer each round gets a point. Keep a leaderboard on a side notepad visible on screen. Competitive energy drives participation.

Columns to use:
- SalesRevenue → FACT | ProductCategory → DIM | TransactionDate (the column itself) → DIM | DateKey (FK in Fact) → FACT | CustomerSegment → DIM | Quantity → FACT | RegionZone → DIM | DiscountAmount → FACT | BrandName → DIM | UnitCost → FACT

### 2. "Build My Star" — Collaborative Whiteboard (8 min)
Open draw.io or the virtual whiteboard. Drop a blank "FactSales" box in the centre. Ask learners to each name ONE dimension table in the chat. As they respond, you add the boxes and draw lines live. Result: a collaboratively built Star Schema. Learners are more invested in a diagram they helped create.

### 3. "Diagnose This Model" — Screen Share (5 min)
Share a badly designed flat table (from slide 4, left side). Ask the class: 'What's wrong? What would you fix?' Collect answers in chat. Reveal the corrected Star Schema slide. Works well as a session opener or a quiz debrief.

### 4. "30-Second Model" — Speed Round (3 min, end of session)
Say: 'I'm going to name an industry. You have 30 seconds to type the Fact table name and one dimension in the chat. Go.'
- Industry: Airline → FactFlight, DimRoute/DimPassenger/DimAircraft
- Industry: Streaming app → FactViewingSession, DimContent/DimUser
- Industry: Supermarket → FactTransaction, DimProduct/DimStore

### 5. Mentimeter Word Cloud (2 min)
After the summary slide: 'What is the one thing you'll remember from today?' Run a Mentimeter word cloud — the visual result of 15–20 learners all contributing simultaneously is energising and creates a shared closing moment.

---

## 💡 VIRTUAL DELIVERY TIPS — SPECIFIC TO THIS SESSION

1. **The star schema diagram (Slide 7)** is best explained while pointing with your cursor — use your mouse as a pointer and trace each line from Fact to Dimension while saying 'this key here connects to this table here.' Learners lose the spatial relationship if you just talk without pointing.

2. **Silence in virtual = disengagement** — never be silent for more than 30 seconds. If learners are thinking, narrate what you're waiting for. 'I'm seeing some great answers coming in — take 20 more seconds' is better than dead air.

3. **Force participation every 5–7 minutes** — use Chat, Mentimeter, raise hand, verbal poll, or annotation. Research shows virtual attention drops dramatically without active involvement. Set a timer if needed.

4. **Show your face even when sharing screen** — keep your webcam on in a small corner pip. Facial expressions and body language maintain the human connection that virtual format strips away.

5. **Camera check at 30 min mark** — say 'Quick check — can everyone still see my screen clearly? Thumbs up in chat.' This breaks the monotony and catches any screen share issues early.

6. **For the Snowflake vs Star question (Slide 8)** — use the 'think, then unmute' method rather than chat. Give 60 seconds of thinking time, then say 'I'll pick three people — Rahul, Priya, Mohammed — please unmute when I call your name.' This prevents the 'just read the chat' passive mode.

7. **Homework review at the START** builds accountability culture — if learners know you'll ask for homework answers at the beginning of every session, they complete it. Read names, praise effort, correct gently.

8. **If the quiz runs long** — skip reading all answers and only cover Q3 (the hardest). The other answers can be posted in the group chat after the session.

---

*End of Trainer Script & Quiz Pack — Week 2, Session 1 — Data Modelling Concepts*