(define (domain dominio)
    (:requirements :adl :typing)
    (:types dia plato primero - plato segundo - plato tipo euros kcal)
    (:predicates
        (platodetipo ?pl - plato ?t - tipo)
        (incompatibles ?p - primero ?s - segundo)
        (precio ?pl - plato ?e - euros)
        (calorias ?pl - plato ?k - kcal)
        (menu ?d - dia ?p - primero ?s - segundo)
        (primeroasignado ?d - dia ?p - primero)
    )
    (:action addprimero
        :parameters (?d - dia ?p - primero)
        :effect (primeroasignado ?d ?p)
    )
    (:action addsegundo
        :parameters (?d - dia ?p - primero ?s - segundo)
        :precondition (and
                        (primeroasignado ?d ?p)
                        (not (incompatibles ?p ?s))
                      )
        :effect (menu ?d ?p ?s)
    )
)
