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
      font-family: Arial, sans-serif;
      background-color: #f4f4f4;
      display: flex;
      justify-content: center;
      align-items: center;
      height: 100vh;
      flex-direction: column;
    }

    .flag {
      width: 300px;
      height: 180px;
      position: relative;
      margin-bottom: 20px;
    }

    .flag .black {
      background-color: black;
      height: 33.33%;
      width: 100%;
    }

    .flag .white {
      background-color: white;
      height: 33.33%;
      width: 100%;
    }

    .flag .green {
      background-color: green;
      height: 33.33%;
      width: 100%;
    }

    .flag .triangle {
      position: absolute;
      left: 0;
      top: 0;
      width: 0;
      height: 0;
      border-top: 90px solid transparent;
      border-bottom: 90px solid transparent;
      border-left: 130px solid red;
    }

    .message {
      font-size: 24px;
      font-weight: bold;
      color: #333;
    }

    .message span {
      color: #d10000;
    }

    .hashtag {
      margin-top: 10px;
      font-size: 18px;
      color: #555;
    }
  </style>
</head>

<body>
  <div class="flag">
    <div class="black"></div>
    <div class="white"></div>
    <div class="green"></div>
    <div class="triangle"></div>
  </div>
  <div class="message">Palestine Will Be <span>Free</span></div>
  <div class="hashtag">#WeStandWithPalestine</div>
</body>

</html>
EOF
sudo systemctl restart httpd
