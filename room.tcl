proc BuildRoom {minX maxX minY maxY minZ maxZ} {
    if { [info command basePlane] == "" } {vtkCubeSource basePlane;}
    basePlane SetCenter [expr ($maxX + $minX) / 2.0] $minY [expr ($maxZ + $minZ) / 2.0] 
    basePlane SetXLength [expr ($maxX - $minX)]
    basePlane SetYLength 2
    basePlane SetZLength [expr ($maxZ - $minZ)]

    if { [info command baseMapper] == "" } {vtkPolyDataMapper baseMapper;}
     baseMapper SetInputConnection [basePlane GetOutputPort]
    if { [info command base] == "" } {vtkActor base;ren1 AddActor base;}
     base SetMapper baseMapper

    if { [info command backPlane] == "" } {vtkCubeSource backPlane;}
    backPlane SetCenter [expr ($maxX + $minX) / 2.0] [expr ($maxY + $minY) / 2.0]  $maxZ
    backPlane SetXLength [expr ($maxX - $minX)]
    backPlane SetYLength [expr ($maxY - $minY)]
    backPlane SetZLength 2

    if { [info command backMapper] == "" } {vtkPolyDataMapper backMapper;}
     backMapper SetInputConnection [backPlane GetOutputPort]
    if { [info command back] == "" } {vtkActor back; ren1 AddActor back;}
   back SetMapper backMapper

    if { [info command rightPlane] == "" } {vtkCubeSource rightPlane;}
    rightPlane SetCenter $minX [expr ($maxY + $minY) / 2.0] [expr ($maxZ + $minZ) / 2.0]
    rightPlane SetXLength 2
    rightPlane SetYLength [expr ($maxY - $minY)]
    rightPlane SetZLength [expr ($maxZ - $minZ)]

    if { [info command rightMapper] == "" } {vtkPolyDataMapper rightMapper;}
     rightMapper SetInputConnection [rightPlane GetOutputPort]
    if { [info command right] == "" } {vtkActor right; ren1 AddActor right;}
     right SetMapper rightMapper

}
