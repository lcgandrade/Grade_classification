<h1 align="center"> Grade Classification </h1>

<h2> Summary </h2> 
___________________
<p> This project </p>
<p align="center">
    <a href= "#About">About </a> *
    <a href= "#Requirements">Requirements </a> *
    <a href= "#Problem">Problem </a> *
    <a href= "#Solution">Solution </a> *
    <a href= "#Method">Method </a> *
    <a href= "#Visualization">Visualization </a> *
    <a href= "#Conclusion">Conclusion </a> *
</p>

# About
<p> Let's learn some ways of sorting algorithms from cluster analysis </p>

# Requirements
<p> I recommend downloading the R cran installer https://cran.r-project.org/ and later the RStudio software https://www.rstudio.com/products/rstudio/download/ to run the scripts below and view the interactions </p>

# Problem
<p> I need to identify which groups of students have difficulties in common with determining the end of assistant teacher causes. </p>

# Solution
<p> Create an algorithm capable of generating groups that are homogeneous among themselves and heterogeneous among groups. </p>

# Method
<p> hierarchical: The approaches will be used: “Euclidean distance” using “single” . </p>
<p> unhierarchical: The approaches will be used: kMeans e Dbscan . </p>

# Visualization
<p> hierarchical: cluster dendrogram. </p>
<p> unhierarchical: cluster kmeans. </p>

# Conclusion
<p>  For the subjects "mkt" and "actuary" the non-hierarchical dbscan method meets the resource limitation to work with students divided by group. It can be seen that the distribution was satisfied, reaching from students with characteristics in common, to students who did not belong to any group due to their own characteristics.
For the subjects "finance" and "costs", the non-hierarchical k-means method meets the needs for classifying students.
In this way, based on the data, it will be possible to act in groups that are homogeneous and heterogeneous with each other. </p>