(define (problem problema2)
  (:domain dominio2)

  (:objects
    ;; Días
    lunes martes miercoles jueves viernes - dia

    ;; Primeros platos
    ensalada_rusa espinacas lentejas sopa_marisco pasta_vegetal - primero

    ;; Segundos platos
    entrecot hamburguesa merluza salmon albondigas - segundo

    ;; Tipos de comida
    verdura legumbre sopa pasta carne pescado - tipo

    ;; Costes
    e5 e7 e10 e12 e15 - euros

    ;; Calorías
    k300 k350 k400 k500 k700 - kcal
  )

  (:init
    ;; Días seguidos
    (dia-siguiente lunes martes)
    (dia-siguiente martes miercoles)
    (dia-siguiente miercoles jueves)
    (dia-siguiente jueves viernes)
    ;; Tipos para primeros
    (platodetipo ensalada_rusa verdura)
    (platodetipo espinacas verdura)
    (platodetipo lentejas legumbre)
    (platodetipo sopa_marisco sopa)
    (platodetipo pasta_vegetal pasta)

    ;; Tipos para segundos
    (platodetipo entrecot carne)
    (platodetipo hamburguesa carne)
    (platodetipo merluza pescado)
    (platodetipo salmon pescado)
    (platodetipo albondigas carne)

    ;; Incompatibilidades
    (incompatibles sopa_marisco salmon)
    (incompatibles lentejas albondigas)
    (incompatibles ensalada_rusa entrecot)


    ;; Obligaciones
    (obligatorio lunes lentejas)
    ;; (obligatorio miercoles hamburguesa)

    ;; Precios
    (precio ensalada_rusa e7)
    (precio espinacas e5)
    (precio lentejas e10)
    (precio sopa_marisco e12)
    (precio pasta_vegetal e10)

    (precio entrecot e15)
    (precio hamburguesa e12)
    (precio merluza e12)
    (precio salmon e15)
    (precio albondigas e10)

    ;; Calorías
    (calorias ensalada_rusa k300)
    (calorias espinacas k300)
    (calorias lentejas k500)
    (calorias sopa_marisco k400)
    (calorias pasta_vegetal k400)

    (calorias entrecot k700)
    (calorias hamburguesa k700)
    (calorias merluza k400)
    (calorias salmon k400)
    (calorias albondigas k500)
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
