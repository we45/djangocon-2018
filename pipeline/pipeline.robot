*** Settings ***
Library  RoboZap  http://127.0.0.1:8080/  8080
Library  RoboBandit

*** Variables ***
${EXPORT_FILE_PATH}  /Users/tilakt/Documents/DjangoCon/pipeline
${ZAP_PATH}  /Applications/OWASP_ZAP.app/Contents/Java/
${CONTEXT}  default
${ZAP_TARGET}  http://127.0.0.1:8000
${REPORT_FORMAT}  json
${REPORT_TITLE}  DjangoConUS Pipeline
${REPORT_AUTHOR}  Tilak.T
${CODE_PATH}  /Users/tilakt/Documents/DjangoCon/AtoZ
${RESULTS_PATH}  /Users/tilakt/Documents/DjangoCon/pipeline

*** Test Cases ***

Run Safety against Requirements File
    run safety against python source  ${CODE_PATH}  ${RESULTS_PATH}

#Run Bandit against Source Code
#    run bandit against python source  ${CODE_PATH}  ${RESULTS_PATH}

Start ZAP
    start gui zap  ${ZAP_PATH}
    sleep  14
    zap open url  ${ZAP_TARGET}

ZAP Contextualize
    ${contextid}=  zap define context  ${CONTEXT}  ${ZAP_TARGET}
    set suite variable  ${CONTEXT_ID}  ${contextid}

ZAP Crawl
    ${spider_id}=  zap start spider  ${CONTEXT}  ${ZAP_TARGET}
    zap spider status  ${spider_id}

ZAP Active Scan
    ${scan_id}=  zap start ascan  ${CONTEXT_ID}  ${ZAP_TARGET}
    set suite variable  ${SCAN_ID}  ${scan_id}
    zap scan status  ${scan_id}
    zap write to json file  ${ZAP_TARGET}

ZAP Die
    zap shutdown



