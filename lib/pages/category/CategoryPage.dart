import 'package:flutter/material.dart';
import 'package:pocketbase/pocketbase.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({super.key});
  
  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  final pb = PocketBase('http://127.0.0.1:8090'); // 修改为你的地址
  List<dynamic> mainCategories = [];
  List<dynamic> subCategories = [];
  String? selectedMainCategoryId;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadMainCategories();
  }

  Future<void> loadMainCategories() async {
    try {
      final records = await pb.collection('categories').getFullList(
        filter: 'id ~ "00000000000000"',
        sort: 'sort',
      );
      
      setState(() {
        mainCategories = records;
        isLoading = false;
        if (mainCategories.isNotEmpty) {
          selectedMainCategoryId = mainCategories[0].id;
          loadSubCategories(mainCategories[0].data['childIds']);
        }
      });
    } catch (e) {
      print('Error loading categories: $e');
      setState(() => isLoading = false);
    }
  }

  void loadSubCategories(List<dynamic> childIds) {
    setState(() {
      subCategories = mainCategories
          .where((cat) => childIds.contains(cat.id))
          .toList();
    });
  }

  String getImageUrl(dynamic record, String filename) {
    return '${pb.baseUrl}/api/files/${record.collectionId}/${record.id}/$filename';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'カテゴリ',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator(color: Colors.red))
          : Row(
              children: [
                // 左侧主分类列表
                Container(
                  width: 100,
                  color: Colors.grey[50],
                  child: ListView.builder(
                    itemCount: mainCategories.length,
                    itemBuilder: (context, index) {
                      final category = mainCategories[index];
                      final isSelected = selectedMainCategoryId == category.id;
                      
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedMainCategoryId = category.id;
                            loadSubCategories(category.data['childIds']);
                          });
                        },
                        child: Container(
                          height: 80,
                          decoration: BoxDecoration(
                            color: isSelected ? Colors.white : Colors.transparent,
                            border: Border(
                              left: BorderSide(
                                color: isSelected ? Colors.red : Colors.transparent,
                                width: 3,
                              ),
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                category.data['name'],
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                                  color: isSelected ? Colors.black : Colors.grey[600],
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                
                // 右侧子分类网格
                Expanded(
                  child: subCategories.isEmpty
                      ? const Center(child: Text('サブカテゴリがありません'))
                      : GridView.builder(
                          padding: const EdgeInsets.all(16),
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 0.75,
                            crossAxisSpacing: 12,
                            mainAxisSpacing: 12,
                          ),
                          itemCount: subCategories.length,
                          itemBuilder: (context, index) {
                            final subCategory = subCategories[index];
                            final imageUrl = getImageUrl(
                              subCategory,
                              subCategory.data['picture'],
                            );
                            
                            return GestureDetector(
                              onTap: () {
                                // 导航到商品列表页
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ProductListPage(
                                      categoryId: subCategory.id,
                                      categoryName: subCategory.data['name'],
                                    ),
                                  ),
                                );
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.1),
                                      blurRadius: 4,
                                      offset: const Offset(0, 2),
                                    ),
                                  ],
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // 图片
                                    ClipRRect(
                                      borderRadius: const BorderRadius.vertical(
                                        top: Radius.circular(8),
                                      ),
                                      child: Image.network(
                                        imageUrl,
                                        height: 140,
                                        width: double.infinity,
                                        fit: BoxFit.cover,
                                        errorBuilder: (context, error, stack) {
                                          return Container(
                                            height: 140,
                                            color: Colors.grey[200],
                                            child: const Icon(Icons.image, size: 40),
                                          );
                                        },
                                      ),
                                    ),
                                    // 名称
                                    Padding(
                                      padding: const EdgeInsets.all(12),
                                      child: Text(
                                        subCategory.data['name'],
                                        style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                        ),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                ),
              ],
            ),
    );
  }
}

// 商品列表页面
class ProductListPage extends StatefulWidget {
  final String categoryId;
  final String categoryName;

  const ProductListPage({
    super.key,
    required this.categoryId,
    required this.categoryName,
  });

  @override
  _ProductListPageState createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  final pb = PocketBase('http://your-pocketbase-url');
  List<dynamic> products = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadProducts();
  }

  Future<void> loadProducts() async {
    try {
      final records = await pb.collection('products').getFullList(
        filter: 'category_id = "${widget.categoryId}"',
        expand: 'category_id',
      );
      
      setState(() {
        products = records;
        isLoading = false;
      });
    } catch (e) {
      print('Error loading products: $e');
      setState(() => isLoading = false);
    }
  }

  String getProductImageUrl(dynamic record) {
    if (record.data['images'] != null && record.data['images'].isNotEmpty) {
      return '${pb.baseUrl}/api/files/${record.collectionId}/${record.id}/${record.data['images'][0]}';
    }
    return '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          widget.categoryName,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator(color: Colors.red))
          : products.isEmpty
              ? const Center(child: Text('商品がありません'))
              : GridView.builder(
                  padding: const EdgeInsets.all(16),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.6,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 16,
                  ),
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    final product = products[index];
                    final imageUrl = getProductImageUrl(product);
                    
                    return GestureDetector(
                      onTap: () {
                        // 导航到商品详情页
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // 商品图片
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Stack(
                              children: [
                                Image.network(
                                  imageUrl,
                                  height: 220,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stack) {
                                    return Container(
                                      height: 220,
                                      color: Colors.grey[200],
                                      child: const Icon(Icons.image, size: 50),
                                    );
                                  },
                                ),
                                // 新品标签
                                if (product.data['is_new'] == true)
                                  Positioned(
                                    top: 8,
                                    left: 8,
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 8,
                                        vertical: 4,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Colors.red,
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                      child: const Text(
                                        '新商品',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 11,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ),
                                // 促销标签
                                if (product.data['is_sale'] == true)
                                  Positioned(
                                    top: 8,
                                    right: 8,
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 8,
                                        vertical: 4,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Colors.orange,
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                      child: const Text(
                                        'SALE',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 11,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 8),
                          // 商品名称
                          Text(
                            product.data['name'],
                            style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 4),
                          // 价格
                          Row(
                            children: [
                              Text(
                                '¥${product.data['price'].toString()}',
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.red,
                                ),
                              ),
                              if (product.data['original_price'] != null &&
                                  product.data['original_price'] > product.data['price'])
                                Padding(
                                  padding: const EdgeInsets.only(left: 6),
                                  child: Text(
                                    '¥${product.data['original_price']}',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey[500],
                                      decoration: TextDecoration.lineThrough,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          // 评分和销量
                          Row(
                            children: [
                              const Icon(Icons.star, size: 14, color: Colors.orange),
                              const SizedBox(width: 2),
                              Text(
                                product.data['rating'].toString(),
                                style: const TextStyle(fontSize: 11),
                              ),
                              const SizedBox(width: 8),
                              Text(
                                '${product.data['sold_count']}販売',
                                style: TextStyle(
                                  fontSize: 11,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                ),
    );
  }
}
