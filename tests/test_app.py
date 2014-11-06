from app import app

import json
import unittest


class FlaskTestCase(unittest.TestCase):
    def test_sum(self):
        tester = app.test_client(self)
        response = tester.get('/items', content_type='application/json')
        self.assertEqual(response.status_code, 200)
        self.assertEqual(json.loads(response.data), {"hello": "world"})
