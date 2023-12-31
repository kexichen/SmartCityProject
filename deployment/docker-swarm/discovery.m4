
ifelse(defn(`DISCOVER_SIMULATED_CAMERA'),`true',`dnl

    defn(`OFFICE_NAME')_camera_discovery:
        image: IMAGENAME(smtc_onvif_discovery)
        environment:
            PORT_SCAN: "-Pn"
            SIM_HOST: ifelse(eval(defn(`NCAMERAS')>0),1,"loop(`CAMERAIDX',1,defn(`NCAMERAS'),`defn(`OFFICE_NAME')_simulated_cameras:eval(defn(`CAMERA_RTSP_PORT')+defn(`CAMERAIDX')*defn(`CAMERA_PORT_STEP')-defn(`CAMERA_PORT_STEP'))/')",":0")
            SIM_PREFIX: "`cams'ifelse(defn(`SCENARIO_NAME'),`traffic',1,2)`o'defn(`OFFICEIDX')ifelse(defn(`SCENARIO_NAME'),`traffic',c,q)"
            OFFICE: "defn(`OFFICE_LOCATION')"
            DBHOST: "http://ifelse(defn(`NOFFICES'),1,db,defn(`OFFICE_NAME')_db):9200"
            SERVICE_INTERVAL: "30"
            NO_PROXY: "*"
            no_proxy: "*"
        volumes:
            - /etc/localtime:/etc/localtime:ro
        networks:
            - appnet
        deploy:
            placement:
                constraints:
                    - node.labels.vcac_zone!=yes

ifelse(defn(`SCENARIO_NAME'),`stadium',`
    defn(`OFFICE_NAME')_camera_discovery_crowd:
        image: IMAGENAME(smtc_onvif_discovery)
        environment:
            PORT_SCAN: "-Pn"
            SIM_HOST: ifelse(eval(defn(`NCAMERAS2')>0),1,"loop(`CAMERAIDX',1,defn(`NCAMERAS2'),`defn(`OFFICE_NAME')_simulated_cameras_crowd:eval(defn(`CAMERA_RTSP_PORT')+defn(`CAMERAIDX')*defn(`CAMERA_PORT_STEP')-defn(`CAMERA_PORT_STEP'))/')",":0")
            SIM_PREFIX: "`cams2o'defn(`OFFICEIDX')w"
            OFFICE: "defn(`OFFICE_LOCATION')"
            DBHOST: "http://ifelse(defn(`NOFFICES'),1,db,defn(`OFFICE_NAME')_db):9200"
            SERVICE_INTERVAL: "30"
            NO_PROXY: "*"
            no_proxy: "*"
        volumes:
            - /etc/localtime:/etc/localtime:ro
        networks:
            - appnet
        deploy:
            placement:
                constraints:
                    - node.labels.vcac_zone!=yes

    defn(`OFFICE_NAME')_camera_discovery_entrance:
        image: defn(`REGISTRY_PREFIX')smtc_onvif_discovery:latest
        environment:
            PORT_SCAN: "-Pn"
            SIM_HOST: ifelse(eval(defn(`NCAMERAS3')>0),1,"loop(`CAMERAIDX',1,defn(`NCAMERAS3'),`defn(`OFFICE_NAME')_simulated_cameras_entrance:eval(defn(`CAMERA_RTSP_PORT')+defn(`CAMERAIDX')*defn(`CAMERA_PORT_STEP')-defn(`CAMERA_PORT_STEP'))/')",":0")
            SIM_PREFIX: "`cams2o'defn(`OFFICEIDX')e"
            OFFICE: "defn(`OFFICE_LOCATION')"
            DBHOST: "http://ifelse(defn(`NOFFICES'),1,db,defn(`OFFICE_NAME')_db):9200"
            SERVICE_INTERVAL: "30"
            NO_PROXY: "*"
            no_proxy: "*"
        volumes:
            - /etc/localtime:/etc/localtime:ro
        networks:
            - appnet
        deploy:
            placement:
                constraints:
                    - node.labels.vcac_zone!=yes
')')

ifelse(defn(`DISCOVER_IP_CAMERA'),`true',`dnl

    defn(`OFFICE_NAME')_ipcamera_discovery:
        image: defn(`REGISTRY_PREFIX')smtc_onvif_discovery:latest
        environment:
            OFFICE: "defn(`OFFICE_LOCATION')"
            DBHOST: "http://ifelse(defn(`NOFFICES'),1,db,defn(`OFFICE_NAME')_db):9200"
            SERVICE_INTERVAL: "30"
            NO_PROXY: "*"
            no_proxy: "*"
        volumes:
            - /etc/localtime:/etc/localtime:ro
        networks:
            - appnet
        deploy:
            placement:
                constraints:
                    - node.labels.vcac_zone!=yes

')
