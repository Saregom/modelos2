from fastapi import FastAPI, HTTPException
from pydantic import BaseModel

app = FastAPI()

# uso de pydantic para introducir datos en el body
class Tasks(BaseModel):
    tarea: str
    fecha: str

task_list = [
    {"id": 1, "tarea": 'Hacer trabajo de api rest', "fecha": "2024-09-21"},
    {"id": 2, "tarea": "Ir a misa y rezar por un 5.0 en modelos 2", "fecha": "2024-09-22"},
    {"id": 2, "tarea": "Hacer paro en la 40", "fecha": "2024-09-23"}
]
@app.get("/tasks")
def get_tasks():
    return task_list

@app.post("/tasks")
def add_tasks(tasks: Tasks):
    new_task = tasks.model_dump() # para convertir los datos a 
    new_task["id"] = len(task_list) + 1  # generacion de id automatico
    task_list.append(new_task)
    return new_task

@app.delete("/tasks/{id}")
def delete_tasks(id: int):
    for tasks in task_list:
        if tasks["id"] == id:
            task_list.remove(tasks)
            return {"mensaje": f"La tarea: {tasks['tarea']}, con id:{id}, fue eliminada correctamente"}
    
    raise HTTPException(status_code=404, detail="Tarea no encontrada")
