
    defn(`OFFICE_NAME')_alert:
        image: IMAGENAME(smtc_alert)
        volumes:
            - /etc/localtime:/etc/localtime:ro
        environment:
            SERVICE_INTERVAL: "3,5,15"
            OFFICE: "defn(`OFFICE_LOCATION')"
            DBHOST: "http://ifelse(defn(`NOFFICES'),1,db,defn(`OFFICE_NAME')_db):9200"
            OCCUPENCY_ARGS: "100000,8,20,1000,20"
            NO_PROXY: "*"
            no_proxy: "*"
        networks:
            - appnet
        deploy:
            placement:
                constraints:
                    - node.labels.vcac_zone!=yes
