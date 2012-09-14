##Get stoichiometry matrix for LV
get_stoich = function()
{
  smat = matrix(0,nrow=2,ncol=3)
  smat[1,1] = 1
  smat[1,2] = -1
  smat[2,2] = 1
  smat[2,3] = -1
  rownames(smat) = c("Prey", "Predator")
  return(smat)
}


##Get vector of hazards for LV
get_haz = function(x, cvec)
{
  h = numeric(length(cvec))
  h[1] = cvec[1]*x[1]
  h[2] = cvec[2]*x[1]*x[2]
  h[3] = cvec[3]*x[2]
  return(h)
}
