From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 4 May 2012 20:26:14 +0000
Subject: [PATCH 00/15] DT enablement for Snowball
In-Reply-To: <1336155805-18554-1-git-send-email-lee.jones@linaro.org>
References: <1336155805-18554-1-git-send-email-lee.jones@linaro.org>
Message-ID: <201205042026.14614.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 04 May 2012, Lee Jones wrote:
> 
> Here's your next back of DT related doings for the ux500,
> along with some bugs encountered fixed along the way.
> 
>  arch/arm/boot/dts/db8500.dtsi      |  103 +++++++++++++-
>  arch/arm/boot/dts/snowball.dts     |    3 +
>  arch/arm/configs/u8500_defconfig   |    1 +
>  arch/arm/mach-ux500/board-mop500.c |   55 ++------
>  drivers/i2c/busses/i2c-nomadik.c   |   53 ++++++-
>  drivers/mfd/Makefile               |    5 +-
>  drivers/mfd/ab8500-core.c          |  165 +++++++++++++++++++---
>  drivers/mfd/ab8500-i2c.c           |  128 -----------------
>  drivers/mfd/db8500-prcmu.c         |   30 ++--
>  drivers/power/ab8500_btemp.c       |   12 +-
>  drivers/power/ab8500_charger.c     |   12 +-
>  drivers/power/ab8500_fg.c          |   12 +-
>  drivers/regulator/ab8500.c         |  273 +++++++++++++++++++++++-------------

Looks all good, but I commented on two patches that I think can be done
in a simpler way.

	Arnd
