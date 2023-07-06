# Test for BEFWM2

using BEFWM2

fw = FoodWeb(nichemodel, 10, C = 0.2, Z = 10)

st = AddStochasticity(fw, addstochasticity = true, target = "producers", θ = 1.2, σe = 0.4)

mp = ModelParameters(fw, stochasticity = st)

B0 = repeat([0.5], 10)

sol = simulate(mp, B0, tmax = 50)

open("output.txt", "w") do file
    write(file, string(sol.t[end]))
end
