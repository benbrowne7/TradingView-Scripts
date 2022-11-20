# TradingView-Scripts
indicator scripts and trading systems written in PineScript 

## Velocity of Price (Indicator):
- Indicator tracking the rolling x day % change from open to close. 
- Accounting for outliers (pre 2013) and noise (<4% changes) calculates average down/up moves 
- Plots lines 1/2/3 standard deviations from this calculated mean to find high probability zones of 'peak price velocity' 
- Not meant as a price reversal indicator (price can simply stall for x days to reset to 0)
- Hitting of the 3std line is rare and may indicate a capitulation of price depending on context
- Tuned for Bitcoin Specifically
