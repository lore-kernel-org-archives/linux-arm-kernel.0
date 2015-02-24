From: tony@atomide.com (Tony Lindgren)
Date: Tue, 24 Feb 2015 10:02:39 -0800
Subject: [PATCH 1/2] arm: boot: dts: am437x-idk: fix TPS62362 i2c bus
In-Reply-To: <1424369035-26423-1-git-send-email-balbi@ti.com>
References: <1424369035-26423-1-git-send-email-balbi@ti.com>
Message-ID: <20150224180239.GD11056@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Felipe Balbi <balbi@ti.com> [150219 10:08]:
> As it turns out, tps62362 is actually on I2C bus0,
> not bus1. This has gone unnoticed because Linux
> doesn't use (as of now) that regulator at all, it's
> setup by the bootloader and left as is.
> 
> While at that, also add missing reg property for
> our regulator.

Applying both into omap-for-v4.0/fixes thanks.

Tony
