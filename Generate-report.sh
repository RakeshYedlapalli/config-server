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
            background: #f5f7fa;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            color: #333;
            margin: 0;
            padding: 0;
            display: flex;
            flex-direction: column;
            align-items: center;
            min-height: 100vh;
        }
        h1 {
            margin: 40px 0 20px;
            font-size: 2.5em;
            color: #222;
        }
        .container {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 20px;
            width: 90%;
            max-width: 1000px;
            padding: 20px;
        }
        .card {
            background: white;
            padding: 30px 20px;
            border-radius: 12px;
            box-shadow: 0 4px 8px rgba(0,0,0,0.1);
            text-align: center;
            transition: transform 0.2s, box-shadow 0.2s;
        }
        .card:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 16px rgba(0,0,0,0.2);
        }
        .card a {
            text-decoration: none;
            color: #0066cc;
            font-size: 1.2em;
            font-weight: bold;
        }
    </style>
</head>
<body>
    <h1>Available Projects</h1>
    <div class="container">
EOF

# Add all folders as cards
for folder in */; do
    foldername=${folder%/} # remove trailing slash
    echo "        <div class=\"card\"><a href=\"$foldername/index.html\">$foldername</a></div>" >> index.html
done

# Finish HTML
cat <<EOF >> index.html
    </div>
</body>
</html>
EOF

echo "index.html generated successfully with clean UI!"
