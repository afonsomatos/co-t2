#!/bin/bash
root=tests_p2

# Test part 1
output=$(./p1.sh)
if [[ $? -ne 0 ]]; then
    echo "part 1 tests not passing:"
    echo "$output" | grep FAILED
    exit 1
else
    echo "part 1 tests passing"
fi

count=$(find "$root" | grep test.min | wc -l)
echo "$count tests were detected"
echo

# Compile
cd ../src
srcDir=$(pwd)
make clean && make
if [[ $? -ne 0 ]]; then
    echo "make failed!"
    exit 1
fi
cd -

level=0
pass=0
total=0

function secho {
    for d in $(seq 1 $level); do
        printf "  "
    done
    printf "$1\n"
}

function testDir {
    secho "\e[33m$(basename $1)\e[0m"
    ((level++))
    local save=$(pwd)
    cd $1
    if [[ -f "test.min" ]]; then
        
        # Generate program
        this=$(pwd)
        $srcDir/minor < "test.min" &> /dev/null
        cp out.asm $srcDir
        cd $srcDir
        make out &> /dev/null
        mv out $this/a.out
        cd - &> /dev/null


        for f in $(ls | grep "\.in"); do

            base=$(basename $f .in)

            # Run test
            ./a.out < $f > $base.myout
            echo $? > $base.myret 

            # Check output
            diff $base.myout $base.out > $base.diff
            equal=$?
            
            # Assume ret code of 0
            if [[ ! -f $base.ret ]]; then
                echo 0 > $base.ret
            fi

            diff $base.myret $base.ret -q &>/dev/null
            equalRet=$?

            if [[ $equal -eq 0 ]] && [[ $equalRet -eq 0 ]]; then
                secho "\e[36m$f\e[0m - \e[32mPASSED\e[0m"
                ((pass++))
            else
                secho "\e[36m$f\e[0m - \e[31mFAILED\e[0m"
                ((level++))
                if [[ ! $equal ]]; then
                    secho "out files differ"
                else
                    secho "$(printf "ret code differs: expected %s but got %s" $(cat $base.ret)  $(cat $base.myret))"
                fi
                ((level--))
            fi
            ((total++))
        done

    fi
    for f in $(ls -d */ 2>/dev/null); do
        testDir $f
    done
    cd $save
    ((level--))
}

results=""
cd $root
for l in $(ls -d */ 2>/dev/null); do
   pass=0
   total=0
   testDir "$l"
   l=$(basename $l)
   results=$results"$l\tpassed $pass/$total\n"
done

echo
echo -e "\e[1;35mresults\e[0m\n"$results | column -ts $'\t'
