proc com {args} {
    set usage {com "selection1 selection2" 
Example: com "resname CAT or resname CAS" "resname C3T or resname C3S"
comdist.txt is the output file}
    if {[llength $args] < 2} {
        error "wrong # args: should be $usage"
    }
    set arg1 [lindex $args 0]
    set arg2 [lindex $args 1]

    set sel1 [atomselect top "$arg1"] 
    set sel2 [atomselect top "$arg2"]

    set nf [molinfo top get numframes]
    set outfile [open "comdist.txt" w]

    puts $outfile "#frameNo distance com1_x com1_y com1_z com2_x com2_y com2_z"
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
}
