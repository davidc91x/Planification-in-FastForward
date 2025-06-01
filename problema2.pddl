(define (problem problema2)
  (:domain dominio2)

  (:objects
    lunes martes miercoles jueves viernes - dia
    sopa crema ensalada - primero
    pollo carne pescado - segundo
    sopa_tipo crema_tipo ensalada_tipo carne_tipo pescado_tipo - tipo
    e5 e7 e10 e15 - euros
    k300 k400 k500 k700 - kcal
  )

  (:init
    ;; Tipos de platos
    (platodetipo sopa sopa_tipo)
    (platodetipo crema crema_tipo)
    (platodetipo ensalada ensalada_tipo)
    (platodetipo pollo pescado_tipo)
    (platodetipo carne carne_tipo)
    (platodetipo pescado pescado_tipo)

    ;; Incompatibilidades
    (incompatibles sopa pollo)

    ;; Precio (como predicado, aunque lo ideal son fluents)
    (precio sopa e5)
    (precio crema e7)
    (precio ensalada e10)
    (precio pollo e15)
    (precio carne e10)
    (precio pescado e15)

    ;; Calorías (igual que precio)
    (calorias sopa k300)
    (calorias crema k400)
    (calorias ensalada k300)
    (calorias pollo k700)
    (calorias carne k500)
    (calorias pescado k400)
  )

  (:goal (and
  (ocupado-primero lunes)
  (ocupado-segundo lunes)

  (ocupado-primero martes)
  (ocupado-segundo martes)

  (ocupado-primero miercoles)
  (ocupado-segundo miercoles)

  (ocupado-primero jueves)
  (ocupado-segundo jueves)

  (ocupado-primero viernes)
  (ocupado-segundo viernes)
))
)
