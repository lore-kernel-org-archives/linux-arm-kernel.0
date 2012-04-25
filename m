From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 25 Apr 2012 08:24:27 +0200
Subject: [GIT PULL] i.MX board feature patches
In-Reply-To: <20120416075324.GP3852@pengutronix.de>
References: <20120411083342.GM3852@pengutronix.de>
 <CAOesGMhakTpuXWnHUnJqiEbzPBeXE1digiyJ+LeoPbjhyFAoLA@mail.gmail.com>
 <20120416075324.GP3852@pengutronix.de>
Message-ID: <20120425062427.GV20478@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof,

On Mon, Apr 16, 2012 at 09:53:24AM +0200, Sascha Hauer wrote:
> > 
> > Branch otherwise looks reasonable, so respin with that fixed and we'll
> > pull it in.
> 
> Here we go. Hopefully I am aware of this in the future :-/

Still something wrong?

Sascha

> 
> Sascha
> 
> The following changes since commit dd775ae2549217d3ae09363e3edb305d0fa19928:
> 
>   Linux 3.4-rc1 (2012-03-31 16:24:09 -0700)
> 
> are available in the git repository at:
> 
>   git://git.pengutronix.de/git/imx/linux-2.6.git tags/imx-features-board-20120411-2
> 
> for you to fetch changes up to 435ca24116bc5365a10fa0be1bf1c1e4c5680157:
> 
>   ARM i.MX: Visstrim_M10: Add board version detection. (2012-04-16 09:49:31 +0200)
> 
> ----------------------------------------------------------------
> imx-features-board-20120411
> 
> ----------------------------------------------------------------
> Alex Gershgorin (1):
>       ARM: i.MX: i.MX35-PDK: Add regulator support
> 
> Javier Martin (1):
>       ARM i.MX: Visstrim_M10: Add board version detection.
> 
> Uwe Kleine-K?nig (1):
>       ARM: imx_v4_v5_defconfig: enable adc and touch driver of mc13783
> 
>  arch/arm/configs/imx_v4_v5_defconfig        |    4 +-
>  arch/arm/mach-imx/mach-imx27_visstrim_m10.c |   55 ++++++++
>  arch/arm/mach-imx/mach-mx35_3ds.c           |  193 +++++++++++++++++++++++++++
>  3 files changed, 251 insertions(+), 1 deletion(-)
> 
> -- 
> Pengutronix e.K.                           |                             |
> Industrial Linux Solutions                 | http://www.pengutronix.de/  |
> Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
> Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
