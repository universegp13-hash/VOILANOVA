import '../models/product.dart';
import '../models/chart_data.dart';
import '../models/payout_request.dart';
import '../models/audit_log.dart';
import 'constants.dart';

final kMockProducts = <Product>[
  Product(
    id: 'prod-001',
    title: 'Luna Luxe Handbag',
    description: 'Premium leather artisan handbag with gold accents.',
    price: 4950,
    compareAtPrice: 6990,
    stock: 18,
    category: 'Accessories',
    vendorId: kDefaultSellerId,
    primaryImageUrl: kPlaceholderProduct,
    secondaryImagesUrls: [kPlaceholderProduct],
    isFeatured: true,
    isDeal: true,
    approvalStatus: 'approved',
  ),
  Product(
    id: 'prod-002',
    title: 'Sculpted Glass Vase',
    description: 'Contemporary statement vase for modern interiors.',
    price: 2750,
    compareAtPrice: 3290,
    stock: 11,
    category: 'Home',
    vendorId: kDefaultSellerId,
    primaryImageUrl: kPlaceholderProduct,
    secondaryImagesUrls: [kPlaceholderProduct],
    isFeatured: true,
    isDeal: false,
    approvalStatus: 'pending',
  ),
  Product(
    id: 'prod-003',
    title: 'Aurora Performance Sneakers',
    description: 'Lightweight shoes engineered for style and comfort.',
    price: 6200,
    compareAtPrice: 8700,
    stock: 24,
    category: 'Footwear',
    vendorId: 'seller-uuid-002',
    primaryImageUrl: kPlaceholderProduct,
    secondaryImagesUrls: [kPlaceholderProduct],
    isFeatured: false,
    isDeal: true,
    approvalStatus: 'approved',
  ),
  Product(
    id: 'prod-004',
    title: 'Nairobi Coffee Table',
    description: 'Minimalist teak coffee table with rich grain finish.',
    price: 10450,
    compareAtPrice: 12990,
    stock: 9,
    category: 'Furniture',
    vendorId: kDefaultSellerId,
    primaryImageUrl: kPlaceholderProduct,
    secondaryImagesUrls: [kPlaceholderProduct],
    isFeatured: false,
    isDeal: false,
    approvalStatus: 'approved',
  ),
];

final kSellerRevenueData = <ChartData>[
  ChartData(label: 'Mon', value: 12400),
  ChartData(label: 'Tue', value: 15700),
  ChartData(label: 'Wed', value: 13800),
  ChartData(label: 'Thu', value: 19100),
  ChartData(label: 'Fri', value: 20900),
  ChartData(label: 'Sat', value: 23400),
  ChartData(label: 'Sun', value: 26000),
];

final kSellerTopProducts = <ChartData>[
  ChartData(label: 'Luna Bag', value: 78),
  ChartData(label: 'Aurora Shoes', value: 63),
  ChartData(label: 'Nairobi Table', value: 41),
  ChartData(label: 'Sculpted Vase', value: 28),
];

final kSellerPayoutRequests = <PayoutRequest>[
  PayoutRequest(
    id: 'payout-001',
    sellerId: kDefaultSellerId,
    amount: 14500,
    method: 'M-Pesa',
    status: 'pending',
    transactionCode: 'MPESA-007',
    createdAt: DateTime.now().subtract(const Duration(days: 2)),
  ),
  PayoutRequest(
    id: 'payout-002',
    sellerId: kDefaultSellerId,
    amount: 8600,
    method: 'PayPal',
    status: 'paid',
    transactionCode: 'PP-9012',
    createdAt: DateTime.now().subtract(const Duration(days: 9)),
  ),
];

final kAuditLogs = <AuditLog>[
  AuditLog(
    id: 'log-001',
    timestamp: '2026-05-22 18:15',
    message: 'Approved Seller by universegp13@gmail.com',
  ),
  AuditLog(
    id: 'log-002',
    timestamp: '2026-05-22 17:58',
    message: 'Order #ORD-3145 moved to shipped status',
  ),
  AuditLog(
    id: 'log-003',
    timestamp: '2026-05-22 16:34',
    message: 'Broadcast message sent to vendors and customers',
  ),
];
