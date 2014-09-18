import os

from flask import Flask


app = Flask(__name__)


@app.route('/')
def view_items():
    """show list of items"""
    return 'item 1'

if __name__ == '__main__':
    if os.environ.get('ENVIRONMENT') == 'development':
        app.debug = True
    app.run()
