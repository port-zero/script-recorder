./ansifilter -H typescript > typescript.html
sed -ie 's/^RECORD&gt;&gt;&gt;\(.*\)$/<div class="command-line">$\1<\/div>/g' typescript.html
sed -ie 's/^CONTINUE&gt;&gt;&gt;\(.*\)$/<div class="command-line continuation">        \1<\/div>/g' typescript.html
sed -ie 's/<\/head>/<link rel="stylesheet" href="bootstrap.css"><\/link><\/head>/g' typescript.html
sed -ie 's/<\/head>/<link rel="stylesheet" href="style.css"><\/link><\/head>/g' typescript.html
#sed -ie 's/<pre\([^>]*\)>/<div\1>/g' typescript.html
#sed -ie 's/<\/pre>/<\/div>/g' typescript.html
