compare_time = function(curr_l, curr_u, proposed) {
  equal_l = isTRUE(all.equal(as.numeric(curr_l), proposed))
  equal_l = equal_l || (curr_l < proposed)
  equal_u = isTRUE(all.equal(as.numeric(curr_u), proposed))
  equal_u = equal_u || (curr_u > proposed)
  return(equal_l && equal_u)
}

discretise = function(dd, tstep) {
  time = tstep
  dd_dis = matrix(0, ncol=ncol(dd), nrow=max(dd[,1])/tstep+1)#time = ,]
  dd_dis[1,] = dd[1,]
  colnames(dd_dis) = colnames(dd)
  j = 2
  for(i in 1:(nrow(dd)-1)) {
    while(compare_time(dd[i,1], dd[i+1, 1], time)) {
      dd_dis[j,] = c(time, dd[i, 2:ncol(dd)])
      time = time + tstep
      j = j + 1
    }
  }
  return(dd_dis)
}




