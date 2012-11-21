From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed, 21 Nov 2012 21:03:10 +0900
Subject: [PATCH 6/9] ARM: remove mach .handle_irq for GIC users
In-Reply-To: <1353466713-18967-7-git-send-email-robherring2@gmail.com>
References: <1353466713-18967-1-git-send-email-robherring2@gmail.com>
 <1353466713-18967-7-git-send-email-robherring2@gmail.com>
Message-ID: <0e6a01cdc7e0$2d5c2e30$88148a90$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Rob Herring wrote:
> 
> From: Rob Herring <rob.herring@calxeda.com>
> 
> Now that the GIC initialization sets up the handle_arch_irq pointer, we
> can remove it for all machines.
> 
> Signed-off-by: Rob Herring <rob.herring@calxeda.com>
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: Anton Vorontsov <avorontsov@mvista.com>
> Cc: Kukjin Kim <kgene.kim@samsung.com>
> Cc: Kyungmin Park <kyungmin.park@samsung.com>
> Cc: Shawn Guo <shawn.guo@linaro.org>
> Cc: Sascha Hauer <kernel@pengutronix.de>
> Cc: David Brown <davidb@codeaurora.org>
> Cc: Daniel Walker <dwalker@fifo99.com>
> Cc: Bryan Huntsman <bryanh@codeaurora.org>
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Paul Mundt <lethal@linux-sh.org>
> Cc: Magnus Damm <magnus.damm@gmail.com>
> Cc: Dinh Nguyen <dinguyen@altera.com>
> Cc: Viresh Kumar <viresh.linux@gmail.com>
> Cc: Shiraz Hashim <shiraz.hashim@st.com>
> Cc: Stephen Warren <swarren@wwwdotorg.org>
> Cc: Srinidhi Kasagar <srinidhi.kasagar@stericsson.com>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> ---

[...]

>  arch/arm/mach-exynos/mach-armlex4210.c     |    2 --
>  arch/arm/mach-exynos/mach-exynos4-dt.c     |    2 --
>  arch/arm/mach-exynos/mach-exynos5-dt.c     |    2 --
>  arch/arm/mach-exynos/mach-nuri.c           |    2 --
>  arch/arm/mach-exynos/mach-origen.c         |    2 --
>  arch/arm/mach-exynos/mach-smdk4x12.c       |    3 ---
>  arch/arm/mach-exynos/mach-smdkv310.c       |    3 ---
>  arch/arm/mach-exynos/mach-universal_c210.c |    2 --
>  arch/arm/mach-exynos/mct.c                 |    1 -

For above exynos,

Acked-by: Kukjin Kim <kgene.kim@samsung.com>

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd
