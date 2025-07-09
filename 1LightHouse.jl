
using Random, Distributions, LinearAlgebra, Plots
#Leuchtturm
a=50
b=20

# a) Datenpunkte generieren
i=20
t= rand(Cauchy(), i)
x=a .+ b.*t

# b) Warscheinlichkeitsdichte
function meshgrid(x, y)
    X = repeat(x', length(y), 1)  # ersetzt meshgrid, habs nachgeschaut
    Y = repeat(y, 1, length(x))   
    return X, Y
end

a= LinRange(20, 80 ,100)
b= LinRange(5, 40, 100)
A, B= meshgrid(a,b)

function post(x, A, B)
    P=ones(size(A))
    for k in eachindex(x)
        P .*= (B ./ (π .* ((x[k] .- A).^2 .+ B.^2)))
    end
    return P./sum(P) #damits auch normalized is
end
P=post(x,A,B)

display(surface(a,b,P,
     xlabel="a",
     ylabel="b", 
     zlabel="P(a,b|x)", 
     title= "Posterior or Likelihood because P(a)=P(b)"))


# c) ML's
a_ML = A[argmax(P)]
b_ML = B[argmax(P)]

println("Maximum Likelihood Schätzer:")
println("α_ML = $a_ML")
println("β_ML = $b_ML")
