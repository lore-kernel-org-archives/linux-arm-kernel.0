From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed, 02 Nov 2011 20:23:17 +0900
Subject: [PATCH V4 0/4] Add SPI clkdev support
In-Reply-To: <1320268004-4545-1-git-send-email-padma.v@samsung.com>
References: <1320268004-4545-1-git-send-email-padma.v@samsung.com>
Message-ID: <004a01cc9951$d1eca790$75c5f6b0$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Padmavathi Venna wrote:
> 
> This patchset modifies the existing clkdev to make SPI driver
> independent of the clock names send from platform data. This
> patches enables the SPI driver to request SPI bus clocks
> using generic connection ID.
> 
> Link to V1:
>         http://www.spinics.net/lists/arm-kernel/msg141671.html
> 
> V2 Changes:
>         -Add newly introduced CLKDEV_INIT macro for creating clk_lookup
>         structure as suggested by Russell King
>         V2 patches series are:
>         http://www.spinics.net/lists/arm-kernel/msg142733.html
> 
> V3 Changes:
>         -Reworked the patches as per the following link. Patch series in
>         the following link removed & and , from the macro declaration and
added
>         in the macro defination.
>         http://www.spinics.net/lists/arm-kernel/msg143663.html
> 
> V4 Changes:
> 	Rebased to next-samsung-dt.
> 
> Padmavathi Venna (4):
>   ARM: S3C64XX: Add SPI clkdev support
>   ARM: S5PC100: Add SPI clkdev support
>   ARM: S5P64X0: Add SPI clkdev support
>   ARM: S5PV210: Add SPI clkdev support
> 
>  arch/arm/mach-s3c64xx/clock.c         |   80 +++++++++++++--------
>  arch/arm/mach-s5p64x0/clock-s5p6440.c |   61 ++++++++---------
>  arch/arm/mach-s5p64x0/clock-s5p6450.c |   49 ++++++++-----
>  arch/arm/mach-s5pc100/clock.c         |  124
+++++++++++++++++++----------
> ----
>  arch/arm/mach-s5pv210/clock.c         |   50 ++++++++-----
>  5 files changed, 210 insertions(+), 154 deletions(-)

Applied.
Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
