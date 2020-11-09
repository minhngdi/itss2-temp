cần cài ruby và rails, có thể tham khảo ở đây https://gorails.com/setup/ubuntu/16.04 

cài xong thì cd vào good_hotel, mở terminal và lần lượt nhập các lệnh sau:

bundle install

rails db:create

rails db:seed

rails s (gõ lệnh này mỗi khi muốn chạy chương trình)

NOTE: project sử dụng postgresql, vào file config/database.yml có 2 dòng user và password thì đổi thành trong máy của bạn

tài khoản admin có sẵn email: admin@gmail.com, password: adminadmin
