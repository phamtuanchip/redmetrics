# Plan #

Está página refleja los puntos claves que van a usarse para desarrollar el proyecto.

## Objetivo ##

El Objetivo de este proyecto es la creación de un plugin para RedMine que permita obtener métricas de los proyectos. Concretamente, métricas sobre los esfuerzos, costes y tiempos de desarrollo.

## Alcance ##

A nivel de proyectos las dimensiones a tener en cuenta:

  * Esfuerzo
  * Tiempo
  * Coste

Cada dimensión tendrá información sobre:

  * Incurrido
  * Restante

Por tanto, la información a tratar girará en torno a:

| **Dimensiones** | **Incurrido** | **Restante** |
|:----------------|:--------------|:-------------|
| Esfuerzo | Horas invertidas por los participantes en el proyecto | Número de horas previstas para la finalización del proyecto |
| Tiempo | Tiempo invertido en la realización del proyecto | Tiempo restante previsto para la finalización del proyecto |
| Coste | Gastos materiales y humanos realizados a lo largo del proyecto | Gastos restantes previstos para terminar el proyecto |


Además, se deberá recoger la previsión inicial de esfuerzo, tiempo y coste para poder comparar en todo momento la diferencia de lo inicial con lo actualmente previsto, es decir, la desviación del proyecto.

Todo ello se traducirá en la realización de:
  * Un sistema que permita recoger la información de previsión inicial del proyecto.
  * Un sistema que permita actualizar la información referente al esfuerzo, tiempo o coste restante.
  * Un sistema que permita visualizar las métricas generadas: desviaciones, incurrido, restante, ...

## Calendario ##

El proyecto ha comenzado en marzo del 2011 y tiene como fecha objetivo la liberación de una primera versión estable en junio del 2011.

## Entregables ##

Los tres componentes destacables del proyecto serán:
- El código del proyecto.
- El manual de instalación.
- El manual de uso.

## Puntos abiertos ##

  * La previsión de esfuerzo para un proyecto es una tarea compleja, para facilitar la estimación, debe facilitarse algún sistema que ayude al usuario. Por ejemplo, en vez de dar un número total, se le puede presentar un conjunto de conceptos (más fáciles de estimar), de esta forma, el usuario en vez de dar un total, rellena unas estimaciones parciales y el total se calcula automáticamente. Algunos paradigmas para realizar la estimación:
    * Horas restantes de cada perfil que va a participar en el proyecto (jefe de proyecto|analista|programador|...).
    * Horas restantes de cada persona (un usuario).
    * Horas restantes en función de los componentes (WBS) del proyecto.
  * Hay una gran cantidad de métricas a presentar por lo que debe cuidarse cómo se presentan dichos resultados al usuario.