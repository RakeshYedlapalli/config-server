#!/bin/bash

# Start creating index.html
cat <<EOF > index.html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>My Projects</title>
    <style>
        body {
            background: linear-gradient(to right, #6a11cb, #2575fc);
            font-family: Arial, sans-serif;
            color: white;
            text-align: center;
            margin: 0;
            padding: 0;
        }
        h1 {
            margin-top: 30px;
            font-size: 3em;
        }
        ul {
            list-style: none;
            padding: 0;
            margin-top: 40px;
        }
        li {
            margin: 20px 0;
            font-size: 1.5em;
        }
        a {
            text-decoration: none;
            color: #ffffff;
            background-color: #00000033;
            padding: 10px 20px;
            border-radius: 10px;
            transition: background-color 0.3s, color 0.3s;
        }
        a:hover {
            background-color: #ffffff;
            color: #2575fc;
        }
    </style>
</head>
<body>
    <h1>Available Projects</h1>
    <ul>
EOF

# Add all folders as list items
for folder in */; do
    foldername=${folder%/} # remove trailing slash
    echo "        <li><a href=\"$foldername/index.html\">$foldername</a></li>" >> index.html
done

# Finish HTML
cat <<EOF >> index.html
    </ul>
</body>
</html>
EOF

echo "index.html generated successfully!"
