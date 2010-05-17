From: kgene.kim@samsung.com (Kukjin Kim)
Date: Mon, 17 May 2010 22:28:49 +0900
Subject: [PATCH 13/15] ARM: Samsung: Move external interrupts support from
	plat-s5pc1xx to plat-s5p
In-Reply-To: <1273817946-29404-14-git-send-email-m.szyprowski@samsung.com>
References: <1273817946-29404-1-git-send-email-m.szyprowski@samsung.com>
	<1273817946-29404-14-git-send-email-m.szyprowski@samsung.com>
Message-ID: <004a01caf5c4$e5aebe30$b10c3a90$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Marek Szyprowski wrote:
> 
> This patch moves external interrupts support code from plat-s5pc1xx to
> plat-s5p and enables support for it on ARCH_S5PC100. This code can be
easily
> reused by S5PV210/S5PC110 and probably S5P6442.

Already merged EINT patch for S5P to Ben's for-2635/s5p-general.
So please re-make based on it.

> 
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> ---
>  arch/arm/mach-s5pc100/Kconfig                  |    1 +
>  arch/arm/mach-s5pc100/gpio.c                   |    8 ++--
>  arch/arm/mach-s5pc100/include/mach/gpio.h      |    8 +++
>  arch/arm/plat-s5p/Kconfig                      |    5 ++
>  arch/arm/plat-s5p/Makefile                     |    1 +
>  arch/arm/plat-s5p/include/plat/gpio-ext.h      |   44 ++++++++++++++++++
>  arch/arm/{plat-s5pc1xx => plat-s5p}/irq-eint.c |   57
++++++++++++------------
>  arch/arm/plat-s5pc1xx/include/plat/gpio-ext.h  |   44 ------------------
>  8 files changed, 92 insertions(+), 76 deletions(-)
>  create mode 100644 arch/arm/plat-s5p/include/plat/gpio-ext.h
>  rename arch/arm/{plat-s5pc1xx => plat-s5p}/irq-eint.c (80%)
>  delete mode 100644 arch/arm/plat-s5pc1xx/include/plat/gpio-ext.h
> 

(snip)


Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
