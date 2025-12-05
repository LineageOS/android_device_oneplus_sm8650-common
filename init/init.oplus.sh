#!/vendor/bin/sh
#
# Detect the dynamic IPA thermal zone and set sys.ipa_thermal_number
#

for f in /sys/class/thermal/thermal_zone*; do
    type_file="$f/type"
    if [ -f "$type_file" ]; then
        read -r zone_type < "$type_file"
        if [ "$zone_type" = "oplus_thermal_ipa" ]; then
            zone_num="${f##*/thermal_zone}"
            setprop sys.ipa_thermal_number "$zone_num"
            exit 0
        fi
    fi
done

exit 0
