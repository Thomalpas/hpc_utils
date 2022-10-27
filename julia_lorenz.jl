using DifferentialEquations
using Plots

function lorenz!(du,u,p,t)
 du[1] = 10.0*(u[2]-u[1])
 du[2] = u[1]*(28.0-u[3]) - u[2]
 du[3] = u[1]*u[2] - (8/3)*u[3]
end

u0 = [1.0; 0.0; 0.0]
tspan = (0.0,100.0)
prob = ODEProblem(lorenz!,u0,tspan)
sol = solve(prob)

p = plot(sol,idxs=(1,2,3))


Plots.savefig(p, "lorenz.png")
println("Should have saved a plot here")

# Test for fun
# Can be handy to print simple plot in the output file on the cluster
#https://discourse.julialang.org/t/saving-unicodeplots-to-txt-with-color/60069/4  

unicodeplots()

p = plot(sol,idxs=(1,2,3))
p

Plots.savefig(p, "lorenz_plot.txt")
read(`less lorenz_plot.txt`, String)
