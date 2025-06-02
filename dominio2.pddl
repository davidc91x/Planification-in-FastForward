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
        (usado ?pl - plato)
        (dia-siguiente ?d1 - dia ?d2 - dia)
        (bloqueado ?d - dia ?p - plato)
    )
    (:action addprimero
        :parameters (?d - dia ?p - primero)
        :precondition (and
                        (not (usado ?p))
                        (not (ocupado-primero ?d))
                        (not (bloqueado ?d ?p))

                        (or
                            (not (ocupado-segundo ?d))
                            (exists (?s - segundo) (and (segundoasignado ?d ?s)
                                                        (not (incompatibles ?p ?s)))
                            )
                        )
                      )
        :effect (and
                    (primeroasignado ?d ?p)
                    (ocupado-primero ?d)
                    (usado ?p)
                )
    )

    (:action deleteprimero
        :parameters (?d - dia ?p - primero)
        :precondition (and
                        (ocupado-primero ?d)
                        (primeroasignado ?d ?p))
        :effect (and
                    (not (ocupado-primero ?d))
                    (not (primeroasignado ?d ?p))
                    (not (usado ?p))
                    (bloqueado ?d ?p)
                )
                        
    )

    (:action addsegundo
        :parameters (?d - dia ?s - segundo)
        :precondition (and
                        (not (usado ?s))
                        (not (ocupado-segundo ?d))
                        (or
                            (not (ocupado-primero ?d))
                            (exists (?p - primero) (and (primeroasignado ?d ?p)
                                                        (not (incompatibles ?p ?s)))
                            )

                        )
                      )
        :effect (and
                    (segundoasignado ?d ?s)
                    (ocupado-segundo ?d)
                    (usado ?s)

                )
    )

)
