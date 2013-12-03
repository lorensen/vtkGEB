
vtkActor sX
  sX SetMapper mapper 
  sX SetScale .001 1 1
  sX SetPosition [expr $minX - $offset * $dX + 2] 0 0

vtkActor sY
  sY SetMapper mapper 
  sY SetScale 1 .001 1
  sY SetPosition 0 [expr $minY - $offset * $dY + 2] 0

vtkActor sZ
  sZ SetMapper mapper 
  sZ SetScale 1 1 .001
  sZ SetPosition 0 0 [expr $maxZ + $offset * $dZ - 2]

[sX GetProperty] SetColor 0 0 0
[sY GetProperty] SetColor 0 0 0
[sZ GetProperty] SetColor 0 0 0

ren1 AddActor sX
ren1 AddActor sY
ren1 AddActor sZ


