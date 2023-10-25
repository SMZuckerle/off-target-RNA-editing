###CSV input#2##

in_csv=INPUTFILE.csv	#input csv-file (no header row,delimiter TABs !!!)
in_pos=1			#input cloumn of editing pos
in_rev=2			#input column of rev-indicator (0=fwd,1=rev)
out_n=FILENAME_OUT		#name of output file (important must end with .csv)
###Calculation Parameters###
b_edit=10			#start extraction x nucleotides in front of edit
a_edit=10			#end extraction x nucleotides after edit
###Fasta input###
in_fas=INPUTFASTA.fasta	#input fasta file (sequence one-line!!!)

#################### Magic, do not touch ;) ###############
echo Start
###Gathering information###

echo "Gathering information"
pos=(`cut -f$in_pos $in_csv`)
rev=(`cut -f$in_rev $in_csv`)


###Calculate extraction position###
echo "Calculate extraction position"

let x=`grep -c '.' "$in_csv"`-1

for i in $(seq 0 $x)
	do
		if [ ${rev[$i]} -eq 0 ]
			then
				expr ${pos[$i]} - $b_edit >>c_st
				expr ${pos[$i]} + $a_edit >>c_end
			else
				expr ${pos[$i]} - $a_edit >>c_st
				expr ${pos[$i]} + $b_edit >>c_end
		fi
	done

###Extract sequence###
echo "Start extraction"

grep -v '>' $in_fas >fas_clean
cst=(`cat c_st`)
cend=(`cat c_end`)

for i in $(seq 0 $x)
	do
		cut -c ${cst[$i]}-${cend[$i]} fas_clean >> ext_seq
	done


###Rev Comp Sequence###
echo "Reverse complement marked sequences"

ex_s=(`cat ext_seq`)

for i in $(seq 0 $x)
	do
		if [ ${rev[$i]} -eq 0 ]
			then
				echo ${ex_s[$i]} >>ext_seq_cor
			else
				echo ${ex_s[$i]} | rev | tr ATCG TAGC >>  ext_seq_cor
		fi
	done


###Add Sequence to csv###
echo "Generate output"
paste $in_csv ext_seq_cor > "$out_n".csv  #### add column to file

sed -r  's/([AGTC])/\1\t/g' "$out_n".csv > "$out_n"_tabed.csv

echo "Finished ;)"

echo "Viel Spaß mit Phil's wundersamen Skripten"

###Cleaning up###
rm c_st c_end ext_seq fas_clean ext_seq_cor
