From: dave.martin@linaro.org (Dave Martin)
Date: Thu, 8 Dec 2011 11:40:05 +0000
Subject: [PATCH v4 5/6] ARM: vexpress: DT-based support for Cortex-A5 and
 Cortex-A9 based tiles
In-Reply-To: <1323284974.32116.12.camel@hornet.cambridge.arm.com>
References: <1323186229-22054-1-git-send-email-pawel.moll@arm.com>
 <1323186229-22054-6-git-send-email-pawel.moll@arm.com>
 <20111207153338.GD2910@linaro.org>
 <1323284974.32116.12.camel@hornet.cambridge.arm.com>
Message-ID: <20111208114005.GA2015@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 07, 2011 at 07:09:34PM +0000, Pawel Moll wrote:
> On Wed, 2011-12-07 at 15:33 +0000, Dave Martin wrote:
> > Oh, we should select HAVE_PATA_PLATFORM in here somewhere too.
> > But that's not critical for this series.
> 
> It's already selected in "arch/arm/Kconfig":
> 
> config ARCH_VEXPRESS
>         bool "ARM Ltd. Versatile Express family"
>         select ARCH_WANT_OPTIONAL_GPIOLIB
>         select ARM_AMBA
>         select ARM_TIMER_SP804 
>         select CLKDEV_LOOKUP
>         select HAVE_MACH_CLKDEV
>         select GENERIC_CLOCKEVENTS
>         select HAVE_CLK
>         select HAVE_PATA_PLATFORM
>         select ICST
>         select PLAT_VERSATILE
>         select PLAT_VERSATILE_CLCD
>         help
>           This enables support for the ARM Ltd Versatile Express boards.

Oh, OK.  I was looking in mach-vexpress/Kconfig instead ...

Cheers
---Dave
