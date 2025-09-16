import 'package:flutter/material.dart';
import 'cart_page.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Online Shop',
      theme: ThemeData(
        fontFamily: 'Sans',
        scaffoldBackgroundColor: Colors.grey[100],
        useMaterial3: true,
      ),
      home: const HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int halamanAktif = 0;

  List<String> kategori = [
    'Semua', 'Baju', 'Celana', 'Sepatu', 'Tas', 'Aksesoris', 'Pakaian Muslim'
  ];
  String kategoriDipilih = 'Semua';

  List<Map<String, String>> semuaProduk = [
    {
      'nama': 'Kaos Keren',
      'harga': 'Rp 50.000',
      'kategori': 'Baju',
      'gambar': 'assets/images/kaos2.jpg'
    },
    {
      'nama': 'Sepatu Nike',
      'harga': 'Rp 3.169.000',
      'kategori': 'Sepatu',
      'gambar': 'assets/images/sepatu nike.jpg'
    },
    {
      'nama': 'Celana Jeans',
      'harga': 'Rp 150.000',
      'kategori': 'Celana',
      'gambar': 'assets/images/jeans.jpg'
    },
    {
      'nama': 'Sepatu Sport',
      'harga': 'Rp 200.000',
      'kategori': 'Sepatu',
      'gambar': 'assets/images/shoes.jpg'
    },
    {
      'nama': 'Tas Sekolah',
      'harga': 'Rp 75.000',
      'kategori': 'Tas',
      'gambar': 'assets/images/Tas.jpeg'
    },
    {
      'nama': 'Jaket Hoodie',
      'harga': 'Rp 125.000',
      'kategori': 'Baju',
      'gambar': 'assets/images/Jacket.jpeg'
    },
    {
      'nama': 'Topi Baseball',
      'harga': 'Rp 35.000',
      'kategori': 'Aksesoris',
      'gambar': 'assets/images/cap.jpeg'
    },
    {
      'nama': 'Jubah Calle',
      'harga': 'Rp 2.000.000',
      'kategori': 'Pakaian Muslim',
      'gambar': 'assets/images/Jubah.jpeg'
    },
    {
      'nama': 'Jubah Al-Haramain',
      'harga': 'Rp 1.000.000',
      'kategori': 'Pakaian Muslim',
      'gambar': 'assets/images/Jubah Al-Haramain.jpeg'
    },
    {
      'nama': 'Baju Bola Nike',
      'harga': 'Rp 50.000',
      'kategori': 'Baju',
      'gambar': 'assets/images/bola.jpg'
    },
    {
      'nama': 'Jubah Zaafer',
      'harga': 'Rp 1.800.000',
      'kategori': 'Pakaian Muslim',
      'gambar': 'assets/images/japir.jpeg'
    },
    {
      'nama': 'Sepatu Hiking',
      'harga': 'Rp 3.200.000',
      'kategori': 'Sepatu',
      'gambar': 'assets/images/gunung.jpg'
    },
    {
      'nama': 'Tas Gunung 80L',
      'harga': 'Rp 750.000',
      'kategori': 'Tas',
      'gambar': 'assets/images/tass.jpg'
    },
    {
      'nama': 'Tas Sekolah Eiger',
      'harga': 'Rp 50.000',
      'kategori': 'Tas',
      'gambar': 'assets/images/Sekolah.jpeg'
    },
  ];

  List<Map<String, String>> get produkTersaring {
    if (kategoriDipilih == 'Semua') return semuaProduk;
    return semuaProduk.where((p) => p['kategori'] == kategoriDipilih).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Online Shop"),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        actions: [
          IconButton(
            icon: const Icon(Icons.chat_bubble_outline),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Chat feature coming soon!')),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.shopping_cart_outlined),
            onPressed: () {
                                  Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const CartPage()),
            );
                                },
          ),
        ],
      ),
      body: Column(
        children: [
          // Search
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search...',
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),

          // Promo Banner
          SizedBox(
            height: 100,
            child: PageView(
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    color: Colors.green.shade400,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text("Get 15% off your first order!",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold)),
                            SizedBox(height: 4),
                            Text("Use code: FIRST15",
                                style: TextStyle(
                                    color: Colors.white70, fontSize: 14)),
                          ],
                        ),
                      ),
                      const Icon(Icons.discount, color: Colors.white, size: 40)
                    ],
                  ),
                )
              ],
            ),
          ),

          // Kategori
          SizedBox(
            height: 50,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              itemCount: kategori.length,
              itemBuilder: (context, index) {
                String kat = kategori[index];
                bool aktif = kategoriDipilih == kat;
                return GestureDetector(
                  onTap: () => setState(() => kategoriDipilih = kat),
                  child: Container(
                    margin: const EdgeInsets.only(right: 12),
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color: aktif ? Colors.blue : Colors.white,
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(
                          color: aktif ? Colors.blue : Colors.grey.shade300),
                    ),
                    child: Center(
                      child: Text(
                        kat,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: aktif ? Colors.white : Colors.black87,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          // Produk Grid
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              itemCount: produkTersaring.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 0.65,
              ),
              itemBuilder: (context, index) {
                var produk = produkTersaring[index];
                return GestureDetector(
                  onTap: () => _showDetailProduk(produk),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.06),
                          blurRadius: 6,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Expanded(
                          child: ClipRRect(
                            borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                            child: Image.asset(
                              produk['gambar']!,
                              fit: BoxFit.cover,
                              width: double.infinity,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                produk['nama']!,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 14),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                produk['harga']!,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green.shade800,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Row(
                                children: [
                                  const Icon(Icons.star,
                                      size: 14, color: Colors.orange),
                                  const SizedBox(width: 4),
                                  Text("4.8 • 549",
                                      style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.grey[600])),
                                ],
                              ),
                              const SizedBox(height: 4),
                              const Text("Flat rate eligible",
                                  style: TextStyle(
                                      fontSize: 11, color: Colors.grey)),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: halamanAktif,
        selectedItemColor: Colors.blue.shade700,
        unselectedItemColor: Colors.grey,
        onTap: (index) => setState(() => halamanAktif = index),
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.flash_on_outlined), label: "Blitz Buy"),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite_border), label: "Wishlist"),
          BottomNavigationBarItem(
              icon: Icon(Icons.local_shipping_outlined), label: "Express"),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: "Recent"),
          BottomNavigationBarItem(
              icon: Icon(Icons.person_outline), label: "Account"),
        ],
      ),
    );
  }

  void _showDetailProduk(Map<String, String> produk) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(produk['nama']!),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              produk['gambar']!,
              width: 150,
              height: 150,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 12),
            Text(
              'Harga: ${produk['harga']}',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.green.shade800,
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Tutup'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                    content: Text(
                        '${produk['nama']} ditambahkan ke keranjang!')),
              );
            },
            child: const Text('Beli Sekarang'),
          ),
        ],
      ),
    );
  }
}
