# Statistical Analysis Case Studies

Small portfolio repo demonstrating classical statistical analysis in R.

## Case Study: Lens Coating Abrasion

A glass manufacturer wants to compare four protective lens coatings after simulated abrasion. Lower impairment values indicate better scratch resistance.

## Methods

- Descriptive statistics by coating.
- Boxplot comparison.
- Shapiro-Wilk normality checks.
- Levene's test for equal variance.
- One-way ANOVA.
- Tukey HSD post-hoc comparisons.

## Finding

The analysis recommends **Coating D** because it has the lowest mean impairment and lower variability. ANOVA indicates statistically significant differences between coatings, and Tukey HSD confirms Coating D performs significantly better than A, B, and C.

## Repository Structure

```text
.
├── R/
│   └── lens_coating_anova.R
├── data/
│   └── lenses.csv
├── requirements.md
└── README.md
```

## How to Run

Open R or RStudio from the repository root and run:

```r
source("R/lens_coating_anova.R")
```

## Portfolio Value

This is a supporting project, useful for showing statistical reasoning and experimental comparison. It should not be a pinned flagship repo unless paired with other statistics examples.
