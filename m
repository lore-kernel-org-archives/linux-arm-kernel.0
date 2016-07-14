From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 14 Jul 2016 15:17:02 +0200
Subject: [GIT PULL] omap2plus_defconfig fix for v4.8 merge window
In-Reply-To: <20160711161112.GA28563@atomide.com>
References: <20160711161112.GA28563@atomide.com>
Message-ID: <6564922.rj3i88MBX8@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday, July 11, 2016 9:11:12 AM CEST Tony Lindgren wrote:
> A defconfig update for omap2plus_defconfig to fix changed USB
> Kconfig dependencies for v4.8 merge window. Otherwise things
> like USB Ethernet on omap3 beagle, omap4 panda and omap5-uevm
> won't work without manual configuration.
> 

Pulled into next/defconfig, thanks!

	Arnd
