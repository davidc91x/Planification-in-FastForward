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
    (= (precio ensalada_rusa) 7)
(= (precio espinacas) 5)
(= (precio lentejas) 10)
(= (precio sopa_marisco) 12)
(= (precio pasta_vegetal) 10)

(= (precio entrecot) 15)
(= (precio tortilla) 12)
(= (precio merluza) 12)
(= (precio salmon) 15)
(= (precio albondigas) 10)

;; Inicializar el precio acumulado por día
(= (preciomenu) 0)


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


(= (caloriasdia lunes) 0)
(= (caloriasdia martes) 0)
(= (caloriasdia miercoles) 0)
(= (caloriasdia jueves) 0)
(= (caloriasdia viernes) 0)

  )

  (:goal
    (forall (?d - dia)
      (and
        (ocupado-primero ?d)
        (ocupado-segundo ?d)
      )
    )
  )

  (:metric minimize (preciomenu))

)