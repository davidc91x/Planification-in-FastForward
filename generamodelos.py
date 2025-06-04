import random

# === Platos reales con tipo ===
primeros = [
    ("ensalada_rusa", "verdura"), ("gazpacho", "sopa"), ("crema_calabaza", "sopa"),
    ("espaguetis", "pasta"), ("macarrones", "pasta"), ("ensalada_queso", "verdura"),
    ("menestra", "verdura"), ("lentejas", "legumbre"), ("garbanzos", "legumbre"),
    ("judias_verdes", "legumbre"), ("sopa_pollo", "sopa"), ("crema_verduras", "sopa"),
    ("pasta_pesto", "pasta"), ("pasta_carbonara", "pasta"), ("brocoli_hervido", "verdura"),
    ("sopa_marisco", "sopa"), ("cuscus", "pasta"), ("hummus", "legumbre"),
    ("tomate_alinado", "verdura"), ("pure_patata", "verdura"), ("espinacas", "verdura"),
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

def generar_pddl(numprimeros,numsegundos,modelo,nombre_archivo="problema_generado.pddl"):
    primeros_sel = random.sample(primeros, numprimeros)
    segundos_sel = random.sample(segundos, numsegundos)

    tipos = sorted(set(t for _, t in primeros_sel + segundos_sel))

    primeros_str = " ".join(p for p, _ in primeros_sel)
    segundos_str = " ".join(s for s, _ in segundos_sel)
    tipos_str = " ".join(tipos)
    dias_str = " ".join(dias)

    dia_siguiente = "\n    ".join(f"(dia-siguiente {dias[i]} {dias[i+1]})" for i in range(len(dias)-1))
    platodetipo = "\n    ".join(f"(platodetipo {p} {t})" for p, t in primeros_sel + segundos_sel)
    precios = ""
    calorias = ""
    if modelo > 4:
        precios = "\n    ".join(f"(= (precio {p}) {random.randint(5, 20)})" for p, _ in primeros_sel + segundos_sel)
    if modelo > 3:
        calorias = "\n    ".join(f"(= (calorias {p}) {random.randint(200, 900)})" for p, _ in primeros_sel + segundos_sel)

    calorias_dias = "\n    ".join(f"(= (calorias-dia {d}) 0)" for d in dias)

    num_incomp = random.randint(1, 4)
    incompatibles = set()
    while len(incompatibles) < num_incomp:
        pri = random.choice(primeros_sel)[0]
        seg = random.choice(segundos_sel)[0]
        if (pri, seg) not in incompatibles:
            incompatibles.add((pri, seg))
    incompatibles_str = "\n    " + "\n    ".join(f"(incompatibles {p} {s})" for p, s in incompatibles) if incompatibles else ""

    obligatorios_str = ""
    if modelo > 2:
        num_obl = random.randint(1, 4)
        dias_disp = dias[:]
        random.shuffle(dias_disp)
        usados_prim = set()
        usados_seg = set()
        obligatorios = []
        platos_calorias = {p[0]: random.randint(200, 900) for p in primeros_sel + segundos_sel}
        incompatibles_set = set(incompatibles)  # Usa esto si ya los generaste antes

        for d in dias_disp:
            if len(obligatorios) >= num_obl:
                break

            candidatos_prim = [p for p in primeros_sel if p[0] not in usados_prim]
            candidatos_seg = [s for s in segundos_sel if s[0] not in usados_seg]

            opcion = random.choice(["primero", "segundo", "ambos"])
            dia_usado = False

            if opcion == "ambos" and candidatos_prim and candidatos_seg:
                random.shuffle(candidatos_prim)
                random.shuffle(candidatos_seg)
                for p in candidatos_prim:
                    for s in candidatos_seg:
                        p_nombre, s_nombre = p[0], s[0]
                        if (p_nombre, s_nombre) not in incompatibles_set:
                            total_cal = platos_calorias[p_nombre] + platos_calorias[s_nombre]
                            if 1000 <= total_cal <= 1500:
                                obligatorios.append((d, p_nombre))
                                obligatorios.append((d, s_nombre))
                                usados_prim.add(p_nombre)
                                usados_seg.add(s_nombre)
                                dia_usado = True
                                break
                    if dia_usado:
                        break

            if not dia_usado:
                if opcion in ["primero", "ambos"] and candidatos_prim:
                    p = random.choice(candidatos_prim)[0]
                    obligatorios.append((d, p))
                    usados_prim.add(p)
                elif opcion in ["segundo", "ambos"] and candidatos_seg:
                    s = random.choice(candidatos_seg)[0]
                    obligatorios.append((d, s))
                    usados_seg.add(s)

            if len(obligatorios) >= num_obl:
                break

        if obligatorios:
            obligatorios_str = "\n    " + "\n    ".join(f"(obligatorio {d} {p})" for d, p in obligatorios)

    pddl = f"""(define (problem problema)
  (:domain dominio)

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
    {precios}

    {calorias}

    ;; Inicializar el precio acumulado por día
    (= (precio-total) 0)

    ;; Calorías
    {calorias_dias}

    {incompatibles_str}
    
    {obligatorios_str}
  )

  (:goal
    (forall (?d - dia)
      (and
        (ocupado-primero ?d)
        (ocupado-segundo ?d)
      )
    )
  )

  (:metric minimize (precio-total))
)"""

    with open(nombre_archivo, "w") as f:
        f.write(pddl)
#Genera 2 versiones para cada uno d elos seis modelos
print("cuantos primeros?")
pr=input()
print("cuantos segundos?")
sg=input()
for i in range(6):
    nombre=f"problema{i}.1.pddl"
    nombre2=f"problema{i}.2.pddl"
    generar_pddl(pr,sg,i,nombre)
    generar_pddl(pr,sg,i,nombre2)
