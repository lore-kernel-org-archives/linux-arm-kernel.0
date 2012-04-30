From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 30 Apr 2012 21:41:08 +0000
Subject: [GIT PULL] ux500-core for ARM SoC
In-Reply-To: <1335369056-5331-1-git-send-email-linus.walleij@linaro.org>
References: <1335369056-5331-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <201204302141.08186.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 25 April 2012, Linus Walleij wrote:
> Daniel Lezcano (1):
>       ARM: ux500: add the cpuidle driver for WFI and ARM retention
> 
> Lee Jones (4):
>       ARM: ux500: Do not attempt to register non-existent i2c devices on Snowball
>       ARM: ux500: Fork cpu-db8500 platform_devs for sequential DT enablement
>       ARM: ux500: Disable SMSC911x platform code registration when DT is enabled
>       ARM: ux500: Enable PRCMU Timer 4 (clocksource) for Device Tree
> 
> Linus Walleij (4):
>       ARM: ux500: core U9540 support
>       ARM: ux500: delete U5500 support
>       mfd/db5500-prcmu: delete DB5500 PRCMU support
>       mfd/ab5500: delete AB5500 support
> 
> Michel Jaouen (1):
>       ARM: ux500: ioremap differences for DB9540
> 

Hi Linus,

Sorry for the delay in my reply. I was going to pull this but noticed
that you have an unfortunate mix of stuff in this branch, and you've done
this better in the past.

Please separate this into more logical branches, e.g.

1. delete u5500
2. add u9540 support
3. device tree patches (why not in the other branch?)

I have applied it to a staging branch for now, which means it gets
coverage in linux-next but I won't send it in the merge window without
further action.

	Arnd
