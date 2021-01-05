# https://www.digitalocean.com/community/tutorials/how-to-serve-flask-applications-with-uswgi-and-nginx-on-ubuntu-18-04

import os
from flask import Flask, request, jsonify
# from flask_api import FlaskAPI
from flask_cors import CORS

from config.database import session
from models import Product, VendorProductAssociation
from models.types import ProductType

app = Flask(__name__)
CORS(app)


@app.route("/get", methods=["GET"])
def get():
    if request.method == "GET":
        product_id = int(request.args.get("id"))
        product = session.query(Product).get(product_id)
        pvs = session.query(VendorProductAssociation).filter(
            VendorProductAssociation.product_id == product_id
        )
        return jsonify(dict(
            name=product.name,
            img_url=product.img_url,
            vendors=[
                dict(
                    name=pv.vendor.name,
                    vendor_url=pv.vendor.url,
                    product_url=pv.url,
                    price=pv.price,
                    in_stock=pv.in_stock
                ) for pv in pvs
            ]
        ))

@app.route("/search", methods=["GET", "POST"])
def search():
    if request.method == "GET":
        category = request.args.get("category")
        query = request.args.get("query")
        search = f"%{query}%"
        products = session.query(Product).filter(
            Product.name.ilike(search),
            Product.type == ProductType[category]
        )
        pvs = session.query(VendorProductAssociation).filter(
            VendorProductAssociation.product_id.in_([p.id for p in products])
        )
        return jsonify([dict(
            id=pv.product.id,
            name=pv.product.name,
            img_url=pv.product.img_url,
            in_stock=pv.in_stock,
            price=pv.price,
            vendor=dict(name=pv.vendor.name, url=pv.vendor.url)
        ) for pv in pvs])
    
@app.route('/')
def index():
    return "<h1>KBPARTPICKER TOWN!!</h1>"

if __name__ == "__main__":
    # app.run(debug=True)
    app.run(threaded=True, port=5000)