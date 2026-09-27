# Alibaba (BABA) Multi-Factor Regression

Is a US-listed Chinese tech giant more sensitive to the American market or its home region? A multi-factor econometric analysis of Alibaba Group's (BABA) stock returns against the S&P 500, the Hang Seng Index and the USD/CNY exchange rate.

Individual project for the Econometrics course at EDHEC Business School, 2025-2026.

## Data

| Series | Role | Source |
|---|---|---|
| BABA (Alibaba Group Holding) | Dependent variable | Yahoo Finance |
| S&P 500 | US market factor | Yahoo Finance |
| Hang Seng Index (HSI) | Hong Kong/China market factor | Yahoo Finance |
| USD/CNY | Currency risk factor | Yahoo Finance |

Monthly adjusted closing prices, January 2018 to November 2025 (95 observations, 94 monthly log-returns). Data is included in [`data/BABA.xlsx`](data/BABA.xlsx).

## Methodology

All price series are converted to continuously compounded (log) returns to ensure stationarity. A multiple linear regression is estimated by OLS:

```
r_baba,t = β0 + β1·r_sp500,t + β2·r_hsi,t + β3·r_fx,t + u_t
```

Diagnostic tests check the robustness of the estimates: a Breusch-Pagan test for heteroscedasticity and a Durbin-Watson test for autocorrelation in the residuals.

## Key results

- The model explains **52.3%** of the variability in BABA's monthly returns (R² = 0.5233, Adj. R² = 0.5074).
- **Hang Seng Index**: coefficient of **1.431**, highly significant (p < 0.001) — a 1% move in the HSI is associated with a 1.43% move in BABA, making it behave as a high-beta proxy for the Hong Kong/China market.
- **S&P 500** (coef. -0.048, p = 0.81) and **USD/CNY** (coef. 0.106, p = 0.88) are **not** statistically significant — despite its US listing, BABA's returns are decoupled from the broad US market over this period.
- Diagnostics support the OLS estimates: no evidence of heteroscedasticity (Breusch-Pagan, p = 0.10) or first-order autocorrelation (Durbin-Watson = 2.13, p = 0.74).

## Repository structure

```
alibaba-multifactor-regression/
├── data/          # BABA, S&P 500, HSI, USD/CNY monthly prices
├── alibaba.R      # analysis script
└── README.md
```

## Run it

Requires R with the `readxl`, `fBasics`, `stargazer` and `lmtest` packages.

```bash
git clone https://github.com/maxenceherve/alibaba-multifactor-regression.git
cd alibaba-multifactor-regression
Rscript alibaba.R
```

## Tech stack

R · readxl · fBasics · stargazer · lmtest
