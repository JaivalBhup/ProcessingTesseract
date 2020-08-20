P4Vector[] points = new P4Vector[16];
float angle=0;

                
                                           
void setup(){
  size(950,900,P3D);
  points[0] =  new P4Vector(-1, -1, -1, 1);
  points[1] =  new P4Vector(1, -1, -1, 1);
  points[2] =  new P4Vector(1, 1, -1, 1);
  points[3] =  new P4Vector(-1, 1, -1, 1);
  points[4] =  new P4Vector(-1, -1, 1, 1);
  points[5] =  new P4Vector(1, -1, 1, 1);
  points[6] =  new P4Vector(1, 1, 1, 1);
  points[7] =  new P4Vector(-1, 1, 1, 1);
  points[8] =  new P4Vector(-1, -1, -1, -1);
  points[9] =  new P4Vector(1, -1, -1, -1);
  points[10] = new P4Vector(1, 1, -1, -1);
  points[11] = new P4Vector(-1, 1, -1, -1);
  points[12] = new P4Vector(-1, -1, 1, -1);
  points[13] = new P4Vector(1, -1, 1, -1);
  points[14] = new P4Vector(1, 1, 1, -1);
  points[15] = new P4Vector(-1, 1, 1, -1);
  
  
}

void draw(){
  background(255);
  translate(width/2,height/2);
  //rotateY(angle);
   //rotateX(angle);
  
  
  PVector[] newlyProjected = new PVector[16]; 
  for(int i = 0;i<points.length;i++){
    // point stroke
    stroke(0);
    strokeWeight(15);
    noFill();
    
    // rotating matrixes
    float[][] rotateXY = {{cos(angle),-sin(angle),0,0},
                        {sin(angle),cos(angle),0,0},
                        {0,         0,         1,0},
                        {0,         0,         0,1}};
   float[][] rotateXZ = {{cos(angle),0,sin(angle),0},
                         {0,         1,    0     ,0},
                        {-sin(angle),0,cos(angle),0},
                        {0,         0,         0,1}};
   float[][] rotateYZ = {{1,         0,    0     ,0},
                         {0,cos(angle),-sin(angle),0},                      
                        {0,sin(angle),cos(angle),0},
                        {0,         0,         0,1}};
    float[][] rotateXW = {{cos(angle),0,0,-sin(angle)},
                         {0,1,0,0},                      
                        {0,0,1,0},
                        {sin(angle),0,0,cos(angle)}};
    float[][] rotateZW = {{1,0,0,0},
                         {0,1,0,0},                      
                        {0,0,cos(angle),-sin(angle)},
                        {0,0,sin(angle),cos(angle)}};
     float[][] rotateYW =   {{1,0,0,0},
                            {0,cos(angle),0,-sin(angle)},                      
                            {0,0,1,0},
                            {0,sin(angle),0,cos(angle)}};
                            
      // rotating               
      P4Vector rotated = matVecMul2(points[i],rotateYZ);
      //rotated = matVecMul2(rotated,rotateXW);
      rotated = matVecMul2(rotated,rotateYW);
      rotated = matVecMul2(rotated,rotateZW);
    float dist = 2.4;
    float v = 1/(dist-rotated.w);
    float[][] proj = {{v,0,0,0},
                      {0,v,0,0},
                      {0,0,v,0}};  
     PVector projected = matVecMul1(rotated,proj);
     projected.mult(200);
     newlyProjected[i] = projected;
     //point(projected.x,projected.y,projected.z);      
  }
  for(PVector np : newlyProjected){
    point(np.x,np.y,np.z);
  }
  
  for(int i=0 ; i < 4;i++){
    connectLine(0,i,(i+1)%4,newlyProjected);
    connectLine(0,(i)+4,((i+1)%4)+4,newlyProjected);
    connectLine(0,i,i+4,newlyProjected);
  }
  for(int i=0 ; i < 4;i++){
    connectLine(8,i,(i+1)%4,newlyProjected);
    connectLine(8,(i)+4,((i+1)%4)+4,newlyProjected);
    connectLine(8,i,i+4,newlyProjected);
  }
  for(int i=0 ; i < 8;i++){
    connectLine(0,i,(i+8),newlyProjected);
   
  }
  angle+=0.01;
}

// connect line
void connectLine(int offset,int a, int b, PVector[] p){
  strokeWeight(3);
  stroke(0);
  line(p[a+offset].x,p[a+offset].y,p[a+offset].z,p[b+offset].x,p[b+offset].y,p[b+offset].z);
}

// matMul for pVector
PVector matVecMul1(P4Vector p, float[][] f){
  float x=0;
  float y=0;
  float z=0;
  for(int i = 0; i < f.length;i++){
    if(i==0)
    x = f[i][0]*p.x+f[i][1]*p.y+f[i][2]*p.z;
    if(i==1)
    y = f[i][0]*p.x+f[i][1]*p.y+f[i][2]*p.z;
    if(i==2)
    z = f[i][0]*p.x+f[i][1]*p.y+f[i][2]*p.z;
  }
  return new PVector(x,y,z);
  
}
// matMul for p4 vector
P4Vector matVecMul2(P4Vector p, float[][] f){
  float x=0;
  float y=0;
  float z=0;
  float w=0;
  for(int i = 0; i < f.length;i++){
    if(i==0)
    x = f[i][0]*p.x+f[i][1]*p.y+f[i][2]*p.z+f[i][3]*p.w;
    if(i==1)
    y = f[i][0]*p.x+f[i][1]*p.y+f[i][2]*p.z+f[i][3]*p.w;
    if(i==2)
    z = f[i][0]*p.x+f[i][1]*p.y+f[i][2]*p.z+f[i][3]*p.w;
    if(i==3){
      w = f[i][0]*p.x+f[i][1]*p.y+f[i][2]*p.z+f[i][3]*p.w;
    }
  }
  return new P4Vector(x,y,z,w);
  
}
