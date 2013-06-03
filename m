From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 03 Jun 2013 04:07:37 +0200
Subject: arm: add basic support for Rockchip Cortex-A9 SoCs
In-Reply-To: <201306030055.15413.heiko@sntech.de>
References: <201306030055.15413.heiko@sntech.de>
Message-ID: <2754292.oXzDNzH2Zs@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 03 June 2013 00:55:15 Heiko St?bner wrote:
> Prepare your eggs and tomatoes please, I got myself a second playground  .
> 
> As the title implies this series adds basic support for Rockchip's Cortex-A9
> SoCs, like the RK3066 used in many cheaper tablets.
> 
> On the periphal side it's very lightweight, as it seems someone from Rockchip
> was shopping in the DesignWare store.
> 
> This makes the pinctrl driver the biggest hunk in the series, but to get some
> bonus points I used the generic_irq implementation for the interrupt handling,
> based on Thomas' irqdomain support series.
> 
> Supported periphals are, the timers, uarts and mmc controllers, so interested
> parties will need a serial console for now.
> 
> Hopefully I didn't mess up to much 

Great stuff! I have a few small comments for later, but I'm basically fine
with it going in as-is.

Needs review from the clk and pinctrl maintainers of course.

	Arnd
