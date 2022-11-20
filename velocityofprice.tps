// This source code is subject to the terms of the Mozilla Public License 2.0 at https://mozilla.org/MPL/2.0/
// © benbrowne_

//@version=5
indicator("Velocity o Price")
int timePeriod = input(2, "Period (days")
int gradientPeriod = input(1, "Gradient Period (days)")
int noiseThreshold = input(4, "Noise Threshold (%)")
bool plot3std = input(false, "Plot 3std from Mean")
var y0 = line.new(x1=0, y1=0, x2=100, y2=0, extend=extend.both, color=color.black, style=line.style_dashed, width=1)
var maxima = array.new_float(0)
var minima = array.new_float(0)

diff = (close - open[timePeriod])  //current close - 2 candles agos open (3 trading sessions)
perc_diff = (diff / open[timePeriod]) * 100
gradient = (perc_diff - perc_diff[gradientPeriod]) / gradientPeriod

bool negpos = (gradient > 0) and (gradient[gradientPeriod] < 0)
bool posneg = (gradient < 0) and (gradient[gradientPeriod] > 0)

if (negpos) and (perc_diff < -noiseThreshold) and (perc_diff > -44)
    array.unshift(minima, perc_diff)
if (posneg) and (perc_diff > noiseThreshold) and (perc_diff < 44)
    array.unshift(maxima, perc_diff)

down_moves_avg = array.avg(minima)  //average 'down moves' over specified timePeriod, assuming <4% moves as noise and removing outliers (pre 2013)
up_moves_avg = array.avg(maxima)  //average 'up moves' over specified timePeriod, assuming <4% moves as noise and removing outliers (pre 2013)
down_moves_std = array.stdev(minima)
up_moves_std = array.stdev(maxima)

//plot(down_moves_avg, color=color.red, style=plot.style_line, trackprice=true, show_last=1)
//plot(up_moves_avg, color=color.green, style=plot.style_line, trackprice=true, show_last=1)

plot(up_moves_avg + up_moves_std, color=color.lime, trackprice=true, show_last=1)
plot(up_moves_avg + 2*up_moves_std, color=color.lime, trackprice=true, show_last=1)

plot(down_moves_avg - down_moves_std, color=color.fuchsia, trackprice=true, show_last=1)
plot(down_moves_avg - 2*down_moves_std, color=color.fuchsia, trackprice=true, show_last=1)

float stdthreeup = up_moves_avg + 3*up_moves_std
float stdthreedown = down_moves_avg - 3*down_moves_std

if plot3std == false
    stdthreeup := na
    stdthreedown := na

plot(stdthreeup, color=color.white, trackprice=true, show_last=1)
plot(stdthreedown, color=color.white, trackprice=true, show_last=1)

plot(perc_diff)

