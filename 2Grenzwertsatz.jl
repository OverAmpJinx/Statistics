using Random, Statistics, Distributions, Plots

# Params
L = 1000  
N_values = [1, 2, 5, 10, 30, 50, 100]  

# Verteilung 
d = Uniform(0, 1)


#mittelwert und so
histograms = []
for N in N_values
    means = [mean(rand(d, N)) for _ in 1:L]  # Mittelwert aus N Samples, L Wiederholungen
    push!(histograms, means)
end

#plot
p=plot(layout=(length(N_values), 1), size=(800, 1200), legend=false)
for (i, means) in enumerate(histograms)
    μ = mean(means)
    sigma = std(means)

    histogram!(p,means, bins=30, normalize=true, label="", subplot=i)

    # Normalverteilung drüberlegen
    x_vals = LinRange(μ - 4sigma, μ + 4sigma, 200)
    g = pdf.(Normal(μ, sigma), x_vals)
    plot!(p, x_vals, g, lw=2, label="g(x)", subplot=i)

    title!("N = $(N_values[i])", subplot=i)
end

display(p)
