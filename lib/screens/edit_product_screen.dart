import 'package:flutter/material.dart';
import '../providers/product.dart';

class EditProductScreen extends StatefulWidget {
  static const routeName = '/edit-product';

  @override
  _EditProductScreenState createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _priceFocusNode = FocusNode(); //goes textfield to textfield
  final _descriptionFocusNode = FocusNode();
  final _imageUrlController = TextEditingController();
  final _imageUrlFocusNode = FocusNode();
  final _form = GlobalKey<FormState>();
  var _editedProduct = Product(
      id: '',
      title: '',
      description: '',
      price: 0,
      imageUrl: 'imageUrl',
      isFavorite: false);

  @override
  void initState() {
    // TODO: implement initState
    _imageUrlFocusNode.addListener(_updateImageUrl);
    super.initState();
  }

  void _updateImageUrl() {
    if (!_imageUrlFocusNode.hasFocus) {
      if ((!_imageUrlController.text.startsWith('http') &&
          !_imageUrlController.text.startsWith('https')) ||
          (!_imageUrlController.text.endsWith('.png') &&
              !_imageUrlController.text.endsWith('.jpg') &&
              !_imageUrlController.text.endsWith('.jpeg'))) {
        return;
      }
      setState(() {});
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _imageUrlFocusNode.removeListener(_updateImageUrl);
    _priceFocusNode.dispose();
    _descriptionFocusNode.dispose();
    _imageUrlFocusNode.dispose();
    super.dispose();
  }

  void _saveForm() {
    final isValid = _form.currentState!.validate();
    if (!isValid) {
      return;
    }
    _form.currentState!.save();
    print(_editedProduct.title);
    print(_editedProduct.description);
    print(_editedProduct.price);
    print(_editedProduct.imageUrl);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Product'),
        actions: [
          IconButton(
            onPressed: _saveForm,
            icon: Icon(Icons.save),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _form,
          child: ListView(
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(labelText: 'Title'),
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_priceFocusNode);
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please provide a value';
                  } else {
                    return null;
                  }
                },
                onSaved: (value) {
                  _editedProduct = Product(
                      id: '',
                      title: value.toString(),
                      description: _editedProduct.description,
                      price: _editedProduct.price,
                      imageUrl: _editedProduct.imageUrl,
                      isFavorite: false);
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Price'),
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                focusNode: _priceFocusNode,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_descriptionFocusNode);
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please provide a price';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Please enter a valid number.';
                  }
                  if (double.parse(value) >= 0) {
                    return 'Please enter a number greater than zero.';
                  } else {
                    return null;
                  }
                },
                onSaved: (value) {
                  _editedProduct = Product(
                      id: '',
                      title: _editedProduct.title,
                      description: _editedProduct.description,
                      price: double.parse(value!),
                      imageUrl: _editedProduct.imageUrl,
                      isFavorite: false);
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Description'),
                maxLines: 3,
                keyboardType: TextInputType.multiline,
                focusNode: _descriptionFocusNode,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please provide a description';
                  }
                  if (value.length < 10) {
                    return 'Should be at least 10 characters long.';
                  } else {
                    return null;
                  }
                },
                onSaved: (value) {
                  _editedProduct = Product(
                      id: '',
                      title: _editedProduct.title,
                      description: value.toString(),
                      price: _editedProduct.price,
                      imageUrl: _editedProduct.imageUrl,
                      isFavorite: false);
                },
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Container(
                    width: 100,
                    height: 100,
                    margin: EdgeInsets.only(
                      top: 8,
                      right: 10,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 1,
                        color: Colors.grey,
                      ),
                    ),
                    child: _imageUrlController.text.isEmpty
                        ? Text('Enter a URL')
                        : FittedBox(
                            child: Image.network(
                              _imageUrlController.text,
                              fit: BoxFit.cover,
                            ),
                          ),
                  ),
                  Expanded(
                    child: TextFormField(
                        decoration: InputDecoration(labelText: 'Image URL'),
                        keyboardType: TextInputType.url,
                        textInputAction: TextInputAction.done,
                        controller: _imageUrlController,
                        focusNode: _imageUrlFocusNode,

                        onFieldSubmitted: (_) {
                          _saveForm();
                        },
                        onEditingComplete: () {
                          setState(() {});
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter an image URL.';
                          }
                          if (!value.startsWith('http') &&
                              !value.startsWith('https')) {
                            return 'Please enter a valid URL.';
                          }
                          if (!value.endsWith('.png') &&
                              !value.endsWith('.jpg') &&
                              !value.endsWith('.jpeg')) {
                            return 'Please enter a valid image URL.';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _editedProduct = Product(
                              id: '',
                              title: _editedProduct.title,
                              description: _editedProduct.description,
                              price: _editedProduct.price,
                              imageUrl: value.toString(),
                              isFavorite: false);
                        }),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
