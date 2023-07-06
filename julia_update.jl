# Here is the code to install packages. 
# See readme 
using Pkg
Pkg.update()

using BEFWM2

fw = FoodWeb(nichemodel, 10, C = 0.2, Z = 10)

st = AddStochasticity(fw, addstochasticity = true, target = "producers", θ = 1.2, σe = 0.4)

println(st.addstochasticity)
