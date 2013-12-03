#
# This script was written by Jim Miller and Bill Lorensen in January 1998
# It was inspired by the cover of the book: Godel, Escher and Bach
#

package require vtk
package require vtkinteraction
package require vtktesting

source colors.tcl
source room.tcl

set VTK_IMAGE_X_AXIS             0
set VTK_IMAGE_Y_AXIS             1
set VTK_IMAGE_Z_AXIS             2

# Create the RenderWindow and Renderer
#
vtkRenderer ren1
vtkRenderWindow renWin
    renWin AddRenderer ren1
vtkRenderWindowInteractor iren
    iren SetRenderWindow renWin

# Read in a blank image (white) with a black border (the border forces marching
# cubes to extract a cube)
vtkPNMReader block
  block SetFileName "blank.ppm"
  block AddObserver StartEvent "puts -nonewline \"Read block...\";flush stdout"
  block AddObserver EndEvent "puts \"Complete\""

vtkImageExtractComponents extractComponentsBlock
  extractComponentsBlock SetInputConnection [block GetOutputPort]
  extractComponentsBlock SetComponents 0
  extractComponentsBlock AddObserver StartEvent "puts -nonewline \"Extract block...\";flush stdout"
  extractComponentsBlock AddObserver EndEvent "puts \"Complete\""

# sweep out the block
vtkImageWrapPad padBlock
  padBlock SetInputConnection [extractComponentsBlock GetOutputPort]
  padBlock SetOutputWholeExtent 0 359 0 359 1 358
  padBlock AddObserver StartEvent "puts -nonewline \"Pad block...\";flush stdout"
  padBlock AddObserver EndEvent "puts \"Complete\""

# pad the front and back of block with zeros (first and last z plane) so 
# marching cubes will extract a cube from the data set
vtkImageConstantPad constantPadBlock
  constantPadBlock SetInputConnection [padBlock GetOutputPort]
  constantPadBlock SetConstant 0
  constantPadBlock SetOutputWholeExtent 0 359 0 359 0 359
  constantPadBlock AddObserver StartEvent "puts -nonewline \"Constant Pad block...\";flush stdout"
  constantPadBlock AddObserver EndEvent "puts \"Complete\""

# Letter V
vtkPNMReader letterV
  letterV SetFileName "vp3.ppm"
  letterV AddObserver StartEvent "puts -nonewline \"Read v...\";flush stdout"
  letterV AddObserver EndEvent "puts \"Complete\""

vtkImageExtractComponents extractComponentsV
  extractComponentsV SetInputConnection [letterV GetOutputPort]
  extractComponentsV SetComponents 0
  extractComponentsV AddObserver StartEvent "puts -nonewline \"Extract v...\";flush stdout"
  extractComponentsV AddObserver EndEvent "puts \"Complete\""

vtkImageWrapPad padV
  padV SetInputConnection [extractComponentsV GetOutputPort]
  padV SetOutputWholeExtent 0 359 0 359 0 359 
  padV AddObserver StartEvent "puts -nonewline \"Pad v...\";flush stdout"
  padV AddObserver EndEvent "puts \"Complete\""

vtkImageConstantPad contantPadV
  contantPadV SetInputConnection [padV GetOutputPort]
  contantPadV SetConstant 255
  contantPadV SetOutputWholeExtent 0 359 0 359 0 359 
  contantPadV AddObserver StartEvent "puts -nonewline \"Constant Pad v...\";flush stdout"
  contantPadV AddObserver EndEvent "puts \"Complete\""

# Letter T
vtkPNMReader letterT
  letterT SetFileName "tp3.ppm"
  letterT AddObserver StartEvent "puts -nonewline \"Read t...\";flush stdout"
  letterT AddObserver EndEvent "puts \"Complete\""

vtkImageFlip flipT
  flipT SetInputConnection [letterT GetOutputPort]
  flipT SetFilteredAxes $VTK_IMAGE_X_AXIS 
  flipT AddObserver StartEvent "puts -nonewline \"Flip t...\";flush stdout"
  flipT AddObserver EndEvent "puts \"Complete\""

vtkImageExtractComponents extractComponentsT
  extractComponentsT SetInputConnection [flipT GetOutputPort]
  extractComponentsT SetComponents 0
  extractComponentsT AddObserver StartEvent "puts -nonewline \"Extract t...\";flush stdout"
  extractComponentsT AddObserver EndEvent "puts \"Complete\""

vtkImagePermute permuteT
  permuteT SetInputConnection [extractComponentsT GetOutputPort]
  permuteT SetFilteredAxes $VTK_IMAGE_Z_AXIS $VTK_IMAGE_Y_AXIS $VTK_IMAGE_X_AXIS
  permuteT AddObserver StartEvent "puts -nonewline \"Permute t...\";flush stdout"
  permuteT AddObserver EndEvent "puts \"Complete\""

vtkImageWrapPad padT
  padT SetInputConnection [permuteT GetOutputPort]
  padT SetOutputWholeExtent 0 359 0 359 0 359 
  padT AddObserver StartEvent "puts -nonewline \"Pad t...\";flush stdout"
  padT AddObserver EndEvent "puts \"Complete\""

vtkImageConstantPad constantPadT
  constantPadT SetInputConnection [padT GetOutputPort]
  constantPadT SetConstant 255
  constantPadT SetOutputWholeExtent 0 359 0 359 0 359 
  constantPadT AddObserver StartEvent "puts -nonewline \"Constant Pad t...\";flush stdout"
  constantPadT AddObserver EndEvent "puts \"Complete\""

# Letter K
vtkPNMReader letterK
  letterK SetFileName "kp3.ppm"
  letterK AddObserver StartEvent "puts -nonewline \"Read k...\";flush stdout"
  letterK AddObserver EndEvent "puts \"Complete\""

vtkImageExtractComponents extractComponentsK
  extractComponentsK SetInputConnection [letterK GetOutputPort]
  extractComponentsK SetComponents 0
  extractComponentsK AddObserver StartEvent "puts -nonewline \"Extract k...\";flush stdout"
  extractComponentsK AddObserver EndEvent "puts \"Complete\""

vtkImagePermute permuteK
  permuteK SetInputConnection [extractComponentsK GetOutputPort]
  permuteK SetFilteredAxes $VTK_IMAGE_X_AXIS $VTK_IMAGE_Z_AXIS $VTK_IMAGE_Y_AXIS
  permuteK AddObserver StartEvent "puts -nonewline \"Permute k...\";flush stdout"
  permuteK AddObserver EndEvent "puts \"Complete\""

vtkImageFlip flipK
  flipK SetInputConnection [permuteK GetOutputPort]
  flipK SetFilteredAxes $VTK_IMAGE_X_AXIS 
  flipK AddObserver StartEvent "puts -nonewline \"Flip k...\";flush stdout"
  flipK AddObserver EndEvent "puts \"Complete\""

vtkImageWrapPad padK
  padK SetInputConnection [flipK GetOutputPort]
  padK SetOutputWholeExtent 0 359 0 359 0 359 
  padK AddObserver StartEvent "puts -nonewline \"Pad k...\";flush stdout"
  padK AddObserver EndEvent "puts \"Complete\""

vtkImageConstantPad constantPadK
  constantPadK SetInputConnection [padK GetOutputPort]
  constantPadK SetConstant 255
  constantPadK SetOutputWholeExtent 0 359 0 359 0 359 
  constantPadK AddObserver StartEvent "puts -nonewline \"Constant Pad k...\";flush stdout"
  constantPadK AddObserver EndEvent "puts \"Complete\""

############################################################
constantPadBlock Update
contantPadV Update
vtkImageLogic logic0
  logic0 SetInput1Data [constantPadBlock GetOutput]
  logic0 SetInput2Data [contantPadV GetOutput]
  logic0 SetOutputTrueValue 255
  logic0 SetOperationToAnd
  logic0 AddObserver StartEvent "puts -nonewline \"Logic v...\";flush stdout"
  logic0 AddObserver EndEvent "puts \"Complete\""

logic0 Update
constantPadT Update
vtkImageLogic logic1
  logic1 SetInput1Data [logic0 GetOutput]
  logic1 SetInput2Data [constantPadT GetOutput]
  logic1 SetOutputTrueValue 255
  logic1 SetOperationToAnd
  logic1 AddObserver StartEvent "puts -nonewline \"Logic v,t...\";flush stdout"
  logic1 AddObserver EndEvent "puts \"Complete\""

logic1 Update
constantPadK Update
vtkImageLogic logic2
  logic2 SetInput1Data [logic1 GetOutput]
  logic2 SetInput2Data [constantPadK GetOutput]
  logic2 SetOutputTrueValue 255
  logic2 SetOperationToAnd
  logic2 AddObserver StartEvent "puts -nonewline \"Logic v,t,k...\";flush stdout"
  logic2 AddObserver EndEvent "puts \"Complete\""

vtkImageShrink3D shrink
  shrink SetInputConnection [logic2 GetOutputPort]
  shrink SetShrinkFactors 2 2 2
  shrink AveragingOn

vtkMarchingCubes mc
  mc ReleaseDataFlagOn
  mc SetInputConnection [shrink GetOutputPort]
  mc SetValue 0 127.5
  mc AddObserver StartEvent "puts -nonewline \"March...\";flush stdout"
  mc AddObserver ProgressEvent "puts -nonewline \".\";flush stdout"
  mc AddObserver EndEvent "puts \"Complete\""

vtkWindowedSincPolyDataFilter smoothPD
  smoothPD ReleaseDataFlagOn
  smoothPD SetInputConnection [mc GetOutputPort]
  smoothPD SetNumberOfIterations 30
  smoothPD SetPassBand .001
  smoothPD AddObserver StartEvent "puts -nonewline \"SmoothPD...\";flush stdout"
  smoothPD AddObserver EndEvent "puts \"Complete\""

vtkPolyDataNormals normals
  normals ReleaseDataFlagOn
  normals SetInputConnection [smoothPD GetOutputPort]
  normals AddObserver StartEvent "puts -nonewline \"Normals...\";flush stdout"
  normals AddObserver EndEvent "puts \"Complete\""

vtkPolyDataMapper mapper
  mapper SetInputConnection [normals GetOutputPort]
  mapper ScalarVisibilityOff

vtkActor actorVTK
  actorVTK SetMapper mapper
  [actorVTK GetProperty] SetSpecular .4
  eval [actorVTK GetProperty] SetDiffuseColor $cornflower
  [actorVTK GetProperty] SetSpecularPower 30

#
# Add the actor to the renderer
#
ren1 AddActor actorVTK

padV SetOutputWholeExtent 0 359 0 359 0 359 
padT SetOutputWholeExtent 0 359 0 359 0 359 
padK SetOutputWholeExtent 0 359 0 359 0 359 

#
# Compute the bounds of the actor
#
set bounds [actorVTK GetBounds]
set minX [lindex $bounds 0]
set maxX [lindex $bounds 1]
set minY [lindex $bounds 2]
set maxY [lindex $bounds 3]
set minZ [lindex $bounds 4]
set maxZ [lindex $bounds 5]
set offset .6
set dX [expr $maxX - $minX]
set dY [expr $maxY - $minY]
set dZ [expr $maxZ - $minZ]

source squish.tcl

BuildRoom [expr $minX - $offset * $dX] [expr $maxX + $offset * $dX] \
          [expr $minY - $offset * $dY] [expr $maxY + $offset * $dY] \
          [expr $minZ - $offset * $dZ] [expr $maxZ + $offset * $dZ]
ren1 SetBackground 0.1 0.2 0.4
ren1 ResetCamera
renWin SetSize 640 480

#
# Define a good view
#
eval [ren1 GetActiveCamera] SetFocalPoint [[ren1 GetActiveCamera] GetFocalPoint]
[ren1 GetActiveCamera] SetViewUp -0.469154 0.740054 0.481886
[ren1 GetActiveCamera] SetPosition 1211.52 1418.5 -719.105
[ren1 GetActiveCamera] OrthogonalizeViewUp
ren1 ResetCameraClippingRange

vtkSTLWriter writer
writer SetFileName vtkgeb.stl
writer SetInputConnection [normals GetOutputPort]
writer Write

#
# Render the image
#
iren AddObserver UserEvent {wm deiconify .vtkInteract; raise .vtkInteract}
iren Initialize
iren Start

# prevent the tk window from showing up then start the event loop
wm withdraw .

source record.tcl
set recording 0
set frame 100
proc Render {} {
    global frame
    puts "----------------- [expr [lindex [time {renWin Render} 1] 0] / 1000000.] seconds"
#    record
    catch {vtkRendererSource captureImage}
      captureImage SetInput ren1
      captureImage Modified
    catch {vtkPNGWriter writer}
      writer SetInput [captureImage GetOutput]
      writer SetFileName Movie/frame$frame.png
      writer Write
    incr frame
}

#
# Procedure to bore "VTK" out of a block...
#

proc Bore {increment} {
    # reset the volume to a block
    padV SetOutputWholeExtent 0 359 0 359 0 0 
    padT SetOutputWholeExtent 359 359 0 359 0 359 
    padK SetOutputWholeExtent 0 359 359 359 0 359

    # v
    for { set i 0} { $i <= 359} { set i [expr $i + $increment] } {
	padV SetOutputWholeExtent 0 359 0 359 0 $i 
	Render
    }
    if { $i != 359} {
	padV SetOutputWholeExtent 0 359 0 359 0 359 
        Render
    }

    # t
    for { set i 359} { $i >= 0} { set i [expr $i - $increment] } {
	padT SetOutputWholeExtent $i 359 0 359 0 359 
	Render
    }

    if { $i != 0} {
        padT SetOutputWholeExtent 0 359 0 359 0 359 
        Render
    }


    # k
    for { set i 359} { $i >= 0} { set i [expr $i - $increment] } {
	padK SetOutputWholeExtent 0 359 $i 359 0 359 
	Render
    }
    if { $i != 0} {
        padK SetOutputWholeExtent 0 359 0 359 0 359 
        Render
    }
}

# Bore 20
