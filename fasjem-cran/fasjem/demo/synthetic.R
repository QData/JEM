library(fasjem)

### plotting window reset routine
graphics.off()
par(ask=F)
par(mfrow=c(1,1))



readline(prompt="Press [enter] to continue to synthetic Gaussian data demo with 2 tasks and 20 features")


### load the example data
data(exampleData)

### run fasjem algorithm to estimate two sparse precision matrices from example data

result = fasjem(X = exampleData, method = "fasjem-g", 0.5, 0.1, 0.1, 0.05, 10)
graph = returngraph(result)
layout = layout_nicely(graph,dim=2)
label = NULL

### multiple display
readline(prompt="Press [enter] to view the four plots showing all graphs, shared graph, task 1 and task 2 specific graphs")
par(mfrow=c(2,2))

{
  plot.fasjem(result, graphlabel = label, type="task", graphlayout = layout)

  plot.fasjem(result, graphlabel = label, type="share", graphlayout = layout)

  plot.fasjem(result, graphlabel = label, type="taskspecific", subID=1, graphlayout = layout)

  plot.fasjem(result, graphlabel = label, type="taskspecific", subID=2, graphlayout = layout)
}

### comparsion display

readline(prompt="Press [enter] to view the comparsion between simulated graphs and ground truth graphs")
par(mfrow=c(2,3))
data(exampleDataGraph)

{
  plot.fasjem(result, graphlabel = label, type="share", graphlayout = layout)

  plot.fasjem(result, graphlabel = label, type="taskspecific", subID=1, graphlayout = layout)

  plot.fasjem(result, graphlabel = label, type="taskspecific", subID=2, graphlayout = layout)

  plot.igraph(exampleDataGraph[[1]],layout = layout, vertex.label.font=2,
              vertex.shape="none",
              vertex.label.color="gray40",
              vertex.label.cex=.7, vertex.frame.color="white", edge.color = rainbow(3)[3],vertex.size = 10 ,main = "shared groundtruth")

  plot.igraph(exampleDataGraph[[2]],layout = layout,vertex.label.font=2,
              vertex.shape="none",
              vertex.label.color="gray40",
              vertex.label.cex=.7, vertex.frame.color="white", edge.color = rainbow(3)[1], vertex.size = 10 , main = "task 1 specific groundtruth")

  plot.igraph(exampleDataGraph[[3]],layout = layout,vertex.label.font=2,
              vertex.shape="none",
              vertex.label.color="gray40",
              vertex.label.cex=.7, vertex.frame.color="white", edge.color = rainbow(3)[2], vertex.size = 10 , main = "task 2 specific groundtruth")
}

readline(prompt="Press [enter] to view plots zooming into node 6 and 8 in different graphs")

nodeid = c(6,8) ### node id
par(mfrow=c(2,2))

{
  plot.fasjem(result,  graphlabel = label, type="neighbour", index = nodeid, graphlayout = layout)

  plot.fasjem(result,  graphlabel = label, type="neighbour", subID = 0, index = nodeid, graphlayout = layout)

  plot.fasjem(result, graphlabel = label, type="neighbour", neighbouroption = "taskspecific",
              subID=1, index = nodeid,
              graphlayout = layout)

  plot.fasjem(result, graphlabel = label, type="neighbour", neighbouroption = "taskspecific",
              subID=2, index = nodeid,
              graphlayout = layout)
}

### it is also possible to zoom into multiple nodes on multiple graphs specified by input

