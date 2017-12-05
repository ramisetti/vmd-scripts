set sel1 [atomselect top "resname CAS or resname C3S"] 
set sel2 [atomselect top "resname CAT or resname C3T"]

set nf [molinfo top get numframes]

set outfile [open "comdist.txt" w]

for {set i 0} {$i < $nf} {incr i} { 
    puts "frame $i of $nf" 
    $sel1 frame $i
    $sel2 frame $i 
    set com1 [measure center $sel1 weight mass]
    set com2 [measure center $sel2 weight mass]
    set simdata($i.r) [veclength [vecsub $com1 $com2]]
    puts $outfile "$i $simdata($i.r) $com1 $com2"
}
close $outfile
