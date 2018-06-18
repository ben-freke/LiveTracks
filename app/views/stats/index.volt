<!DOCTYPE html>
<html lang="en" >

<head>
    <meta charset="UTF-8">
    <title>Stats animation.</title>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/modernizr/2.8.3/modernizr.min.js" type="text/javascript"></script>


    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/meyer-reset/2.0/reset.min.css">


    <link rel="stylesheet" href="/css/stats.css">


</head>

<body>

<!--Graph charts inspired by https://dribbble.com/shots/1876534-Stats-animation?list=following&offset=4-->

<div class="charts-container cf">
    <div class="chart" id="graph-1-container">
        <h2 class="title">Distance Cycled</h2>
        <div class="chart-svg">
            <svg class="chart-line" id="chart-1" viewBox="0 0 80 40">
                <defs>
                    <clipPath id="clip" x="0" y="0" width="80" height="40" >
                        <rect id="clip-rect" x="-80" y="0" width="77" height="38.7"/>
                    </clipPath>

                    <linearGradient id="gradient-1">
                        <stop offset="0" stop-color="#00d5bd" />
                        <stop offset="100" stop-color="#24c1ed" />
                    </linearGradient>

                    <linearGradient id="gradient-2">
                        <stop offset="0" stop-color="#954ce9" />
                        <stop offset="0.3" stop-color="#954ce9" />
                        <stop offset="0.6" stop-color="#24c1ed" />
                        <stop offset="1" stop-color="#24c1ed" />
                    </linearGradient>


                    <linearGradient id="gradient-3" x1="0%" y1="0%" x2="0%" y2="100%">>
                        <stop offset="0" stop-color="rgba(0, 213, 189, 1)" stop-opacity="0.07"/>
                        <stop offset="0.5" stop-color="rgba(0, 213, 189, 1)" stop-opacity="0.13"/>
                        <stop offset="1" stop-color="rgba(0, 213, 189, 1)" stop-opacity="0"/>
                    </linearGradient>


                    <linearGradient id="gradient-4" x1="0%" y1="0%" x2="0%" y2="100%">>
                        <stop offset="0" stop-color="rgba(149, 76, 233, 1)" stop-opacity="0.07"/>
                        <stop offset="0.5" stop-color="rgba(149, 76, 233, 1)" stop-opacity="0.13"/>
                        <stop offset="1" stop-color="rgba(149, 76, 233, 1)" stop-opacity="0"/>
                    </linearGradient>
                </defs>
            </svg>
            <h3 class="valueX">time</h3>
        </div>
        <div class="chart-values">
            <p class="h-value">1689h</p>
            <p class="percentage-value"></p>
            <p class="total-gain"></p>
        </div>
        <div class="triangle green"></div>
    </div>
    <div class="chart" id="graph-2-container">
        <h2 class="title">Hours worked</h2>
        <div class="chart-svg">
            <svg class="chart-line" id="chart-2" viewBox="0 0 80 40">
            </svg>
            <h3 class="valueX">time</h3>
        </div>
        <div class="chart-values">
            <p class="h-value">322h</p>
            <p class="percentage-value"></p>
            <p class="total-gain"></p>
        </div>
        <div class="triangle red"></div>
    </div>
    <div class="chart circle" id="circle-1">
        <h2 class="title">IBApps Website</h2>
        <div class="chart-svg align-center">
            <h2 class="circle-percentage"></h2>
            <svg class="chart-circle" id="chart-3" width="50%" viewBox="0 0 100 100">
                <path class="underlay" d="M5,50 A45,45,0 1 1 95,50 A45,45,0 1 1 5,50"/>
            </svg>
        </div>
        <div class="triangle green"></div>
    </div>
    <div class="chart circle" id="circle-2">
        <h2 class="title">IBApps Website</h2>
        <div class="chart-svg align-center">
            <h2 class="circle-percentage"></h2>
            <svg class="chart-circle" id="chart-4" width="50%" viewBox="0 0 100 100">
                <path class="underlay" d="M5,50 A45,45,0 1 1 95,50 A45,45,0 1 1 5,50"/>
            </svg>
        </div>
        <div class="triangle red"></div>
    </div>
</div>
























<!-- IRRELEVANT - SOCIAL HTML -->
<div class="heartIt">
    <p>If you like it - use it, heart it, fork it, share it!</p>
    <img src="https://s3-us-west-2.amazonaws.com/s.cdpn.io/176026/heart292_(1).png" alt="heart this pen" />
    <p>Thanks!</p>


</div>
<div class="followlinks">
    <a href="http://www.badalic.com">website  </a>
    <a href="https://twitter.com/JonasBadalic"><svg version="1.1" id="Capa_1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" x="0px" y="0px"
                                                    width="32px" height="32px" viewBox="0 0 16 16" enable-background="new 0 0 32 32" xml:space="preserve">
<path d="M8,0C3.582,0,0,3.582,0,8s3.582,8,8,8s8-3.582,8-8C16,3.581,12.418,0,8,0z M11.98,6.204l0.006,0.255
	c0,2.604-1.981,5.604-5.604,5.604c-1.112,0-2.147-0.326-3.019-0.885c0.154,0.018,0.311,0.028,0.47,0.028
	c0.923,0,1.772-0.315,2.446-0.843c-0.862-0.016-1.589-0.586-1.84-1.368C4.56,9.018,4.682,9.029,4.81,9.029
	c0.18,0,0.354-0.023,0.519-0.068c-0.901-0.182-1.58-0.977-1.58-1.931V7.005c0.266,0.148,0.569,0.236,0.892,0.247
	C4.113,6.899,3.765,6.296,3.765,5.613c0-0.361,0.097-0.699,0.266-0.99c0.971,1.192,2.423,1.976,4.06,2.058
	C8.057,6.537,8.04,6.386,8.04,6.232c0-1.087,0.882-1.969,1.97-1.969c0.566,0,1.078,0.239,1.438,0.622
	c0.448-0.089,0.87-0.253,1.251-0.478c-0.147,0.46-0.459,0.846-0.866,1.09c0.397-0.047,0.778-0.154,1.131-0.31
	C12.7,5.581,12.365,5.928,11.98,6.204z"/>
</svg></a>
</div>
<script src='http://cdnjs.cloudflare.com/ajax/libs/jquery/2.1.3/jquery.min.js'></script>
<script src='https://cdnjs.cloudflare.com/ajax/libs/snap.svg/0.3.0/snap.svg-min.js'></script>



<script  src="/js/stats.js"></script>




</body>

</html>
