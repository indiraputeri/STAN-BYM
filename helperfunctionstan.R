#Learning mitzimorris Code to Map NYTracts Data
#Source: https://mc-stan.org/users/documentation/case-studies/icar_stan.html
#github source: stan-dev/example-models/knitr/car-iar-poisson
#a helper function mungeCARdata4stan which can transform the fields
#data$adj and data$num into a list structure with fields N, N_edges, node1, and node2
#which correspond to the inputs required by the Stan model.

mungeCARdata4stan = function(adjBUGS,numBUGS) {
  N = length(numBUGS);
  nn = numBUGS;
  N_edges = length(adjBUGS) / 2;
  node1 = vector(mode="numeric", length=N_edges);
  node2 = vector(mode="numeric", length=N_edges);
  iAdj = 0;
  iEdge = 0;
  for (i in 1:N) {
    for (j in 1:nn[i]) {
      iAdj = iAdj + 1;
      if (i < adjBUGS[iAdj]) {
        iEdge = iEdge + 1;
        node1[iEdge] = i;
        node2[iEdge] = adjBUGS[iAdj];
      }
    }
  }
  return (list("N"=N,"N_edges"=N_edges,"node1"=node1,"node2"=node2));
}
