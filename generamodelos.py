import random

# === Platos reales con tipo ===
primeros = [
    ("ensalada_rusa", "verdura"), ("gazpacho", "sopa"), ("crema_calabaza", "sopa"),
    ("espaguetis", "pasta"), ("macarrones", "pasta"), ("ensalada_queso", "verdura"),
    ("menestra", "verdura"), ("lentejas", "legumbre"), ("garbanzos", "legumbre"),
    ("judias_verdes", "legumbre"), ("sopa_pollo", "sopa"), ("crema_verduras", "sopa"),
    ("pasta_pesto", "pasta"), ("pasta_carbonara", "pasta"), ("brocoli_hervido", "verdura"),
    ("sopa_marisco", "sopa"), ("cuscus", "pasta"), ("hummus", "legumbre"),
    ("tomate_aliñado", "verdura"), ("pure_patata", "verdura"), ("espinacas", "verdura"),
    ("pisto", "verdura"), ("fideos_chinos", "pasta"), ("sopa_cebolla", "sopa"),
    ("ensalada_garbanzos", "legumbre"), ("pasta_vegetal", "pasta"), ("ensalada_verde", "verdura"),
    ("crema_champi", "sopa"), ("risotto", "pasta"), ("tabbouleh", "verdura")
]

segundos = [
    ("pollo_asado", "carne"), ("ternera_guisada", "carne"), ("lomo", "carne"),
    ("tortilla_patata", "huevo"), ("huevo_duro", "huevo"), ("merluza_plancha", "pescado"),
    ("salmon_horno", "pescado"), ("atun", "pescado"), ("albondigas", "carne"),
    ("hamburguesa", "carne"), ("huevo_relleno", "huevo"), ("revuelto_esparragos", "huevo"),
    ("filete_cerdo", "carne"), ("pechuga_plancha", "carne"), ("croquetas", "carne"),
    ("tortilla_francesa", "huevo"), ("pavo_horno", "carne"), ("lubina", "pescado"),
    ("calamares", "pescado"), ("sepia", "pescado"), ("huevos_rotos", "huevo"),
    ("entrecot", "carne"), ("filete_pollo", "carne"), ("huevo_frito", "huevo"),
    ("bacalao", "pescado"), ("tortilla_espinacas", "huevo"), ("muslos_pollo", "carne"),
    ("nuggets", "carne"), ("pescadilla", "pescado"), ("tortilla_jamon", "huevo")
]

dias = ["lunes", "martes", "miercoles", "jueves", "viernes"]

def generar_pddl(nombre_archivo="problema_generado.pddl"):
    primeros_sel = random.sample(primeros, 10)
    segundos_sel = random.sample(segundos, 10)

    tipos = sorted(set(t for _, t in primeros_sel + segundos_sel))

    primeros_str = " ".join(p for p, _ in primeros_sel)
    segundos_str = " ".join(s for s, _ in segundos_sel)
    tipos_str = " ".join(tipos)
    dias_str = " ".join(dias)

    dia_siguiente = "\n    ".join(f"(dia-siguiente {dias[i]} {dias[i+1]})" for i in range(len(dias)-1))
    platodetipo = "\n    ".join(f"(platodetipo {p} {t})" for p, t in primeros_sel + segundos_sel)
    precios_calorias = "\n    ".join(
        f"(= (precio {p}) {random.randint(5, 20)})\n    (= (calorias {p}) {random.randint(200, 900)})"
        for p, _ in primeros_sel + segundos_sel
    )
    calorias_dias = "\n    ".join(f"(= (caloriasdia {d}) 0)" for d in dias)

    pddl = f"""(define (problem problema2)
  (:domain dominio2)

  (:objects
    ;; Días
    {dias_str} - dia

    ;; Primeros platos
    {primeros_str} - primero

    ;; Segundos platos
    {segundos_str} - segundo

    ;; Tipos de comida
    {tipos_str} - tipo

    ;; Costes
  )

  (:init
    ;; Días seguidos
    {dia_siguiente}
    ;; Tipos para primeros y segundos
    {platodetipo}

    ;; Precios
    {precios_calorias}

    ;; Inicializar el precio acumulado por día
    (= (preciomenu) 0)

    ;; Calorías
    {calorias_dias}
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
)"""

    with open(nombre_archivo, "w") as f:
        f.write(pddl)
    print(pddl)
# Ejecuta una vez
generar_pddl()
