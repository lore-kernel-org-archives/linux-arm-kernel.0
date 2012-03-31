From: shawn.guo@linaro.org (Shawn Guo)
Date: Sat, 31 Mar 2012 12:34:09 +0800
Subject: [PATCH 1/2] ARM: fix builds due to missing <asm/system_misc.h>
 includes
In-Reply-To: <1333118281-25295-1-git-send-email-olof@lixom.net>
References: <1333118281-25295-1-git-send-email-olof@lixom.net>
Message-ID: <20120331043405.GI19506@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 30, 2012 at 07:38:01AM -0700, Olof Johansson wrote:
> This does a sweeping change fixing up all the missing system_misc.h and
> system_info.h includes from the system.h split-up change. These were the
> ones I came across when building all defconfigs in arch/arm/configs, there
> might be more but they lack adequate build coverage to be easily caught.
> 
> I'm expecting to get a lot of these piecemeal by each maintainer, so we
> might just as well do one sweeping change to get them all at once.
> 
> 
> Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: Sascha Hauer <kernel@pengutronix.de>
> Cc: Imre Kaloz <kaloz@openwrt.org>
> Cc: Krzysztof Halasa <khc@pm.waw.pl>
> Cc: Eric Miao <eric.y.miao@gmail.com>
> Cc: Haojian Zhuang <haojian.zhuang@gmail.com>
> Cc: Wan ZongShun <mcuos.com@gmail.com>
> Cc: Kukjin Kim <kgene.kim@samsung.com>
> Signed-off-by: Olof Johansson <olof@lixom.net>
> ---
...
>  arch/arm/mach-imx/mm-imx3.c   |    1 +
>  arch/arm/mach-imx/mm-imx5.c   |    1 +

The changes are same as the patch below that I sent a little earlier.

  ARM: imx: fix ?arm_pm_idle? undeclared error

So,

Acked-by: Shawn Guo <shawn.guo@linaro.org>

-- 
Regards,
Shawn
