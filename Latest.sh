#!/bin/bash

# Start creating index.html
cat <<EOF > index.html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>My Reports</title>
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
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 20px;
            width: 90%;
            max-width: 1200px;
            padding: 20px;
        }
        .card {
            background: white;
            padding: 25px 20px;
            border-radius: 12px;
            box-shadow: 0 4px 8px rgba(0,0,0,0.1);
            text-align: center;
            transition: transform 0.2s, box-shadow 0.2s;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
        }
        .card:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 16px rgba(0,0,0,0.2);
        }
        .folder-name {
            font-size: 1.3em;
            font-weight: bold;
            margin-bottom: 8px;
            color: #0066cc;
        }
        .build-date {
            font-size: 0.9em;
            color: #777;
            margin-bottom: 15px;
        }
        .links {
            display: flex;
            flex-direction: column;
            gap: 10px;
        }
        .links a {
            text-decoration: none;
            background-color: #0066cc;
            color: white;
            padding: 10px 15px;
            border-radius: 8px;
            font-weight: 500;
            transition: background-color 0.3s;
        }
        .links a:hover {
            background-color: #004a99;
        }
    </style>
</head>
<body>
    <h1>Available Reports</h1>
    <div class="container">
EOF

# List folders sorted by last modified (newest first)
for folder in $(ls -dt */); do
    foldername=${folder%/} # remove trailing slash
    modified_date=$(date -r "$folder" "+%Y-%m-%d %H:%M")
    cat <<EOF >> index.html
        <div class="card">
            <div class="folder-name">$foldername</div>
            <div class="build-date">Built on: $modified_date</div>
            <div class="links">
                <a href="$foldername/index.html" target="_blank">Allure Report</a>
                <a href="$foldername/cucumber.html" target="_blank">Cucumber Report</a>
            </div>
        </div>
EOF
done

# Finish HTML
cat <<EOF >> index.html
    </div>
</body>
</html>
EOF

echo "index.html generated successfully with build date!"
