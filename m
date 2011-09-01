From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 01 Sep 2011 21:14:07 +0200
Subject: [PATCH 00/13] OMAP4: Add DT support for i2c and twl6030
In-Reply-To: <1314897689-17791-1-git-send-email-b-cousson@ti.com>
References: <1314897689-17791-1-git-send-email-b-cousson@ti.com>
Message-ID: <2756178.9Ir4cpMAU8@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 01 September 2011 19:21:16 Benoit Cousson wrote:
> This is a rework of the original series done by Manju:
> http://www.spinics.net/lists/linux-omap/msg55827.html
> 
> It fixes the main issue of the previous series that was not booting at all
> due to the lack of twl support. That fix is mandatory to allow further
> work on the regulators DT bindings.
> In order to have a minimal i2c support, both i2c and twl must be added
> at the same time.
> Please note than some patches can be reshuffle with the previous OMAP4
> series to avoid the intermediate step with static i2c initialization.
> 
> That series is as well using the hwmods binding introduced in my previous
> series.
> The OMAP3/beagle support will be added in an other series.
> 
> A couple of basic i2c devices are added for panda and sdp board.
> 
> Patches are based on for_3.2/4_omap4_dt_early_devices + devicetree/test
> and are available here:
> git://gitorious.org/omap-pm/linux.git for_3.2/5_omap_dt_i2c_twl
> 
> Tested on PandaBoard and sdp4430.

I think this is great stuff. I missed the original series, but
it's definitely good to see progress on this!

	Arnd
