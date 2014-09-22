from flask import Flask
from flask.ext import restful

app = Flask(__name__)
api = restful.Api(app)


class ItemList(restful.Resource):
    def get(self):
        return {'example': 10}

api.add_resource(ItemList, '/items')

if __name__ == '__main__':
    app.run(debug=True)
