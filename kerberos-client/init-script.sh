#!/bin/bash
echo "==================================================================================="
echo "==== Kerberos Client =============================================================="
echo "==================================================================================="
KADMIN_PRINCIPAL_FULL=$KADMIN_PRINCIPAL@$REALM
echo "REALM: $REALM"
echo "KADMIN_PRINCIPAL_FULL: $KADMIN_PRINCIPAL_FULL"
echo "KADMIN_PASSWORD: $KADMIN_PASSWORD"
echo ""
function kadminCommand {
    kadmin -p $KADMIN_PRINCIPAL_FULL -w $KADMIN_PASSWORD -q "$1"
}
echo "==================================================================================="
echo "==== /etc/krb5.conf ==============================================================="
echo "==================================================================================="
tee /etc/krb5.conf <<EOF
[libdefaults]
        default_realm = EXAMPLE.COM

[realms]
        EXAMPLE.COM = {
                kdc_ports = 88,750
                kadmind_port = 749
                kdc = kdc-kadmin
                admin_server = kdc-kadmin
        }
EOF
echo ""
echo "==================================================================================="
echo "==== Testing ======================================================================"
echo "==================================================================================="
kadminCommand "list_principals $KADMIN_PRINCIPAL_FULL"
echo "KDC and Kadmin are operational"
echo ""