(define (problem problema2)
  (:domain dominio2)

  (:objects
    ;; Días
    lunes martes miercoles jueves viernes - dia

    ;; Primeros platos
    ensalada_rusa espinacas lentejas sopa_marisco pasta_vegetal - primero

    ;; Segundos platos
    entrecot tortilla merluza salmon albondigas - segundo

    ;; Tipos de comida
    verdura verdur legumbre sopa pasta huevo carne pescado - tipo

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
    (platodetipo tortilla huevo)
    (platodetipo merluza pescado)
    (platodetipo salmon pescado)
    (platodetipo albondigas carne)

    ;; Incompatibilidades
    (incompatibles sopa_marisco salmon)
    ;;(incompatibles lentejas albondigas)
    ;;(incompatibles ensalada_rusa entrecot)


    ;; Obligaciones
    (obligatorio lunes lentejas)
    ;; (obligatorio miercoles tortilla)

    ;; Precios
    (precio ensalada_rusa e7)
    (precio espinacas e5)
    (precio lentejas e10)
    (precio sopa_marisco e12)
    (precio pasta_vegetal e10)

    (precio entrecot e15)
    (precio tortilla e12)
    (precio merluza e12)
    (precio salmon e15)
    (precio albondigas e10)

    ;; Calorías
;; Calorías de primeros
(= (calorias ensalada_rusa) 300)
(= (calorias espinacas) 300)
(= (calorias lentejas) 500)
(= (calorias sopa_marisco) 700)
(= (calorias pasta_vegetal) 600)

;; Calorías de segundos
(= (calorias entrecot) 700)
(= (calorias tortilla) 700)
(= (calorias merluza) 400)
(= (calorias salmon) 400)
(= (calorias albondigas) 500)


(= (calorias-dia lunes) 0)
(= (calorias-dia martes) 0)
(= (calorias-dia miercoles) 0)
(= (calorias-dia jueves) 0)
(= (calorias-dia viernes) 0)

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

    (>= (calorias-dia lunes) 1000)
    (<= (calorias-dia lunes) 1500)
    (>= (calorias-dia martes) 1000)
    (<= (calorias-dia martes) 1500)
    (>= (calorias-dia miercoles) 1000)
    (<= (calorias-dia miercoles) 1500)
    (>= (calorias-dia jueves) 1000)
    (<= (calorias-dia jueves) 1500)
    (>= (calorias-dia viernes) 1000)
    (<= (calorias-dia viernes) 1500)

  ))
)
