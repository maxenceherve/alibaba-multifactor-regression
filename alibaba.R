library(readxl)
data = read_excel("data/BABA.xlsx")
# Compute Log-Returns
r_baba  = diff(log(data$BABA))
r_sp500 = diff(log(data$SP500))
r_hsi   = diff(log(data$HSI))
r_fx    = diff(log(data$`USD/CNY`))
# Create a data frame of returns for analysis
returns_df = data.frame(r_baba, r_sp500, r_hsi, r_fx)
library(fBasics)
basicStats(returns_df)
# Time series plot of BABA returns
plot(r_baba, type="l", col="blue", main="BABA Monthly Log-Returns", xlab="Time", ylab="Returns")
abline(h=0, col="red")
# Histogram for normality check
hist(r_baba, breaks=15, main="Distribution of BABA Returns", col="grey", probability=TRUE)
# Estimation of the Multiple Linear Regression Model
model_baba = lm(r_baba ~ r_sp500 + r_hsi + r_fx, data = returns_df)
summary(model_baba)
# Regression Table
library(stargazer)
stargazer(model_baba, type = "text", title = "Table 2: OLS Regression Results for BABA")
# Actual vs Fitted Plot
# This shows how well the model explains BABA returns
plot(returns_df$r_baba, type = "l", col = "blue", lwd = 2, main = "Actual vs Fitted Returns (BABA)", ylab = "Returns", xlab = "Time")
lines(model_baba$fitted.values, col = "red", lwd = 2, lty = 2)
legend("topright", legend = c("Actual", "Fitted"), col = c("blue", "red"), lty = 1:2)
# Residual Analysis (Diagnostic)
hist(model_baba$residuals, breaks = 20, col = "lightgreen", main = "Distribution of Residuals", xlab = "Residuals")
library(lmtest)
# Test for Heteroscedasticity (Breusch-Pagan)
bptest(model_baba)
# Test for Autocorrelation (Durbin-Watson)
dwtest(model_baba)
