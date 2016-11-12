From: tony@atomide.com (Tony Lindgren)
Date: Sat, 12 Nov 2016 09:01:53 -0800
Subject: [PATCH] ARM: dts: Add minimal support for motorola droid 4 xt894
In-Reply-To: <20161112165759.17316-1-tony@atomide.com>
References: <20161112165759.17316-1-tony@atomide.com>
Message-ID: <20161112170152.GO7138@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Tony Lindgren <tony@atomide.com> [161112 08:58]:
> Let's add minimal support for droid 4 with MMC and WLAN working.
> It can be booted with appended dtb using kexec to a state where
> MMC and WLAN work with currently no support for it's PMIC or
> display.
> 
> Note that we are currently using fixed regulators as we don't
> have support for it's cpcap PMIC. I'll be posting regmap_spi
> based minimal cpcap patches later on for USB and the debug
> UART on droid 4 multiplexed with the USB connector.

I also posted some notes on the UART wiring at [0].

Regards,

Tony


[0] http://muru.com/linux/d4/
