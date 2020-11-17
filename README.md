Trước khi chạy app, cần:

1. Khởi động PostgreSql

    ``` sudo service postgresql start ```

2. ``` bundle install```

3. ``` bundle update```

4. ``` rails db:create```

5. ``` rails db:migrate```

6. ``` rails db:seed```

Để chạy app:

* ``` rails s```

NOTE: App sử dụng postgresql, thay đổi trong: 
```config/database.yml-example``` 
*  ```user``` 
* ```password```

Dev-team: ITSS2の最後チーム