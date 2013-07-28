From: linux@prisktech.co.nz (Tony Prisk)
Date: Mon, 29 Jul 2013 06:53:33 +1200
Subject: Board-specific GPIO setup code
Message-ID: <51F568AD.8030001@prisktech.co.nz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On the Wandboard (IMX6Q SoC), there is a WiFi module connected via SDIO 
that requires a reset procedure to enable it. This would be board 
specific setup, but gpio_* functions can't be used in 
arch/arm/mach-imx/imx6q.c

What would be the correct place to perform the reset code (basically a 
series of gpio calls) to reset the WiFi controller or should it be done 
earlier in uboot?

Regards
Tony Prisk
