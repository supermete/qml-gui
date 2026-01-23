import sys
import os

from PySide6.QtGui import QGuiApplication
from PySide6.QtQml import QQmlApplicationEngine
from model.todoModel import TodoModel, Todo, ProxyTodoModel

if __name__ == "__main__":
    app = QGuiApplication(sys.argv)
    engine = QQmlApplicationEngine()

    todoModel = TodoModel([
        Todo("Faire les courses", True), 
        Todo("Finir de lire Modern GUI", True),
        Todo("Appeler maman"),
        Todo("Faire déclaration d'impôts"),
        Todo("Envoyer candidature à la NASA"),
        Todo("Finir la machine à remonter le temps"),
        Todo("Préparer la finale de Call Of Doodie"),
        ])
    
    proxy_model_incomplete_tasks = ProxyTodoModel(False)
    proxy_model_complete_tasks = ProxyTodoModel(True)
    proxy_model_complete_tasks.setSourceModel(todoModel)
    proxy_model_incomplete_tasks.setSourceModel(todoModel)
    engine.rootContext().setContextProperty("todoModel", todoModel)
    engine.rootContext().setContextProperty("proxyModelCompleteTasks", proxy_model_complete_tasks)
    engine.rootContext().setContextProperty("proxyModelIncompleteTasks", proxy_model_incomplete_tasks)
    engine.load(os.path.join(os.path.dirname(__file__), "qml/main.qml"))

    if not engine.rootObjects():
        sys.exit(-1)
    sys.exit(app.exec())
