# Crear nuevo proyecto biblioteca con stack
stack new biblioteca

# Agregar en package.yaml
dependencies:
- base >= 4.7 && < 5
- containers
- regex-posix
- csv

# Si el proyecto ya esta creado, ejecutar:
stack build
stack exec biblioteca-exe

o tambien:
stack build; stack exec biblioteca-exe