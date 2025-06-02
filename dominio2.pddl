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
        (obligatorio ?d - dia ?p - plato)
    )
    (:action addprimero
        :parameters (?d - dia ?p - primero)
        :precondition (and
                        (not (ocupado-primero ?d))
                        (or
                            (not (exists (?p2 - primero)
                                (obligatorio ?d ?p2)))
                            (obligatorio ?d ?p)
                            )
                        (not (usado ?p))
                        (not (bloqueado ?d ?p))
                        (exists (?t - tipo)
                            (and 
                                (platodetipo ?p ?t)

                                (or
                                    (= ?d viernes)
                                    (exists (?d2 - dia ?p2 - primero)
                                        (and
                                            (dia-siguiente ?d ?d2)
                                            (or (not (ocupado-primero ?d2))
                                                (and 
                                                    (primeroasignado ?d2 ?p2)
                                                    (not (platodetipo ?p2 ?t))
                                                )
                                            )
                                        )
                                    )
                                )

                                (or
                                    (= ?d lunes)
                                    (exists (?d2 -dia ?p2 - primero)
                                        (and
                                            (dia-siguiente ?d2 ?d)
                                            (or (not (ocupado-primero ?d2))
                                                (and 
                                                    (primeroasignado ?d2 ?p2)
                                                    (not (platodetipo ?p2 ?t))
                                                )
                                            )
                                        )
                                    )
                                )

                            )
                        )  
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
                        (not (ocupado-segundo ?d))
                        (or
                            (not (exists (?s2 - segundo)
                                (obligatorio ?d ?s2)))
                            (obligatorio ?d ?s)
                            )
                        (not (usado ?s))
                        (not (bloqueado ?d ?s))
                        (exists (?t -tipo)
                            (and
                                (platodetipo ?s ?t)
                                
                                (or
                                    (= ?d viernes)
                                    (exists (?d2 -dia ?s2 - segundo)
                                        (and
                                            (dia-siguiente ?d ?d2)
                                            (or (not (ocupado-segundo ?d2))
                                                (and 
                                                    (segundoasignado ?d2 ?s2)
                                                    (not (platodetipo ?s2 ?t))
                                                )
                                            )
                                        )
                                    )
                                )

                                (or
                                    (= ?d lunes)
                                    (exists (?d2 -dia ?s2 - segundo)
                                        (and
                                            (dia-siguiente ?d2 ?d)
                                            (or (not (ocupado-segundo ?d2))
                                                (and 
                                                    (segundoasignado ?d2 ?s2)
                                                    (not (platodetipo ?s2 ?t))
                                                )
                                            )
                                        )
                                    )
                                )
                            )
                        )
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

    (:action deletesegundo
        :parameters (?d - dia ?s - segundo)
        :precondition (and
                        (ocupado-segundo ?d)
                        (segundoasignado ?d ?s))
        :effect (and
                    (not (ocupado-segundo ?d))
                    (not (segundoasignado ?d ?s))
                    (not (usado ?s))
                    (bloqueado ?d ?s)
                )
    )

)
