highp float;
void main( ) {
    //vec2 Resolution = vec2(2200.0, 1230.0);
    vec2 xy = gl_FragCoord.xy / Resolution.xy;
    vec3 pos2 = vec3((withPosX / 1024.0) * Resolution.x, (withPosY / 768.0) * Resolution.y, 1.0);
    
    
    vec2 res = vec2(withWidth * 2.1484375, withHeight * 1.6015625);
    
    vec2 RESXYZ = vec2(Resolution.x / 1024.0, Resolution.y / 768.0);
    vec2 Res3 = vec2(withWidth * RESXYZ.x, withHeight * RESXYZ.y);
    
    
    vec2 xy2 = gl_FragCoord.xy;
    xy2.x = xy2.x - pos2.x;
    xy2.y = xy2.y - pos2.y;//2.0;
    
    //xy2.y = Resolution.y - xy2.y;
    
    vec2 pixel = xy2/Res3;
    
    vec4 color = texture2D(tex,pixel);
    
    gl_FragColor = color;
    
}