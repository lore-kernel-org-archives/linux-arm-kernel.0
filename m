From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 29 May 2015 13:55:19 +0200
Subject: [GIT PULL] omap device tree changes for v4.2, part 1
In-Reply-To: <20150522202028.GE10274@atomide.com>
References: <20150522202028.GE10274@atomide.com>
Message-ID: <3356447.2K9JD68FjR@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 22 May 2015 13:20:28 Tony Lindgren wrote:
> ----------------------------------------------------------------
> Device tree related changes for omaps:
> 
> - Configure MMC data lines 4..8 for 1.8V IO on boards that
>   are using them as GPIOs instead of MMC data lines
> 
> - Add support for Baltos IR5221
> 
> - Add device tree support for LogicPD Torpedo devkit
> 
> - Add 3717 core pinctrl region
> 
> - Add gta04 1w and GSM audio support
> 
> - Add wilink and ov2659 support for am437x-gp-evm
> 
> - Add am335x-evm bluetooth and mmc3 support
> 
> - Enable omap5-uevm uart wakeup interrupt
> 
> - Enable I2C2 on BeagleBone as it's used for the capes
> 
> - Use defines for LDP GPIO keys
> 
> 

Pulled into next/dt, thanks!

	Arnd
