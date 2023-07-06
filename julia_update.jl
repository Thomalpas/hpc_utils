# Here is the code to install packages. 
# See readme 
using Pkg
Pkg.update()

using BEFWM2

fw = FoodWeb(nichemodel, 10, C = 0.2, Z = 10)
println(richness(fw))
