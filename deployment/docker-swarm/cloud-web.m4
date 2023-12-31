
    cloud_web:
        image: IMAGENAME(smtc_web_cloud)
        ports:
            - target: 8443
              published: 443
              protocol: tcp
              mode: host
        environment:
            DBHOST: "http://ifelse(defn(`NOFFICES'),1,db,cloud_db):9200"
            GWHOST: "http://cloud_gateway:8080"
            `SCENARIO': "defn(`SCENARIO')"
            NO_PROXY: "*"
            no_proxy: "*"
        volumes:
            - /etc/localtime:/etc/localtime:ro
        secrets:
            - source: self_crt
              target: self.crt
              uid: "defn(`USER_ID')"
              gid: "defn(`GROUP_ID')"
              mode: 0444
            - source: self_key
              target: self.key
              uid: "defn(`USER_ID')"
              gid: "defn(`GROUP_ID')"
              mode: 0440
        networks:
            - appnet
        deploy:
            placement:
                constraints:
                    - node.role==manager
                    - node.labels.vcac_zone!=yes
