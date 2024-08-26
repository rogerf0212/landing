import 'dart:convert';

import 'package:http/http.dart' as http;

class SendEmailService{
  static sendMail({
    required String name,
    required String email,
    required String subject,
    required String message,
  }) async {
    try{
    var endPointUrl = Uri.parse('https://api.emailjs.com/api/v1.0/email/send');
    var response = await http.post(endPointUrl, headers: {
      'Content-Type': 'application/json'
    },
    body: json.encode({
      'service_id': 'service_dulgf8t',
      'template_id': 'template_iujxybh',
      'user_id': 'Gv-NhYWMQXGjoSo1U', 
      'template_params': {
        'user_name': name,
        'user_email': email,
        'user_subject': subject,
        'user_message': message,
      },
    }),
    );
    if(response.statusCode == 200){
      print(response.body);
    }
  } catch (e){
    print(e.toString());
  }
}
}