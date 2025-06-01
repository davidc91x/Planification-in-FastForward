(define (domain dominio2)
    (:requirements :adl :typing)
    (:types dia plato primero - plato segundo - plato tipo euros kcal)
    (:predicates
        (platodetipo ?pl - plato ?t - tipo)
        (incompatibles ?p - primero ?s - segundo)
        (precio ?pl - plato ?e - euros)
        (calorias ?pl - plato ?k - kcal)
        (ocupado-primero ?d - dia)
        (ocupado-segundo ?d - dia)
        (primeroasignado ?d - dia ?p - primero)
        (segundoasignado ?d - dia ?p - segundo)
    )
    (:action addprimero
        :parameters (?d - dia ?p - primero)
        :precondition (and
                        (not (ocupado-primero ?d))
                        (or
                            (and (not (ocupado-segundo ?d))
                                 (exists (?s - segundo) (not (incompatibles ?p ?s))))
                            (exists (?s - segundo) (and (segundoasignado ?d ?s)
                                                        (not (incompatibles ?p ?s)))
                            )
                        )
                      )
        :effect (and
                    (primeroasignado ?d ?p)
                    (ocupado-primero ?d)
                )
    )



    (:action addsegundo
        :parameters (?d - dia ?s - segundo)
        :precondition (and
                        (not (ocupado-segundo ?d))
                        (or
                            (and (not (ocupado-primero ?d))
                                 (exists (?p - primero) (not (incompatibles ?p ?s))))
                            (exists (?p - primero) (and (primeroasignado ?d ?p)
                                                        (not (incompatibles ?p ?s)))
                            )

                        )
                      )
        :effect (and
                    (segundoasignado ?d ?s)
                    (ocupado-segundo ?d)
                )
    )

)
