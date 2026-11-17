import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

// ================= MODEL =================
class Menu {
final String nama;
final String kategori;
final int harga;
final String deskripsi;
final String emoji;
final String tag;
final String rating;
Menu({
required this.nama,
required this.kategori,
required this.harga,
required this.deskripsi,
required this.emoji,
required this.tag,
required this.rating,
});
}

final List<Menu> daftarMenu = [
Menu(
nama: 'Kopi Susu Gula Aren',
kategori: 'Minuman',
harga: 22000,
deskripsi:
'Espresso double shot, susu segar, gula aren asli dari Sukabumi.',
emoji: '☕',
tag: 'BEST SELLER',
rating: '4.9',
),
Menu(
nama: 'Americano',
kategori: 'Minuman',
harga: 18000,
deskripsi: 'Kopi hitam pekat, karakter bold, pahitnya pas.',
emoji: '☕',
tag: '',
rating: '4.7',
),
Menu(
nama: 'Matcha Latte',
kategori: 'Minuman',
harga: 25000,
deskripsi: 'Matcha premium Uji Jepang, creamy, tidak terlalu manis.',
emoji: '🍵',
tag: 'NEW',
rating: '4.8',
),
Menu(
nama: 'Es Teh Leci',
kategori: 'Minuman',
harga: 19000,
deskripsi:
'Teh melati dingin, buah leci asli, segar banget buat siang hari.',
emoji: '🧋',
tag: '',
rating: '4.6',
),
Menu(
nama: 'Nasi Goreng Spesial',
kategori: 'Makanan',
harga: 32000,
deskripsi: 'Nasi goreng telur, ayam suwir, acar, kerupuk, sambal terpisah.',
emoji: '🍛',
tag: 'BEST SELLER',
rating: '4.9',
),
Menu(
nama: 'Mie Goreng Jawa',
kategori: 'Makanan',
harga: 28000,
deskripsi: 'Mie goreng manis gurih khas Jawa, topping ayam & sayur segar.',
emoji: '🍜',
tag: '',
rating: '4.8',
),
Menu(
nama: 'Chicken Katsu Curry',
kategori: 'Makanan',
harga: 35000,
deskripsi: 'Ayam katsu crispy, saus kari Jepang kental, nasi hangat.',
emoji: '🍛',
tag: '',
rating: '4.8',
),
Menu(
nama: 'Croissant Butter',
kategori: 'Dessert',
harga: 20000,
deskripsi:
'Dipanggang tiap pagi. Renyah di luar, lembut & buttery di dalam.',
emoji: '🥐',
tag: 'FRESH',
rating: '4.9',
),
Menu(
nama: 'Pancake Madu',
kategori: 'Dessert',
harga: 24000,
deskripsi:
'3 layer pancake fluffy, madu murni, butter, taburan gula halus.',
emoji: '🥞',
tag: '',
rating: '4.7',
),
Menu(
nama: 'Brownies Coklat',
kategori: 'Dessert',
harga: 21000,
deskripsi: 'Brownies fudgy, lelehan coklat 70%, best dimakan hangat.',
emoji: '🍫',
tag: '',
rating: '4.8',
),
];

String rp(int h) =>
'Rp ${h.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (m) => '${m[1]}.')}';

// ================= APP =================
class MyApp extends StatelessWidget {
const MyApp({super.key});
@override
Widget build(BuildContext context) {
return MaterialApp(
debugShowCheckedModeBanner: false,
title: 'Kafe Kita',
theme: ThemeData(
colorScheme: ColorScheme.fromSeed(seedColor: Colors.brown),
useMaterial3: true,
fontFamily: 'Roboto',
),
home: const SplashPage(),
);
}
}

// ================= SPLASH =================
class SplashPage extends StatefulWidget {
const SplashPage({super.key});
@override
State<SplashPage> createState() => _SplashPageState();
}

class SplashPageState extends State<SplashPage> {
@override
void initState() {
super.initState();
Future.delayed(const Duration(seconds: 2), () {
Navigator.pushReplacement(
context,
MaterialPageRoute(builder: () => const MainScaffold()),
);
});
}

@override
Widget build(BuildContext context) {
return Scaffold(
backgroundColor: const Color(0xFF2B1D14),
body: Center(
child: Column(
mainAxisAlignment: MainAxisAlignment.center,
children: [
const Text('☕', style: TextStyle(fontSize: 80)),
const SizedBox(height: 12),
const Text(
'KAFE KITA',
style: TextStyle(
fontSize: 32,
fontWeight: FontWeight.bold,
color: Color(0xFFF5E6CC),
letterSpacing: 2,
),
),
const Text(
'Ngopi enak • Makan enak • Nongkrong nyaman',
style: TextStyle(color: Colors.white70),
),
const SizedBox(height: 30),
const CircularProgressIndicator(color: Color(0xFFC9A227)),
],
),
),
);
}
}

// ================= MAIN SCAFFOLD + STATE GLOBAL =================
class MainScaffold extends StatefulWidget {
const MainScaffold({super.key});
@override
State<MainScaffold> createState() => _MainScaffoldState();
}

class _MainScaffoldState extends State<MainScaffold> {
int currentIndex = 0;
Set<Menu> favorit = {};
Map<Menu, int> cart = {};

void toggleFav(Menu m) =>
setState(() => favorit.contains(m) ? favorit.remove(m) : favorit.add(m));
void addCart(Menu m) => setState(() => cart[m] = (cart[m] ?? 0) + 1);
void minCart(Menu m) => setState(() {
if ((cart[m] ?? 0) > 1) {
cart[m] = cart[m]! - 1;
} else {
cart.remove(m);
}
});
int get totalCart =>
cart.entries.fold(0, (s, e) => s + e.key.harga * e.value);

@override
Widget build(BuildContext context) {
final pages = [
HomeTab(favorit: favorit, onFav: toggleFav, onAdd: addCart),
FavoritTab(favorit: favorit, onFav: toggleFav, onAdd: addCart),
CartTab(
cart: cart,
onAdd: addCart,
onMin: minCart,
onClear: () => setState(() => cart.clear()),
),
const ProfilTab(),
];
return Scaffold(
body: pages[currentIndex],
bottomNavigationBar: NavigationBar(
selectedIndex: currentIndex,
onDestinationSelected: (i) => setState(() => currentIndex = i),
destinations: [
const NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
NavigationDestination(
icon: Badge(
label: Text('${favorit.length}'),
child: const Icon(Icons.favorite),
),
label: 'Favorit',
),
NavigationDestination(
icon: Badge(
label: Text('${cart.values.fold(0, (a, b) => a + b)}'),
child: const Icon(Icons.shopping_cart),
),
label: 'Keranjang',
),
const NavigationDestination(
icon: Icon(Icons.person),
label: 'Profil',
),
],
),
);
}
}

// ================= HOME TAB =================
class HomeTab extends StatefulWidget {
final Set<Menu> favorit;
final Function(Menu) onFav;
final Function(Menu) onAdd;
const HomeTab({
super.key,
required this.favorit,
required this.onFav,
required this.onAdd,
});
@override
State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
String filter = 'Semua';
String keyword = '';
List<Menu> get filtered => daftarMenu.where((m) {
bool c1 = filter == 'Semua' || m.kategori == filter;
bool c2 =
keyword.isEmpty || m.nama.toLowerCase().contains(keyword.toLowerCase());
return c1 && c2;
}).toList();

@override
Widget build(BuildContext context) {
return Scaffold(
backgroundColor: const Color(0xFFFFF8F0),
appBar: AppBar(
backgroundColor: const Color(0xFF2B1D14),
foregroundColor: Colors.white,
title: const Column(
crossAxisAlignment: CrossAxisAlignment.start,
children: [
Text(
'✦ KAFE KITA ✦',
style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
),
Text(
'Jl. Kenangan No.12, Sidoarjo • Buka 08.00-22.00',
style: TextStyle(fontSize: 11),
),
],
),
),
body: Column(
children: [
Padding(
padding: const EdgeInsets.all(12),
child: TextField(
onChanged: (v) => setState(() => keyword = v),
decoration: InputDecoration(
hintText: 'Cari menu... kopi, nasi goreng...',
prefixIcon: const Icon(Icons.search),
filled: true,
fillColor: Colors.white,
border: OutlineInputBorder(
borderRadius: BorderRadius.circular(14),
),
),
),
),
SingleChildScrollView(
scrollDirection: Axis.horizontal,
padding: const EdgeInsets.symmetric(horizontal: 12),
child: Row(
children: ['Semua', 'Makanan', 'Minuman', 'Dessert']
.map(
(k) => Padding(
padding: const EdgeInsets.only(right: 8),
child: ChoiceChip(
label: Text(k),
selected: filter == k,
onSelected: () => setState(() => filter = k),
selectedColor: const Color(0xFF2B1D14),
labelStyle: TextStyle(
color: filter == k ? Colors.white : Colors.black,
fontWeight: FontWeight.bold,
),
),
),
)
.toList(),
),
),
const Padding(
padding: EdgeInsets.fromLTRB(16, 14, 16, 6),
child: Align(
alignment: Alignment.centerLeft,
child: Text(
'Menu Hari Ini ✨',
style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
),
),
),
Expanded(
child: filtered.isEmpty
? const Center(child: Text('Menu tidak ditemukan 😢'))
: ListView.builder(
padding: const EdgeInsets.symmetric(horizontal: 12),
itemCount: filtered.length,
itemBuilder: (, i) {
final m = filtered[i];
final isFav = widget.favorit.contains(m);
return Card(
margin: const EdgeInsets.only(bottom: 12),
elevation: 2,
shape: RoundedRectangleBorder(
borderRadius: BorderRadius.circular(16),
),
child: InkWell(
borderRadius: BorderRadius.circular(16),
onTap: () => Navigator.push(
context,
MaterialPageRoute(
builder: (_) => DetailPage(
menu: m,
isFav: isFav,
onFav: () => widget.onFav(m),
onAdd: () => widget.onAdd(m),
),
),
),
child: Padding(
padding: const EdgeInsets.all(12),
child: Row(
children: [
Container(
width: 68,
height: 68,
decoration: BoxDecoration(
color: Colors.orange.shade50,
borderRadius: BorderRadius.circular(12),
),
child: Center(
child: Text(
m.emoji,
style: const TextStyle(fontSize: 30),
),
),
),
const SizedBox(width: 12),
Expanded(
child: Column(
crossAxisAlignment:
CrossAxisAlignment.start,
children: [
Row(
children: [
Expanded(
child: Text(
m.nama,
style: const TextStyle(
fontWeight: FontWeight.bold,
fontSize: 14,
),
),
),
if (m.tag.isNotEmpty)
Container(
padding:
const EdgeInsets.symmetric(
horizontal: 6,
vertical: 2,
),
decoration: BoxDecoration(
color: Colors.amber,
borderRadius:
BorderRadius.circular(6),
),
child: Text(
m.tag,
style: const TextStyle(
fontSize: 9,
fontWeight: FontWeight.bold,
color: Colors.white,
),
),
),
],
),
Text(
'⭐ ${m.rating} • ${m.kategori}',
style: const TextStyle(
color: Colors.grey,
),
),
Text(
m.deskripsi,
maxLines: 2,
overflow: TextOverflow.ellipsis,
style: const TextStyle(fontSize: 12),
),
const SizedBox(height: 4),
Row(
children: [
Text(
rp(m.harga),
style: const TextStyle(
fontWeight: FontWeight.bold,
color: Colors.brown,
fontSize: 15,
),
),
const Spacer(),
IconButton(
icon: Icon(
isFav
? Icons.favorite
: Icons.favorite_border,
color: Colors.red,
),
onPressed: () => widget.onFav(m),
),
ElevatedButton(
onPressed: () {
widget.onAdd(m);
ScaffoldMessenger.of(
context,
).showSnackBar(
SnackBar(
content: Text(
'✓ ${m.nama} ditambahkan!',
),
duration: const Duration(
seconds: 1,
),
),
);
},
child: const Text('+ Pesan'),
),
],
),
],
),
),
],
),
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

// ================= FAVORIT TAB =================
class FavoritTab extends StatelessWidget {
final Set<Menu> favorit;
final Function(Menu) onFav;
final Function(Menu) onAdd;
const FavoritTab({
super.key,
required this.favorit,
required this.onFav,
required this.onAdd,
});
@override
Widget build(BuildContext context) {
return Scaffold(
appBar: AppBar(title: const Text('Menu Favorit ❤️')),
body: favorit.isEmpty
? const Center(
child: Text(
'Belum ada favorit.\nTap ❤️ di menu untuk simpan.',
textAlign: TextAlign.center,
),
)
: ListView(
children: favorit
.map(
(m) => Card(
margin: const EdgeInsets.all(10),
child: ListTile(
leading: Text(
m.emoji,
style: const TextStyle(fontSize: 28),
),
title: Text(
m.nama,
style: const TextStyle(fontWeight: FontWeight.bold),
),
subtitle: Text(rp(m.harga)),
trailing: Row(
mainAxisSize: MainAxisSize.min,
children: [
IconButton(
icon: const Icon(
Icons.favorite,
color: Colors.red,
),
onPressed: () => onFav(m),
),
ElevatedButton(
onPressed: () => onAdd(m),
child: const Text('+ Pesan'),
),
],
),
),
),
)
.toList(),
),
);
}
}

// ================= KERANJANG + CHECKOUT =================
class CartTab extends StatelessWidget {
final Map<Menu, int> cart;
final Function(Menu) onAdd;
final Function(Menu) onMin;
final VoidCallback onClear;
const CartTab({
super.key,
required this.cart,
required this.onAdd,
required this.onMin,
required this.onClear,
});
@override
Widget build(BuildContext context) {
int total = cart.entries.fold(0, (s, e) => s + e.key.harga * e.value);
return Scaffold(
appBar: AppBar(title: const Text('Keranjang 🛒')),
body: cart.isEmpty
? const Center(
child: Text('Keranjang masih kosong.\nYuk pesan dulu!'),
)
: Column(
children: [
Expanded(
child: ListView(
children: cart.entries
.map(
(e) => Card(
margin: const EdgeInsets.all(10),
child: ListTile(
leading: Text(
e.key.emoji,
style: const TextStyle(fontSize: 28),
),
title: Text(
e.key.nama,
style: const TextStyle(
fontWeight: FontWeight.bold,
),
),
subtitle: Text(rp(e.key.harga)),
trailing: Row(
mainAxisSize: MainAxisSize.min,
children: [
IconButton(
icon: const Icon(
Icons.remove_circle_outline,
),
onPressed: () => onMin(e.key),
),
Text(
'${e.value}',
style: const TextStyle(
fontWeight: FontWeight.bold,
fontSize: 16,
),
),
IconButton(
icon: const Icon(Icons.add_circle),
onPressed: () => onAdd(e.key),
),
],
),
),
),
)
.toList(),
),
),
Container(
padding: const EdgeInsets.all(16),
decoration: BoxDecoration(
color: Colors.brown.shade50,
borderRadius: const BorderRadius.vertical(
top: Radius.circular(16),
),
),
child: Column(
children: [
Row(
mainAxisAlignment: MainAxisAlignment.spaceBetween,
children: [
const Text(
'Total',
style: TextStyle(
fontWeight: FontWeight.bold,
fontSize: 18,
),
),
Text(
rp(total),
style: const TextStyle(
fontWeight: FontWeight.bold,
fontSize: 18,
color: Colors.brown,
),
),
],
),
const SizedBox(height: 12),
SizedBox(
width: double.infinity,
child: ElevatedButton(
onPressed: () => Navigator.push(
context,
MaterialPageRoute(
builder: (_) =>
CheckoutPage(total: total, onDone: onClear),
),
),
child: const Text(
'Checkout →',
style: TextStyle(fontSize: 16),
),
),
),
],
),
),
],
),
);
}
}

class CheckoutPage extends StatefulWidget {
final int total;
final VoidCallback onDone;
const CheckoutPage({super.key, required this.total, required this.onDone});
@override
State<CheckoutPage> createState() => _CheckoutPageState();
}

class CheckoutPageState extends State<CheckoutPage> {
final namaController = TextEditingController();
String metode = 'Dine In';
@override
Widget build(BuildContext context) {
return Scaffold(
appBar: AppBar(title: const Text('Checkout')),
body: Padding(
padding: const EdgeInsets.all(20),
child: Column(
crossAxisAlignment: CrossAxisAlignment.start,
children: [
const Text(
'Nama Pemesan',
style: TextStyle(fontWeight: FontWeight.bold),
),
const SizedBox(height: 6),
TextField(
controller: namaController,
decoration: const InputDecoration(
hintText: 'Contoh: abcd',
border: OutlineInputBorder(),
),
),
const SizedBox(height: 16),
const Text(
'Metode Pesanan',
style: TextStyle(fontWeight: FontWeight.bold),
),
RadioListTile(
value: 'Dine In',
groupValue: metode,
onChanged: (v) => setState(() => metode = v!),
title: const Text('Dine In - Makan di tempat'),
),
RadioListTile(
value: 'Take Away',
groupValue: metode,
onChanged: (v) => setState(() => metode = v!),
title: const Text('Take Away - Bungkus'),
),
const SizedBox(height: 16),
Container(
padding: const EdgeInsets.all(16),
decoration: BoxDecoration(
color: Colors.brown.shade50,
borderRadius: BorderRadius.circular(12),
),
child: Row(
mainAxisAlignment: MainAxisAlignment.spaceBetween,
children: [
const Text('Total Bayar', style: TextStyle(fontSize: 16)),
Text(
rp(widget.total),
style: const TextStyle(
fontSize: 20,
fontWeight: FontWeight.bold,
color: Colors.brown,
),
),
],
),
),
const Spacer(),
SizedBox(
width: double.infinity,
child: ElevatedButton(
onPressed: () {
if (namaController.text.isEmpty) {
ScaffoldMessenger.of(context).showSnackBar(
const SnackBar(content: Text('Isi nama dulu ya!')),
);
return;
}
showDialog(
context: context,
barrierDismissible: false,
builder: () => AlertDialog(
title: const Text('🎉 Pesanan Berhasil!'),
content: Text(
'Terima kasih, ${namaController.text}!\nPesanan $metode kamu sedang disiapkan.\nTotal: ${rp(widget.total)}',
),
actions: [
TextButton(
onPressed: () {
widget.onDone();
Navigator.popUntil(context, (r) => r.isFirst);
},
child: const Text('Kembali ke Home'),
),
],
),
);
},
child: const Padding(
padding: EdgeInsets.all(12),
child: Text('Pesan Sekarang', style: TextStyle(fontSize: 16)),
),
),
),
],
),
),
);
}
}

// ================= PROFIL =================
class ProfilTab extends StatelessWidget {
const ProfilTab({super.key});
@override
Widget build(BuildContext context) {
return Scaffold(
appBar: AppBar(title: const Text('Tentang Kafe Kita')),
body: Padding(
padding: const EdgeInsets.all(20),
child: Column(
children: [
const CircleAvatar(
radius: 50,
child: Text('☕', style: TextStyle(fontSize: 40)),
),
const SizedBox(height: 12),
const Text(
'KAFE KITA',
style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
),
const Text(
'Jl. Kenangan No.12, Surabaya',
style: TextStyle(color: Colors.grey),
),
const SizedBox(height: 20),
const Card(
child: ListTile(
leading: Icon(Icons.access_time),
title: Text('Jam Buka'),
subtitle: Text('Setiap Hari 08.00 - 22.00 WIB'),
),
),
const Card(
child: ListTile(
leading: Icon(Icons.star),
title: Text('Rating'),
subtitle: Text('4.9 dari 2.300+ ulasan'),
),
),
const Card(
child: ListTile(
leading: Icon(Icons.wifi),
title: Text('Fasilitas'),
subtitle: Text(
'WiFi Kencang • Stop Kontak Banyak • Cocok buat WFC & Nugas',
),
),
),
const SizedBox(height: 12),
const Text(
'Dibuat untuk Tugas Pemrograman Mobile - Pertemuan 6\nKatalog / Profil - Tema Daftar Menu Kafe',
textAlign: TextAlign.center,
style: TextStyle(color: Colors.grey, fontSize: 12),
),
],
),
),
);
}
}

// ================= DETAIL =================
class DetailPage extends StatelessWidget {
final Menu menu;
final bool isFav;
final VoidCallback onFav;
final VoidCallback onAdd;
const DetailPage({
super.key,
required this.menu,
required this.isFav,
required this.onFav,
required this.onAdd,
});
@override
Widget build(BuildContext context) {
return Scaffold(
appBar: AppBar(
title: Text(menu.nama),
actions: [
IconButton(
icon: Icon(
isFav ? Icons.favorite : Icons.favorite_border,
color: Colors.red,
),
onPressed: onFav,
),
],
),
body: SingleChildScrollView(
padding: const EdgeInsets.all(20),
child: Column(
crossAxisAlignment: CrossAxisAlignment.start,
children: [
Center(
child: Container(
width: 140,
height: 140,
decoration: BoxDecoration(
color: Colors.orange.shade50,
borderRadius: BorderRadius.circular(20),
),
child: Center(
child: Text(menu.emoji, style: const TextStyle(fontSize: 70)),
),
),
),
const SizedBox(height: 16),
Text(
menu.nama,
style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
),
const SizedBox(height: 6),
Text(
'⭐ ${menu.rating} • ${menu.kategori} • ${menu.tag}',
style: const TextStyle(color: Colors.grey),
),
const SizedBox(height: 16),
const Text(
'Deskripsi',
style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
),
Text(menu.deskripsi, style: const TextStyle(fontSize: 15)),
const SizedBox(height: 16),
const Text(
'Kenapa enak?',
style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
),
const Text(
'• Bahan fresh, dibuat setelah kamu pesan\n• Porsi pas, tidak terlalu manis\n• Cocok buat WFC & nugas bareng teman',
style: TextStyle(fontSize: 14),
),
const SizedBox(height: 20),
Container(
padding: const EdgeInsets.all(16),
decoration: BoxDecoration(
color: Colors.brown.shade50,
borderRadius: BorderRadius.circular(12),
),
child: Row(
mainAxisAlignment: MainAxisAlignment.spaceBetween,
children: [
const Text('Harga'),
Text(
rp(menu.harga),
style: const TextStyle(
fontSize: 20,
fontWeight: FontWeight.bold,
color: Colors.brown,
),
),
],
),
),
const SizedBox(height: 16),
SizedBox(
width: double.infinity,
child: ElevatedButton(
onPressed: () {
onAdd();
ScaffoldMessenger.of(context).showSnackBar(
SnackBar(content: Text('✓ ${menu.nama} ditambahkan!')),
);
},
child: const Padding(
padding: EdgeInsets.all(12),
child: Text('+ Tambah ke Keranjang'),
),
),
),
],
),
),
);
}
}
