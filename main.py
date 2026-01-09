import sys
import os

from PySide6.QtGui import QGuiApplication
from PySide6.QtQml import QQmlApplicationEngine
from model.todoModel import TodoModel, Todo

if __name__ == "__main__":
    app = QGuiApplication(sys.argv)
    engine = QQmlApplicationEngine()

    todo_model = TodoModel([
        Todo("Faire les courses"), 
        Todo("Finir de lire Modern GUI"),
        Todo("Appeler maman"),
        Todo("Faire déclaration d'impôts"),
        Todo("Envoyer candidature à la NASA"),
        Todo("Finir la machine à remonter le temps"),
        Todo("Préparer la finale de Call Of Doodie"),
        ])
    engine.rootContext().setContextProperty("todoModel", todo_model)
    engine.load(os.path.join(os.path.dirname(__file__), "qml/main.qml"))

    if not engine.rootObjects():
        sys.exit(-1)
    sys.exit(app.exec())
