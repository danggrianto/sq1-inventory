import os

from flask import Flask
from flask.ext import restful

app = Flask(__name__)
api = restful.Api(app)


class ItemList(restful.Resource):
    def get(self):
        return {'hello': 'world'}

api.add_resource(ItemList, '/items')

if __name__ == '__main__':
    if os.getenv('SQ1_ENV') == 'dev':
        app.debug = True
    app.run()
