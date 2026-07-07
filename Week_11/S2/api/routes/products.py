from flask import Blueprint, jsonify, request, abort

products_bp = Blueprint('products', __name__, url_prefix='/api/v1')

# In-memory store
products = {}
next_id = 1


# GET all products
@products_bp.route('/products', methods=['GET'])
def get_products():
    return jsonify({'data': list(products.values()), 'count': len(products)}), 200


# GET single product
@products_bp.route('/products/<int:product_id>', methods=['GET'])
def get_product(product_id):
    product = products.get(product_id)
    if not product:
        abort(404, description=f'Product {product_id} not found')
    return jsonify({'data': product}), 200


# POST create product
@products_bp.route('/products', methods=['POST'])
def create_product():
    global next_id
    body = request.get_json(force=True)
    if not body or 'name' not in body:
        abort(400, description='Field "name" is required')
    product = {'id': next_id, 'name': body['name'], 'price': body.get('price', 0.0)}
    products[next_id] = product
    next_id += 1
    return jsonify({'data': product}), 201


# PUT update product
@products_bp.route('/products/<int:product_id>', methods=['PUT'])
def update_product(product_id):
    if product_id not in products:
        abort(404)
    body = request.get_json(force=True)
    products[product_id].update({'name': body.get('name'), 'price':
        body.get('price')})
    return jsonify({'data': products[product_id]}), 200


# DELETE product
@products_bp.route('/products/<int:product_id>', methods=['DELETE'])
def delete_product(product_id):
    if product_id not in products:
        abort(404)
    del products[product_id]
    return '', 204