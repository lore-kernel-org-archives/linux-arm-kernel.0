From: f.fainelli@gmail.com (Florian Fainelli)
Date: Sat, 13 May 2017 11:54:28 -0700
Subject: [PATCH 4/4] ARM: ep93xx: Add lm70 HWMON sensor to TS-72xx boards
In-Reply-To: <20170221181529.6780-5-hsweeten@visionengravers.com>
References: <20170221181529.6780-1-hsweeten@visionengravers.com>
 <20170221181529.6780-5-hsweeten@visionengravers.com>
Message-ID: <847a53a4-a1cb-9e96-9e2b-8697b755028c@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 02/21/17 ? 10:15, H Hartley Sweeten a ?crit :
> Register the TI TMP122 (lm70) temperature sensor driver for the TS-72xx
> boards.
> 
> Originaly from Florian Fainelli. Updated to the new spi-ep93xx chip select
> method.
> 
> Signed-off-by: H Hartley Sweeten <hsweeten@visionengravers.com>
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>

Tested-by: Florian Fainelli <f.fainelli@gmail.com>

root at LEDE:/# cat /sys/class/hwmon/hwmon0/temp1_input
38250
-- 
Florian
