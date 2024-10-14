
graph_upper_bound = 50
graph_lower_bound = 0
graph_increment = 5
output_type="png"
image_size="1024,768"
set macros

set title font ",30"

points_str = "plot "
combined_str = "plot "
linear_str = "plot [0:100] [0:6] "
slope_deriv = "fp(x) = "
file_suffix = "_increase.dat"

system("echo \"\" > slopes.dat")

# Build command strings
do for [i = graph_lower_bound:graph_upper_bound:graph_increment] {
   eval sprintf("f%d(x) = m%d*x + b%d", i, i, i)
   eval sprintf("fit f%d(x) '%d%s' via m%d,b%d", i, i, file_suffix, i, i)
   eval sprintf("stats '%d%s'", i, file_suffix)
   echo_params = sprintf("echo \"%d %f\" >> slopes.dat", i, STATS_slope)
   system(echo_params)

   if (i == graph_upper_bound){
      combined_str = sprintf("%s \'%d%s\' title \"remove %d nodes per trial\", f%d(x)", combined_str, i, file_suffix, i, i)
      linear_str = sprintf("%s f%d(x)", linear_str, i)
      points_str = sprintf("%s \'%d%s\' title \"remove %d nodes per trial\"", points_str, i, file_suffix, i)
   } else{
        combined_str = sprintf("%s \'%d%s\' title \"remove %d nodes per trial\", f%d(x),", combined_str, i, file_suffix, i, i)
        linear_str = sprintf("%s f%d(x),", linear_str, i)
        points_str = sprintf("%s \'%d%s\' title \"remove %d nodes per trial\",", points_str, i, file_suffix, i)
   }

}



set title 'Change in key lookup time as more nodes are disabled' font "DejaVuSans,20"
set ylabel 'Average time per lookup (s)' font "DejaVuSans,12"
set xlabel 'Trial' font "DejaVuSans,12"
set key left

eval points_str

set term @output_type size @image_size
set output sprintf('points.%s', output_type)
replot

#set term x11



eval combined_str

#set term @output_type size @image_size
set output sprintf('combined.%s', output_type)
replot

#set term x11

eval linear_str

set term output_type
set output sprintf('linear.%s', output_type)
replot

set term x11

set xlabel "Nodes disabled per trial"
set ylabel "Seconds per nodes disabled"
set title "Change in Average RTT as Node Removal Time Increases"
plot [0:55] [-.01:.05] 'slopes.dat' title 'Slope'
set term @output_type size @image_size
set output sprintf('slopes.%s', output_type)
replot
