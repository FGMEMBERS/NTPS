# Radar conversions for 2D panel
#
#

update_radar = func{
true_heading = getprop("/orientation/heading-deg");
ai_craft = props.globals.getNode("/ai/models").getChildren("aircraft");
mp_craft = props.globals.getNode("/ai/models").getChildren("multiplayer");
for(i=0; i<size(ai_craft);i=i+1){
if(getprop("ai/models/aircraft[" ~ i ~ "]/radar/in-range") != 0){
setprop("/instrumentation/radar/ai[" ~ i ~ "]/active",1);
tgt_offset = getprop("ai/models/aircraft[" ~ i ~ "]/radar/bearing-deg");
tgt_offset -= true_heading;
if (tgt_offset < -180){tgt_offset +=360;}
if (tgt_offset > 180){tgt_offset -=360;}
setprop("/instrumentation/radar/ai[" ~ i ~ "]/brg-offset",tgt_offset);
test_dist=getprop("/instrumentation/radar/range");
test1_dist = getprop("ai/models/aircraft[" ~ i ~ "]/radar/range-nm");
if(test1_dist == nil){test1_dist=0.0;}
norm_dist= (1 / test_dist) * test1_dist;
setprop("/instrumentation/radar/ai[" ~ i ~ "]/norm-dist", norm_dist);
setprop("/instrumentation/radar/ai[" ~ i ~ "]/id", getprop("ai/models/aircraft[" ~ i ~ "]/callsign"));
}}
for(i=0; i<size(mp_craft);i=i+1){
if(getprop("ai/models/multiplayer[" ~ i ~ "]/radar/in-range") !=0 ){
setprop("/instrumentation/radar/mp[" ~ i ~ "]/active",1);
tgt_offset = getprop("ai/models/multiplayer[" ~ i ~ "]/radar/bearing-deg");
tgt_offset -= true_heading;
if (tgt_offset < -180){tgt_offset +=360;}
if (tgt_offset > 180){tgt_offset -=360;}
setprop("/instrumentation/radar/mp[" ~ i ~ "]/brg-offset",tgt_offset);
test_dist=getprop("/instrumentation/radar/range");
test1_dist = getprop("ai/models/multiplayer[" ~ i ~ "]/radar/range-nm");
if(test1_dist == nil){test1_dist=0.0;}
norm_dist= (1 / test_dist) * test1_dist;
setprop("/instrumentation/radar/mp[" ~ i ~ "]/norm-dist", norm_dist);
setprop("/instrumentation/radar/mp[" ~ i ~ "]/id", getprop("ai/models/multiplayer[" ~ i ~ "]/callsign"));
}} 
tgt_offset = getprop("autopilot/settings/true-heading-deg");
if(tgt_offset == nil){tgt_offset = 0.0;}
tgt_offset -= true_heading;
if (tgt_offset < -180){tgt_offset +=360;}
if (tgt_offset > 180){tgt_offset -=360;}
setprop("/instrumentation/radar/wp/brg-offset",tgt_offset);
test_dist=getprop("/instrumentation/radar/range");
test1_dist=getprop("/autopilot/route-manager/wp/dist");
if(test1_dist == nil){test1_dist=0.0;}
norm_dist= (1 / test_dist) * test1_dist;
setprop("/instrumentation/radar/wp/norm-dist", norm_dist);
registerTimer();
}


registerTimer = func {
    settimer(update_radar, 0);
}
registerTimer();
