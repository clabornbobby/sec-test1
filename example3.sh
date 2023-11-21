#wait for the SQL Server to come up
sleep 50s

echo "running set up script"
#run the setup script to create the DB and the schema in the DB
cat setup/local-db-init.sql \
    setup/ausp_appointment_get_v_1_1.sql \
    setup/ausp_appointment_updatedinperiod_get.sql \
    setup/ausp_appointment_get_multi_v_1_1.sql \
    setup/quit.sql | isql -v -n -k 'Driver=ODBC Driver 17 for SQL Server;Server=tcp:localhost,1433;Encrypt=no;UID=sa;PWD=SA_P@ss123' 