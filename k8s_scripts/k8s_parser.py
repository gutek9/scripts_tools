import json
import os
import time

LOG_DEV = '/dev/k8s_logs'
FOLDER = '/var/log/logs/K8S/'

with open(LOG_DEV, 'r') as K8S:
        while True:
                LINE = K8S.readline()
                DATE = time.strftime("%Y-%m-%d")
                try:
                        JSON = json.loads(LINE)
                        NS = JSON['kubernetes']['namespace_name']
                        APP = JSON['kubernetes']['pod_name'] + "-" + JSON['kubernetes']['container_name']
                        if 'logger_name' in JSON['log']:
                            INTER = json.loads(JSON['log'])
                            if 'message' in INTER:
                                LOG = INTER['@timestamp'] + " " + INTER['thread_name'] + " " + INTER['level'] + " " + INTER['logger_name'] + " " + INTER['message'] +  "\n"
                            if 'stack_trace' in INTER:
                                LOG = LOG + "STACK TRACE:\n" + INTER['stack_trace'] + "\n"
                        else:
                            LOG = JSON['log']

                        PARSED_FOLDER = FOLDER + NS + "/" + DATE + "/"

                        try:
                                os.stat(os.path.dirname(PARSED_FOLDER))
                        except:
                                os.makedirs(os.path.dirname(PARSED_FOLDER))

                        DST = open(PARSED_FOLDER + APP + ".log", 'a')
                        DST.write(LOG.encode("utf-8"))
                except Exception, ERRMSG:
                        ERRFILE = open('/dev/stdout', 'a')
                        ERRFILE.write(time.strftime("%Y-%m-%d %H:%M:%S") + str(ERRMSG) + "\n")
                        pass
