import 'package:flutter/material.dart';

class NotificationService {
  static void showNotification(
    BuildContext context, {
    required String title,
    required String message,
    String? imagePath,
    Duration? duration,
  }) {
    OverlayState? overlayState = Overlay.of(context);
    OverlayEntry overlayEntry;
    
    overlayEntry = OverlayEntry(
      builder: (context) {
        return NotificationOverlay(
          title: title,
          message: message,
          imagePath: imagePath,
          onDismiss: () {
          },
        );
      },
    );

    overlayState.insert(overlayEntry);

    Future.delayed(duration ?? const Duration(seconds: 3), () {
      if (overlayEntry.mounted) {
        overlayEntry.remove();
      }
    });
  }
}

class NotificationOverlay extends StatefulWidget {
  final String title;
  final String message;
  final String? imagePath;
  final VoidCallback onDismiss;

  const NotificationOverlay({
    Key? key,
    required this.title,
    required this.message,
    this.imagePath,
    required this.onDismiss,
  }) : super(key: key);

  @override
  State<NotificationOverlay> createState() => _NotificationOverlayState();
}

class _NotificationOverlayState extends State<NotificationOverlay> 
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<Offset> _offsetAnimation;
  late final Animation<double> _opacityAnimation;
  bool _isExpanded = false;

  final Color notificationColor = const Color(0xFF2196F3);
  final Color backgroundColor = Colors.white;
  final Color textColor = Colors.black87;
  final Color subtextColor = Colors.black54;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );

    _offsetAnimation = Tween<Offset>(
      begin: const Offset(0.0, -1.0),
      end: const Offset(0.0, 0.0),
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    _opacityAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggleExpanded() {
    setState(() {
      _isExpanded = !_isExpanded;
    });
  }

  Widget _buildNotificationIcon() {
    return Container(
      width: 32,
      height: 32,
      decoration: BoxDecoration(
        color: notificationColor,
        shape: BoxShape.circle,
      ),
      child: const Icon(
        Icons.notifications,
        color: Colors.white,
        size: 20,
      ),
    );
  }

  Widget _buildAvatar() {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.grey[200],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: widget.imagePath != null
            ? Image.asset(
                widget.imagePath!,
                width: 40,
                height: 40,
                fit: BoxFit.cover,
              )
            : Icon(Icons.person, color: Colors.grey[400], size: 24),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SlideTransition(
        position: _offsetAnimation,
        child: FadeTransition(
          opacity: _opacityAnimation,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Material(
              color: Colors.transparent,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (!_isExpanded)
                    GestureDetector(
                      onTap: _toggleExpanded,
                      child: Container(
                        decoration: BoxDecoration(
                          color: backgroundColor,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 8,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            children: [
                              _buildNotificationIcon(),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      widget.title,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: textColor,
                                        fontSize: 16,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      widget.message,
                                      style: TextStyle(
                                        color: subtextColor,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 16),
                              _buildAvatar(),
                            ],
                          ),
                        ),
                      ),
                    ),
                  
                  if (_isExpanded)
                    Container(
                      decoration: BoxDecoration(
                        color: backgroundColor,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 8,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          GestureDetector(
                            onTap: _toggleExpanded,
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Row(
                                children: [
                                  _buildNotificationIcon(),
                                  const SizedBox(width: 16),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          widget.title,
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: textColor,
                                            fontSize: 16,
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          widget.message,
                                          style: TextStyle(
                                            color: subtextColor,
                                            fontSize: 14,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(width: 16),
                                  _buildAvatar(),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              border: Border(
                                top: BorderSide(
                                  color: Colors.grey[200]!,
                                  width: 1,
                                ),
                              ),
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: TextButton(
                                    onPressed: () {
                                      widget.onDismiss();
                                    },
                                    style: TextButton.styleFrom(
                                      foregroundColor: notificationColor,
                                    ),
                                    child: const Text('LIHAT'), // Dapat diubah sesuai kebutuhan
                                  ),
                                ),
                                Container(
                                  width: 1,
                                  height: 40,
                                  color: Colors.grey[200],
                                ),
                                Expanded(
                                  child: TextButton(
                                    onPressed: () {
                                      widget.onDismiss();
                                    },
                                    style: TextButton.styleFrom(
                                      foregroundColor: notificationColor,
                                    ),
                                    child: const Text('BISUKAN'), // Dapat diubah sesuai kebutuhan
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
            ),
          ),
        ),
      ),
    );
  }
}