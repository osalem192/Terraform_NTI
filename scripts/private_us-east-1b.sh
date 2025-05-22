#!bin/bash
sudo yum update -y
sudo yum install httpd -y    
sudo systemctl enable --now httpd       
sudo cat << 'EOF' > /var/www/html/index.html
<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="UTF-8">
  <title>Support Palestine</title>
  <style>
    body {
      margin: 0;
      padding: 0;
      background-color: #111;
      color: white;
      font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
      display: flex;
      justify-content: center;
      align-items: center;
      height: 100vh;
    }

    .card {
      background: #1e1e1e;
      border: 2px solid #333;
      padding: 40px;
      border-radius: 15px;
      box-shadow: 0 0 15px rgba(0, 255, 0, 0.2);
      text-align: center;
      max-width: 400px;
    }

    .title {
      font-size: 32px;
      font-weight: bold;
      margin-bottom: 20px;
    }

    .title .red {
      color: #d10000;
    }

    .title .black {
      color: #000;
      background-color: white;
      padding: 0 5px;
      border-radius: 3px;
    }

    .title .green {
      color: #00aa00;
    }

    .line {
      height: 5px;
      width: 100%;
      background: linear-gradient(to right, black 33.3%, white 33.3% 66.6%, green 66.6%);
      margin: 20px 0;
      border-radius: 5px;
    }

    .hashtag {
      font-size: 20px;
      color: #ccc;
      text-shadow: 0 0 5px rgba(255, 255, 255, 0.2);
    }
  </style>
</head>

<body>
  <div class="card">
    <div class="title">
      <span class="red">Palestine</span>
      <span class="black">will be</span>
      <span class="green">Free</span>
    </div>
    <div class="line"></div>
    <div class="hashtag">#WeStandWithPalestine</div>
  </div>
</body>

</html>
EOF
sudo systemctl restart httpd
