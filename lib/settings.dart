import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('Settings',style: TextStyle(fontWeight: FontWeight.bold),),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle('Account Settings'),
            _buildListTile(Icons.person, 'Profile', onTap: () {}),
            _buildListTile(Icons.lock, 'Privacy', onTap: () {}),
            _buildListTile(Icons.security, 'Security', onTap: () {}),
            const Divider(),
            
            _buildSectionTitle('Preferences'),
            _buildSwitchTile(Icons.notifications, 'Notifications', true, (value) {
            }),
            _buildSwitchTile(Icons.dark_mode, 'Dark Mode', false, (value) {}),
            const Divider(),
            
            _buildSectionTitle('Help & Support'),
            _buildListTile(Icons.help, 'Help Center', onTap: () {}),
            _buildListTile(Icons.feedback, 'Feedback', onTap: () {}),
          ],
        ),
      ),
    );
  }

  Widget _buildSwitchTile(IconData icon, String title, bool value, ValueChanged<bool> onChanged) {
    return SwitchListTile(
      secondary: Icon(icon),
      title: Text(title),
      value: value,
      onChanged: onChanged,
      activeColor: const Color.fromARGB(255, 92, 92, 92), // Set the active color to white
      inactiveThumbColor: Colors.white, // Set the inactive thumb color to white
    );
  }

  Widget _buildListTile(IconData icon, String title, {VoidCallback? onTap}) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      onTap: onTap,
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Text(
        title,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }
}

  Widget _buildListTile(IconData icon, String title, {VoidCallback? onTap}) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: onTap,
    );
  }

  Widget _buildSwitchTile(IconData icon, String title, bool value, ValueChanged<bool> onChanged) {
    return SwitchListTile(
      secondary: Icon(icon),
      title: Text(title),
      value: value,
      onChanged: onChanged,
    );
  }
