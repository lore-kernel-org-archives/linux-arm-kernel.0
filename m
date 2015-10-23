From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 23 Oct 2015 22:19:25 +0200
Subject: [GIT PULL] omap dts changes for v4.4 merge window, part 2
In-Reply-To: <20151020193501.GN3078@atomide.com>
References: <20151020193501.GN3078@atomide.com>
Message-ID: <4174355.uUodgcne1B@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 20 October 2015 12:35:02 Tony Lindgren wrote:
> Few more omap dts changes for v4.4 merge window, mostly to fix and clean
> up some omap5 issues to allow adding other omap5 boards. Also some other
> fixes and clean-up:
> 
> - Fix SDIO WLAN for omap5 that's been broken for a while. As further
>   patches are still needed for wl18xx, no need for stable on this one.
> 
> - Move most of omap5 support into omap5-board-common.dtsi as most omap5
>   boards seem to share the same basic set of devices.
> 
> - Add minimal IGEPv5 support using based on omap5-board-common.dtsi
> 
> - Remove now unneedes gpio hogging for dra72-evm
> 
> - Update Javier Martinez Canillas email address
> 
> - Change earlier IGEP boards to use IOPAD pinmux macros
> 

Pulled into next/dt, thanks!

	Arnd
