#' @title A mechanism for creating a stochastic kinetic model (skm)
#' @param stoic the stoichiometric of the skm model. The number of rows should equal the number
#' of species and the number of columns should equal the number of reactions.
#' @param hazards a function for calculating the hazards.
#' @param initial a vector containing the initial conditions of the model.
#' @param pars a vector containing the parameter vector
#' @param jacobian only needed when simulating from the linear noise approximation
#' @author Colin Gillespie
#' @return A list with class skm
#' @keywords character
#' @export
#' @example ../examples/lv.R

create_model = function(stoic, hazards, initial, pars, jacobian=NULL) {
    initial = initial
    pars = pars
    f = jacobian
    get_stoic = function() stoic
    get_haz = function(x, p=pars)  hazards(x, p)
    get_pars = function(p=pars)  p
    get_initial = function(i = initial) i
    get_f = function(f = jacobian) f
    m =list(get_stoic = get_stoic, get_haz=get_haz, 
            get_pars=get_pars, get_initial=get_initial, 
            get_f = joobian)
    class(m) = "skm"
    return(m)
}


# summary.skm = function(m, ...) {
#     
# }