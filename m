From: mturquette@ti.com (Mike Turquette)
Date: Tue, 11 Sep 2012 10:13:51 -0700
Subject: [PATCH] i.MX: remove legacy clock support
In-Reply-To: <1347346396-27669-1-git-send-email-s.hauer@pengutronix.de>
References: <1347346396-27669-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <20120911171351.20289.33788@nucleus>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Sascha Hauer (2012-09-10 23:53:14)
> This removes the last leftovers from the i.MX legacy clock support.
> As a bonus we get rid of mach/clock.h
> 
> ----------------------------------------------------------------
> Sascha Hauer (2):
>       ARM: i.MX clk pllv1: move mxc_decode_pll code to its user
>       ARM: i.MX remove last leftovers from legacy clock support
> 

Nice!  For the series:
Reviewed-by: Mike Turquette <mturquette@linaro.org>

Regards,
Mike

>  arch/arm/mach-imx/Makefile             |    2 +-
>  arch/arm/mach-imx/clk-pllv1.c          |   49 +++++-
>  arch/arm/mach-imx/clk.c                |    3 +
>  arch/arm/mach-imx/clk.h                |    3 +-
>  arch/arm/mach-imx/mach-kzm_arm11_01.c  |    1 -
>  arch/arm/plat-mxc/Makefile             |    2 +-
>  arch/arm/plat-mxc/clock.c              |  257 --------------------------------
>  arch/arm/plat-mxc/cpufreq.c            |    1 -
>  arch/arm/plat-mxc/include/mach/clock.h |   70 ---------
>  9 files changed, 54 insertions(+), 334 deletions(-)
>  create mode 100644 arch/arm/mach-imx/clk.c
>  delete mode 100644 arch/arm/plat-mxc/clock.c
>  delete mode 100644 arch/arm/plat-mxc/include/mach/clock.h
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
