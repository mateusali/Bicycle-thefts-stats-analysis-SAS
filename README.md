# Toronto Bicycle Theft Analysis – SAS

This project explores **4 years of bicycle theft data in Toronto** using SAS for statistical analysis and visualization.  
The goal was to uncover patterns and insights related to **when, where, and how bicycles are stolen**, and to test relationships between different variables such as bike type, cost, season, and time of day.  

---

## 📊 Dataset
- **Source:** [Toronto Police Service – Bicycle Thefts](https://open.toronto.ca/dataset/bicycle-thefts/)  
- **Period:** 2014 – Sept 2024  
- **Size:** 10 years of reported bicycle thefts, > 30,000 records   * Only used 2020 - 2024
- **Key Variables Used:**
  - OCC_YEAR (Year of occurrence)  
  - OCC_MONTH (Month of occurrence)  
  - OCC_DOW (Day of week)  
  - OCC_HOUR (Hour of occurrence)  
  - BIKE_TYPE (Type of bicycle)  
  - BIKE_COST (Estimated value)  
  - BIKE_SPEED (Max speed)  
  - STATUS (Recovered / Not Recovered)  
  - PREMISES_TYPE (Location of theft)  

---

## 🧭 Methodology
1. **Data Cleaning & Preparation**
   - Removed extreme outliers (below Q1, above Q3).
   - Reformatted categorical variables (bike type, premise type, weekdays vs weekends, time of day).
   - Created segmentations (seasons, cost ranges, reporting delays).

2. **Univariate Analysis**
   - Theft distribution by year, month, day, and hour.
   - Average cost & speed of stolen bikes.
   - Percentage of recovered bicycles.
   - Premises with most thefts (apartments & outdoor areas).

3. **Bivariate Analysis**
   - Growth of e-bike thefts from 2020–2024 (+135% until 2023, drop in 2024).
   - Bike cost vs day of week & time of day (no significant association).
   - Premises type vs season (statistically significant relationship).
   - Correlation between bike cost and speed (weak relationship).
   - Weekday vs weekend bike cost (weekends slightly higher, statistically significant).

---

## 📈 Key Findings
- **Seasonality:** Summer, especially July, shows the highest theft rates.  
- **Timing:** Afternoon is the riskiest time of day for thefts.  
- **Premises:** 54% of thefts occur outside or in apartment areas.  
- **Value:** Average stolen bike cost ≈ **$900**; most thefts in $500–$1,000 range.  
- **Recovery:** Only **0.47%** of stolen bicycles were recovered.  
- **Trends:** E-bike thefts surged between 2020–2023, but declined in 2024.  

---

## 🛠️ Tools & Techniques
- **Language:** SAS (PROC FREQ, PROC MEANS, PROC CORR, PROC TTEST, PROC ANOVA).  
- **Visualizations:** Bar charts, box plots, scatter plots, pie charts.  
- **Statistical Tests:** Chi-square, correlation, ANOVA, t-tests.  

---

## 📂 Repository Structure
