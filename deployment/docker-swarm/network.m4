
networks:
    db_net:
    cloud_net:
forloop(`id',1,defn(`NOFFICES'),`dnl
    `office'defn(`id')_net:
    `office'defn(`id')_camera_net:
')