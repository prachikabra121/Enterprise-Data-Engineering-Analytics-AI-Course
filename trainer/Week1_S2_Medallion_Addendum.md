# 📘 TRAINER SCRIPT ADDENDUM
## Slide 12 — Medallion Architecture (Newly Added)
### Week 1, Session 2 — Data Flow in Applications

> **⚠️ INSERT THIS BLOCK between the existing Slide 11 script and the Slide 12 (now Slide 13) Summary script.**
> All other scripts remain unchanged.

---

## ⏱ UPDATED TIMING MAP (Slide 12 added)

| Time        | Activity                                        | Slide |
|-------------|-------------------------------------------------|-------|
| 0:52 – 0:55 | Full architecture view (unchanged)              | 11    |
| **0:55 – 1:02** | **⭐ Medallion Architecture — NEW**         | **12** |
| 1:02 – 1:05 | Session Summary (was 0:55)                      | 13    |
| 1:05 – 1:07 | Homework                                        | 13    |
| 1:07 – 1:10 | Q&A and close                                   | 14    |

> 💡 **Trainer note:** This slide adds ~7 minutes. Either trim the industry flow activity (Slide 10) to 5 minutes instead of 8, or run this session as a 65-minute slot. Both work fine.

---

## 🎤 SLIDE 12 SCRIPT — Medallion Architecture *(0:55 – 1:02)*

> **[Transition from Slide 11 — point to the Data Storage row in the architecture diagram]**

"Look at this row here — 'Data Storage: SQL DB | Data Lake | Cache | File Store.' We mentioned the Data Lake. Now I want to zoom into something that happens *inside* that lake — because this is one of the most important patterns you will use every day as a Data Engineer.

It's called the **Medallion Architecture**. And once you see it, you'll spot it everywhere — Databricks is built around it, most modern data platforms use it, and in Week 13 we'll actually build it ourselves."

> **[Advance to Slide 12]**

"Look at the three columns — Bronze, Silver, Gold. Think of it like refining ore into jewellery. You start with raw material and progressively make it more valuable.

---

**🥉 Bronze — the Raw Landing Zone.**

This is where data arrives exactly as it was sent. No changes. No cleaning. No transformation.

If your payment system sends you a JSON file at midnight — it lands in Bronze exactly as it came. If an IoT sensor sends a temperature reading with a typo in the field name — it lands in Bronze with the typo still in it.

*Why keep it messy?* Because Bronze is your safety net. It is the source of truth for what actually arrived. If six months from now someone discovers the Silver layer had a bad transformation rule — you go back to Bronze and reprocess. Without Bronze, that data is gone forever.

The rule for Bronze is absolute: **never delete, never modify, append only.**

---

**🥈 Silver — the Cleansed and Conformed layer.**

This is where the engineering work happens. You take Bronze data and you:
- Fix column names and data types
- Remove duplicates
- Handle null values
- Standardise formats — dates all in YYYY-MM-DD, phone numbers with country codes, currencies in a single base

Silver is where your data becomes **trustworthy**. An analyst can query Silver and know the data is consistent. It won't have random nulls. It won't have the same customer appearing twice with different spellings of their name.

The rule for Silver: **consistent, correct, and reusable.**

---

**🥇 Gold — Business-Ready and Aggregated.**

This is where your data becomes **valuable**. Silver data gets modelled into fact tables, dimension tables, KPI summaries, customer 360 profiles.

When a Power BI dashboard connects to a database — it almost always connects to Gold. When a data scientist runs a model — they train it on Gold. When the CEO asks 'what was our revenue last quarter?' — that answer comes from Gold.

Gold is optimised for speed and governed for trust.

---

**[Link back to the pipeline — point to the bottom bar on the slide]**

Now here's the crucial connection to what we learned today:

- **Bronze = Storage (raw)** — this is where Input data lands after the Processing stage accepts it
- **Silver = Storage (processed)** — this is an internal processing step *within* storage
- **Gold = Output-ready** — this is what feeds your Output layer: dashboards, APIs, ML models

Medallion Architecture *lives inside* your Data Lake. It's not a replacement for the four-stage pipeline — it's a detailed map of what happens inside the Storage box.

In Week 12 and 13, we'll build a Bronze→Silver→Gold pipeline ourselves inside Databricks. Today — just understand the concept and the purpose of each layer.

---

**[Quick comprehension check — ask the room]:**

> 'If a data analyst complains that a report is showing duplicate customer records — which Medallion layer most likely has the problem?'

*(Answer: Silver — deduplication is a Silver responsibility. If Silver is clean, Gold won't have duplicates.)*

> 'If a bug is found in the transformation logic six months after data was processed — which layer lets you recover?'

*(Answer: Bronze — because it holds the original, unmodified data.)*

Great. That's Medallion. Write it down, draw it, stick it on your wall — you'll be building it in Week 13."

> **[Advance to Slide 13 — Session Summary]**

---

---

## ⚡ QUIZ ADDENDUM — Medallion Architecture Questions

> **Add these to your existing quiz pack. They can be used in the mid-session quiz (replace Q3 if short on time) or as standalone end-of-session questions.**

---

### QUICK VERBAL CHECK (during slide — no writing needed)

**Check 1:** "Which layer holds raw, unmodified data exactly as it arrived?"
**Answer:** Bronze

**Check 2:** "Which layer do analysts and Power BI dashboards typically connect to?"
**Answer:** Gold

**Check 3:** "If a transformation rule had an error, which layer lets you reprocess the data?"
**Answer:** Bronze — because it is never modified

---

### WRITTEN QUIZ QUESTIONS (add to Section 1 — Multiple Choice)

**Q-M1.** In Medallion Architecture, which layer is responsible for deduplication and standardising data types?
- A) Bronze
- B) ✅ Silver
- C) Gold
- D) Platinum

---

**Q-M2.** A data engineer discovers that last month's ETL job applied the wrong currency conversion formula. The corrected data must be reprocessed. Which Medallion layer makes this recovery possible?
- A) Silver
- B) Gold
- C) ✅ Bronze
- D) The Data Warehouse

---

**Q-M3.** A Power BI report showing monthly sales KPIs most likely queries which Medallion layer?
- A) Bronze
- B) Silver
- C) ✅ Gold
- D) Cache (Redis)

---

**Q-M4.** Which of the following correctly describes the Bronze layer's data rule?
- A) Data is cleaned and typed before landing
- B) Data is aggregated for reporting
- C) ✅ Data is appended as-is; never deleted or modified
- D) Data is optimised for fast dashboard queries

---

### TRUE / FALSE (add to Section 2)

**Q-M5.** Medallion Architecture replaces the Input → Process → Storage → Output pipeline.
**Answer:** ❌ FALSE — It describes what happens *inside* the Storage layer. The four-stage pipeline is still the outer model.

**Q-M6.** Gold layer data is the most refined and business-ready layer in Medallion Architecture.
**Answer:** ✅ TRUE

**Q-M7.** It is acceptable to delete raw records from the Bronze layer once they have been processed into Silver.
**Answer:** ❌ FALSE — Bronze must never be deleted or modified. It is the source of truth for recovery.

---

### SHORT ANSWER (add to Section 3)

**Q-M8.** A logistics company receives GPS tracking data from 500 delivery vehicles every 30 seconds. Describe what each Medallion layer would contain for this data.

**Model Answer:**
- **Bronze:** Raw GPS event payloads as received — JSON with timestamp, vehicle ID, lat/long, speed. May contain duplicates, missing fields, or malformed records. Never modified.
- **Silver:** Cleaned and validated GPS records — duplicates removed, coordinates validated, timestamps standardised to UTC, vehicle IDs matched to the vehicle master table, null values flagged.
- **Gold:** Aggregated route summaries — total distance per vehicle per day, average speed per route, delivery zone heatmaps, SLA compliance rates. This feeds the operations dashboard.

---

### CLASSROOM ACTIVITY (Optional — 5 minutes)

**"Sort the Data"**

Read out the following 6 items. Learners shout or hold up a card — Bronze, Silver or Gold:

| Item | Answer |
|------|--------|
| Raw JSON payload from a payment API | 🥉 Bronze |
| Monthly revenue summary table in Power BI | 🥇 Gold |
| Customer records with duplicates removed and dates standardised | 🥈 Silver |
| IoT sensor dump with some null temperature readings | 🥉 Bronze |
| Star schema fact table used for analyst queries | 🥇 Gold |
| Order table after NULL order IDs have been filtered out | 🥈 Silver |

Fast, high energy, zero preparation needed. Works well as a 3-minute energiser after the slide.

---

*End of Trainer Script & Quiz Addendum — Slide 12: Medallion Architecture*
