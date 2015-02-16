From: kaloz@openwrt.org (Imre Kaloz)
Date: Mon, 16 Feb 2015 15:11:57 +0100
Subject: [PATCHv6 2/2] leds: tlc591xx: Driver for the TI 8/16 Channel i2c
 LED driver
In-Reply-To: <1422367161-16487-3-git-send-email-andrew@lunn.ch>
References: <1422367161-16487-1-git-send-email-andrew@lunn.ch>
 <1422367161-16487-3-git-send-email-andrew@lunn.ch>
Message-ID: <op.xt5lp7ix2s3iss@ecaz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andrew,

On Tue, 27 Jan 2015 14:59:21 +0100, Andrew Lunn <andrew@lunn.ch> wrote:

> The TLC59116 is an I2C bus controlled 16-channel LED driver.  The
> TLC59108 is an I2C bus controlled 8-channel LED driver, which is very
> similar to the TLC59116. Each LED output has its own 8-bit
> fixed-frequency PWM controller to control the brightness of the LED.
> The LEDs can also be fixed off and on, making them suitable for use as
> GPOs.
>
> This is based on a driver from Belkin, but has been extensively
> rewritten and extended to support both 08 and 16 versions.
>
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> Cc: Matthew.Fatheree at belkin.com

I've tested the driver on the Mamba (WRT1900AC) and it has been integrated  
to OpenWrt trunk for a while now, and no issues has been reported by the  
community either.

Please feel free to add Tested-by: Imre Kaloz <kaloz@openwrt.org>.


Thanks,

Imre
