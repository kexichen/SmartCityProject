include(../../../script/loop.m4)

# docker registry prefix & release suffix
registryPrefix: "defn(`REGISTRY_PREFIX')"
releaseSuffix: "defn(`RELEASE_SUFFIX')"

# platform specifies the target platform: Xeon or VCAC-A.
platform: "defn(`PLATFORM')"

# framework specifies the target framework: gst or ffmpeg.
framework: "defn(`FRAMEWORK')"

# scenario specifies the sample scenario(s) as a list: traffic or stadium. As each 
# scenario runs its own set of services and databases, it is recommended that you
# run multiple scenarios only on a multiple-node deployment.
scenario: 
looplist(`SCENARIO_NAME',defn(`SCENARIO'),`dnl
  - "defn(`SCENARIO_NAME')"
')dnl

# noffices specifies the number of offices in the deployment. Support 1-3
# offices in the traffic scenario and 1 office in the stadium scenario.
noffices: defn(`NOFFICES')

# specify the high availability options for databases
database:
    haCloud: defn(`HA_CLOUD')
    haOffice: defn(`HA_OFFICE')

# specify the high availability options for SRS
srs:
    haOffice: defn(`HA_SRS_OFFICE')

# nCameras specifies the number of cameras served in each office. Currently
# support 1-8 cameras. 
ncameras: 
  traffic: defn(`NCAMERAS')
  svcq: defn(`NCAMERAS')
  crowd: defn(`NCAMERAS2')
  entrance: defn(`NCAMERAS3')

# nAnalytics specifies the number of analytics instances running in each office.
nanalytics: 
  traffic: defn(`NANALYTICS')
  svcq: defn(`NANALYTICS')
  crowd: defn(`NANALYTICS2')
  entrance: defn(`NANALYTICS3')

# cloudWebExternalIP specifies the external IP to access the Smart City or
# Stadium Sample web-cloud GUI
cloudWebExternalIP: "defn(`HOSTIP')"

# officeLocations provide simulated GPS coordinates for the Smart City & Stadium
# offices
officeLocations:
include(../../../maintenance/db-init/sensor-info.m4)dnl
looplist(SCENARIO_NAME,defn(`SCENARIOS'),`dnl
  defn(`SCENARIO_NAME'):
loopifdef(OFFICEIDX,1,`defn(`SCENARIO_NAME')`_office'defn(`OFFICEIDX')`_location'',`dnl
  - "defn(defn(`SCENARIO_NAME')`_office'defn(`OFFICEIDX')`_location')"
')')

# networkPreference specifies the analytics model precision: FP32, INT8 or FP16, or their 
# combination as a comma delimited string. 
networkPreference: "defn(`NETWORK_PREFERENCE')"

# default settings for IP camera simulation & discovery.
discoverSimulatedCamera: true 
cameraRTSPPort:   17000
cameraRTPPort:    27000
cameraPortStep:   10
discoverIPCamera: false 
discoverRTMP:     true 
otType:           false 

# optional: provide Linux user id & group permissioned to access cloud storage
# userID is obtained using command: `$ id -u`
# groupID is obtained using command: `$ id -g`
userId: defn(`USERID')
groupId: defn(`GROUPID')

# optional: build scope: one of "", "cloud", or "officeN", or "cameraN"
buildScope: ""

webrtc:
    udpPort: 10000
    streamingLimit: 10
