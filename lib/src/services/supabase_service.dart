import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseService {
  static final SupabaseClient client = Supabase.instance.client;

  static Future<void> initialize(String url, String anonKey) async {
    await Supabase.initialize(url: url, anonKey: anonKey);
  }

  static Future<PostgrestResponse> fetchProducts() async {
    return await client.from('products').select().execute();
  }

  static Future<PostgrestResponse> submitOrder(
      Map<String, dynamic> orderPayload) async {
    return await client.from('orders').insert(orderPayload).execute();
  }

  static Future<PostgrestResponse> submitPayout(
      Map<String, dynamic> payoutPayload) async {
    return await client.from('payout_requests').insert(payoutPayload).execute();
  }

  static Future<PostgrestResponse> updateProductApproval(
      String productId, String approvalStatus) async {
    return await client
        .from('products')
        .update({'approval_status': approvalStatus})
        .eq('id', productId)
        .execute();
  }
}
