import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Stack(
        children: [
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: GestureDetector(
                onTap: () {},
                child: Container(
                  width: 150,
                  height: 50,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 6,
                        offset: Offset(2, 4),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.chat_rounded,
                        color: Colors.white,
                      ),
                      SizedBox(width: 8),
                      Text(
                        'Chat',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 21,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(30),
          ),
          child: Row(
            children: [
              Image.asset(
                'assets/deed.png',
                width: 30,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search here',
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(vertical: 10),
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.search),
                onPressed: () {},
                color: Colors.grey,
              ),
            ],
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none_outlined),
            onPressed: () {},
            color: Colors.black,
          ),
        ],
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {},
          color: Colors.black,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 180,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  cardItem('http://devapiv4.dealsdray.com/icons/Image -97.png'),
                  cardItem('http://devapiv4.dealsdray.com/icons/Image -99.png'),
                  cardItem('http://devapiv4.dealsdray.com/icons/Image -97.png'),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [
                      Color(0xFF6B9BFF),
                      Color(0xFF5068FF),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      'KYC Pending',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 21,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'You need to provide the required\ndocumentsfor your account activation.',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    GestureDetector(
                        onTap: () {},
                        child: TextButton(
                          onPressed: () {},
                          child: const Text(
                            'Click Here',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 19,
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        )),
                  ],
                ),
              ),
            ),
            // Row-wise scrollable category buttons
            // SizedBox(
            //   height: 100,
            //   child: ListView(
            //     scrollDirection: Axis.horizontal,
            //     children: [
            //       categoryItem(Icons.phone_android, 'Mobile'),
            //       categoryItem(Icons.laptop, 'Laptop'),
            //       categoryItem(Icons.camera_alt, 'Camera'),
            //       categoryItem(Icons.tv, 'LED'),
            //     ],
            //   ),
            // ),

            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
              child: SizedBox(
                height: 150,
                child: GridView.count(
                  crossAxisCount: 4,
                  mainAxisSpacing: 16.0,
                  crossAxisSpacing: 16.0,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  children: [
                    buildIconItem(
                      Colors.blueAccent,
                      Icons.smartphone,
                      'Mobile',
                    ),
                    buildIconItem(
                      Colors.greenAccent,
                      Icons.laptop,
                      'Laptop',
                    ),
                    buildIconItem(
                      Colors.pinkAccent,
                      Icons.camera_alt,
                      'Camera',
                    ),
                    buildIconItem(
                      Colors.orangeAccent,
                      Icons.lightbulb,
                      'LED',
                    ),
                  ],
                ),
              ),
            ),
            // Padding(
            //   padding: const EdgeInsets.all(8.0),
            //   child: Column(
            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     children: [
            //       const Text(
            //         'EXCLUSIVE FOR YOU',
            //         style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            //       ),
            //       const SizedBox(height: 10),
            //       SizedBox(
            //         height: 250,
            //         child: ListView(
            //           scrollDirection: Axis.horizontal,
            //           children: [
            //             exclusiveCard('assets/phone.jpg', '32% Off'),
            //             exclusiveCard('assets/phone.jpg', '15% Off'),
            //           ],
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
            Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: 550,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Color(0xFF68BBE3),
                        Color(0xFF0B78D4),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "EXCLUSIVE FOR YOU",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: const Color.fromARGB(255, 255, 255, 255),
                              ),
                            ),
                            SizedBox(height: 16),
                            SizedBox(
                              height: 450,
                              child: ListView(
                                scrollDirection: Axis.horizontal,
                                children: [
                                  exclusiveCards(
                                      'http://devapiv4.dealsdray.com/icons/Image%20-70.png',
                                      '32% Off',
                                      'Nokia 8.1 (64GB)'),
                                  exclusiveCards(
                                      'http://devapiv4.dealsdray.com/icons/Image 7.png',
                                      '14% Off',
                                      'Redmi 7s Pro'),
                                  exclusiveCards(
                                      'http://devapiv4.dealsdray.com/icons/Image%20-70.png',
                                      '20% Off',
                                      'OnePlus 9T'),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        iconSize: 35,
        showUnselectedLabels: true,
        unselectedItemColor: Colors.grey,
        selectedItemColor: Color.fromARGB(255, 255, 0, 0),
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.home_outlined,
              ),
              label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.category_outlined), label: 'Categories'),
          BottomNavigationBarItem(
              icon: Icon(Icons.local_offer_outlined), label: 'Deals'),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart_checkout), label: 'Cart'),
          BottomNavigationBarItem(
              icon: Icon(Icons.person_outlined), label: 'Profile'),
        ],
      ),
    );
  }

  Widget exclusiveCard(String imagePath, String offer, String title) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      child: SizedBox(
        width: 160,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              imagePath,
              height: 150,
              width: 160,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    offer,
                    style: TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black87,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget cardItem(String imagePath) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      child: SizedBox(
        width: 250,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(imagePath, height: 163, fit: BoxFit.fill),
          ],
        ),
      ),
    );
  }

  Widget categoryItem(IconData icon, String label) {
    return Column(
      children: [
        IconButton(
          icon: Icon(icon,
              size: 40, color: const Color.fromARGB(255, 85, 82, 82)),
          onPressed: () {},
        ),
        Text(label),
      ],
    );
  }

  Widget exclusiveCards(String imagePath, String offer, String title) {
    return Card(
      elevation: 10,
      margin: const EdgeInsets.all(8.0),
      child: SizedBox(
        width: 260,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              height: 5,
            ),
            Stack(
              children: [
                Center(
                  child: Image.network(
                    imagePath,
                    height: 210,
                    width: 150,
                    fit: BoxFit.contain,
                  ),
                ),
                Positioned(
                  top: 1,
                  right: 10,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8.0,
                      vertical: 4.0,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Text(
                      offer,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 50,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 4),
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.black87,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildIconItem(Color color, IconData icon, String label) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 35,
                color: Colors.white,
              ),
            ],
          ),
        ),
        SizedBox(
          height: 3,
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 16,
            color: const Color.fromARGB(255, 3, 3, 3),
          ),
        ),
      ],
    );
  }
}
