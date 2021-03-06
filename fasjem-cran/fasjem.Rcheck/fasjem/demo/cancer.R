library(fasjem)

### plotting window reset routine
graphics.off()
par(ask=F)
par(mfrow=c(1,1))

readline(prompt="Press [enter] to continue to cancer demo with 2 tasks (not v. pcr) and 26 features (26 cancer types) ")

### load cancer data (cancer)
data(cancer)

### create a list of cancer data (cancerlist)
cancerlist = list(as.matrix(cancer[[1]][which(cancer[[2]] == "not"),]),
                  as.matrix(cancer[[1]][which(cancer[[2]] == "pcr"),]))

### run fasjem
result = fasjem(X = cancerlist, method = "fasjem-g", 2, 0.1, 0.1, 0.05, 20)

### obtain names for node labelling
label = colnames(cancer[[1]])

### obtain graph for creating layout
graph = returngraph(result)

### create a fixed layout on cancergraph for plotting
layout = layout_nicely(graph,dim=2)



### multiple plotting
readline(prompt="Press [enter] to display four plots showing all graphs, shared graph, task specific 1 and task specific 2")

par(mfrow=c(2,2))

{
  plot.fasjem(result,  graphlabel = label, type="task", graphlayout = layout)

  plot.fasjem(result,  graphlabel = label, type="share", graphlayout = layout)

  plot.fasjem(result,  graphlabel = label, type="taskspecific", subID=1, graphlayout = layout)

  plot.fasjem(result, graphlabel = label, type="taskspecific", subID=2, graphlayout = layout)
}


readline(prompt="Press [enter] to display four plots zooming into node MELK and E2F3 on previous four plots")


nodeid = which(label %in% c("MELK","E2F3")) ### look for id
{
  plot.fasjem(result,  graphlabel = label, type="neighbour", index = nodeid, graphlayout = layout)

  plot.fasjem(result,  graphlabel = label, type="neighbour", subID = 0, index = nodeid,graphlayout = layout)

  plot.fasjem(result,  graphlabel = label, type="neighbour", neighbouroption = "taskspecific",
              subID=1, index = nodeid,
              graphlayout = layout)

  plot.fasjem(result,  graphlabel = label, type="neighbour", neighbouroption = "taskspecific",
              subID=2, index = nodeid,
              graphlayout = layout)
}

### it is also possible to zoom into multiple nodes on multiple graphs specified by input
