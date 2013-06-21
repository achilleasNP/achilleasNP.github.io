---
title: Equivalence relations, partitions and counting
layout:  post
--- 

The goal of this blurb is an attempt to explain how I find unique genotypes to a graduate student who was unfortunate enough to have to work with me. 
Let's assume that we have a set of objects S={a,b,c,...} and a relation `\(\sim\)` on the set S which satisfies
the following properties:

1. `\( \forall a \in S,\;\; a \sim a\)` (Reflexive)
2. `\(  a\sim b \Leftrightarrow  b \sim a\)`  (Symmetric)
3. `\(  a \sim b,\, b \sim c \Rightarrow a \sim c \)` (Transitive)

The relation `\(\sim \)` is called an equivalence. 
Given an element a in S we can define the set 
$$ E(a) = \\{ b | b \in S \; \text{and}\; a \sim b \\} \; .$$ 
The set E(a) is called the equivalence class of a. It is easy to show that if an element b in E(a) then E(b) = E(a).

From this it follows that for any two elements a,b in S we either have $$E(a)=E(b)$$ or $$E(a) \cap E(b) = \emptyset$$ . Moreover, any element a in S belongs to one of the equivalence classes, namely E(a).
So the equivalence classes split the set S to pairwise disjoint sets (that is they form a partition for the set S). 

Assume that we have a function $$f: S \mapsto  R $$ such that $$ f(a) = f(b) \Leftrightarrow a \sim b \;\;(1). $$
Then the number of distinct values that the function S takes is equal to the number of equivalence classes.

So let's take now the case where S is a set SNPs. We can define the following relation we say that two SNPs are equivalent if the genotype vector for the population under study (of size n) for the two SNPs is identical.  The relation just defined is an equivalence relation. 

Consider the function $$f(SNP)=\sum_{i=1}^{n} 3^i g_i$$
where `\(g_i\)` is the 0,1,2 genotype at SNP for the i-th individual. This function maps the genotype vector to an integer by considering the vector as a base 3 representation of an integer. It is easy to show that for a fixed base k  and number has a unique representation. So the function f satisfies condition (1).
Therefore the number of values that the function f takes over the set of SNPs S is equal to the number of distinct SNPs.
