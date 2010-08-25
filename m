From: kgene.kim@samsung.com (Kukjin Kim)
Date: Thu, 26 Aug 2010 08:27:45 +0900
Subject: [PATCH RE-SEND] ARM: S5P: Move OneNAND device definitions in
	plat-s5p
In-Reply-To: <01ba01cb4268$8346fa50$89d4eef0$%park@samsung.com>
References: <1282522043-2420-1-git-send-email-kgene.kim@samsung.com>
	<01ba01cb4268$8346fa50$89d4eef0$%park@samsung.com>
Message-ID: <001401cb44ad$22fc4460$68f4cd20$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Kukjin Kim wrote:
> 
> This patch moves OneNAND device definitions from mach-s5pv210 to plat-s5p
> so that can support it commonly.
> 
> Note: S5PC110 and S5PC210 have same OneNAND driver.
> 
> Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
> Cc: Kyungmin Park <Kyungmin Park <kyungmin.park@samsung.com>

Hmm...typo...will fix like following.
Cc: Kyungmin Park <kyungmin.park@samsung.com>

> ---
>  arch/arm/mach-s5pv210/Kconfig                     |    9 +-----
>  arch/arm/mach-s5pv210/Makefile                    |    1 -
>  arch/arm/mach-s5pv210/include/mach/map.h          |    3 ++
>  arch/arm/mach-s5pv210/mach-aquila.c               |    2 +-
>  arch/arm/mach-s5pv210/mach-goni.c                 |    2 +-
>  arch/arm/mach-s5pv310/include/mach/irqs.h         |    2 +
>  arch/arm/mach-s5pv310/include/mach/map.h          |    6 ++++
>  arch/arm/plat-s5p/Kconfig                         |    5 +++
>  arch/arm/plat-s5p/Makefile                        |    1 +
>  arch/arm/{mach-s5pv210 => plat-s5p}/dev-onenand.c |   28
> +++++++++++---------
>  arch/arm/plat-samsung/include/plat/devs.h         |    2 +-
>  11 files changed, 37 insertions(+), 24 deletions(-)
>  rename arch/arm/{mach-s5pv210 => plat-s5p}/dev-onenand.c (59%)
> 

(snip)

> --


Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
