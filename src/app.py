import os

from bson.json_util import dumps
from flask import Flask
from flask import make_response
from flask.ext import restful
from flask.ext.pymongo import PyMongo

MONGO_URL = os.getenv('SQ1_MONGO_URL')


app = Flask(__name__)
app.config['MONGO_URI'] = os.getenv('SQ1_MONGO_URI')

mongo = PyMongo(app)


def output_json(obj, code, headers=None):
    resp = make_response(dumps(obj), code)
    resp.headers.extend(headers or {})
    return resp

DEFAULT_REPRESENTATIONS = {'application/json': output_json}
api = restful.Api(app)
api.representations = DEFAULT_REPRESENTATIONS


class ItemList(restful.Resource):
    def get(self):
        return [x for x in mongo.db.inventory.find()]

api.add_resource(ItemList, '/items')

if __name__ == '__main__':
    if os.getenv('SQ1_ENV') == 'dev':
        app.debug = True
    app.run()
