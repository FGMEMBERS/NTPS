# Radar conversions for 2D panel
#
#

update_surface_deflections = func {
    de = getprop("/surface-positions/elevator-pos-norm");
    if ( de == nil ) { return; } # bail if values aren't available yet
    setprop("/surface-positions/elevator-pos-deg", de * 20.0);

    dla = getprop("/surface-positions/left-aileron-pos-norm");
    if ( dla == nil ) { dla = 0.0; }
    setprop("/surface-positions/left-aileron-pos-deg", dla * 20.0);

    dra = getprop("/surface-positions/right-aileron-pos-norm");
    if ( dra == nil ) { dra = 0.0; }
    setprop("/surface-positions/right-aileron-pos-deg", dra * 20.0);

    dr = getprop("/surface-positions/rudder-pos-norm");
    if ( dr == nil ) { dr = 0.0; }
    setprop("/surface-positions/rudder-pos-deg", dr * 20.0);
}


update_control_forces = func {
    elev = getprop("/controls/flight/elevator");
    if ( elev == nil ) { return; } # bail if values aren't available yet
    setprop("/controls/flight/elevator-force", elev * 45.0);
 
    ail = getprop("/controls/flight/aileron");
    setprop("/controls/flight/aileron-force", ail * 45.0);

    rud = getprop("/controls/flight/rudder");
    setprop("/controls/flight/rudder-force", rud * 100.0);
}

update_data = func {
    update_surface_deflections();
    update_control_forces();

    registerTimer();
}

registerTimer = func {
    settimer(update_data, 0);
}
registerTimer();
