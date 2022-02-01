# Command Line Cheatsheet

What are some of your favorite/most useful bash commands? Maybe someone else can learn from you too! For more resources, also check out the [dry guide](http://andersenlab.org/dry-guide/latest/bash/)

## General

* `ls | wc -l` - count number of files in a directory
* `find . -name file.txt` or `ls -R * | grep file` - to find files in current directory
* `mv -i` - ask before overwritting a file
* `zcat file.gz` - to quick print a gzipped file
* `wget -bqc <url>` - download file from url in background
* `cat file.tsv | sort -k4` - print and sort file by 4th column (use `sort -k4 -n` for numeric sort)
* `cat file.tsv | awk '{print $4}' | sort | uniq` - to get all unique values in the fourth column
* `grep -v NA file.tsv` - removes all NA from file

## Awk

* `awk '{print $1,$3}'` - prints only 1st and 3rd columns
* `awk '/HIGH/ {print $0}'` - prints all columns for rows containing 'HIGH' (this could also be done using `grep HIGH file.tsv`
* `awk 'NR>1'` - print every line except header
* `awk 'NR==1 || $2<3000 {print $1,$2}'` - print column 1 and 2 for both the header and any row where column 2 is less than 3000

## Sed

* `echo "C. elegans is so elegant" | sed 's/elegan/briggsae/'` - replace first occurance of "elegan" with "briggsae". If you want to replace all occurances of "elegan" use `sed 's/elegan/briggsae/g'`
    - if you are trying to replace a pattern containing '/' you can use another character in the sed command: `sed 's+/projects/b1059/+~/+g'` would replace all "/projects/b1059/" with "~/"

## bcftools

* `bcftools view <vcf>` - view vcf
* `bcftools view -H <vcf>` - view vcf without header
* `bcftools view -h <vcf>` - view vcf only header
* `bcftools view -s sample1,sample2,sample3 <vcf>` - subset vcf for only 3 samples
* `bcftools view -s sample1,sample2,sample3 -I <vcf>` - subset vcf for only 3 samples and do not recalculate AF etc.
* `bcftools view -S sample_list.tsv <vcf>` - subset vcf for only samples within `sample_list.tsv`
* `bcftools view -r III:1-800000 <vcf>` - subset vcf for region
* `bcftools query -l <vcf>` - print out list of all samples in vcf
* `bcftools query -f '%CHROM\t%POS\t%REF\t%ALT[\t%SAMPLE=%GT]\n' <vcf>` - print certain columns of vcf as tsv output
* `bcftools query -i GT=="alt" <vcf>` - filter to only keep rows where GT == "alt" (also `bcftools query -e GT=="ref" <vcf>` to exlude rows)


## gatk
* `gatk VariantsToTable -V <vcf> -F CHROM -F POS -GF GT ` - print certain columns of vcf as tsv output -F for INFO Fields -GF for FORMAT fields. Format field produces column for each sample (Ex. CB4856.GT AB1.GT)
* `gatk SelectVariants -V <vcf> --select-random-fraction <fraction>` - select a set fraction of variants at random from a VCF.

## Git

* `git clone` - clone remote repository
* `git pull` - pull most recent version from remote
* `git add` - add local files to be staged for remote
* `git commit` - stage/commit local changes
* `git push` - push local commits to remote
* `git branch` - list all available branches
* `git checkout` - move to new branch
* `git status` - checks which branch you are on and if you have any unsaved changes
* `git log` - shows log of previous commits on current branch
* `git diff` - shows details of changes made

## Misc.
