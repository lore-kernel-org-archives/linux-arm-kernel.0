From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Thu, 20 May 2010 07:26:11 +0200
Subject: [PATCH v6] ARM: S5P: Add Ext interrupt support.
In-Reply-To: <1274325653-16243-1-git-send-email-kgene.kim@samsung.com>
References: <1274325653-16243-1-git-send-email-kgene.kim@samsung.com>
Message-ID: <014801caf7dc$f8332e50$e8998af0$%szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Thursday, May 20, 2010 5:21 AM Kukjin Kim wrote:

> From: Jongpill Lee <boyko.lee@samsung.com>
> 
> This patch adds the following:
> 
> 1. Adds external interrupt support for S5PV210.
> 2. Adds common defines related to external interrupt support for plat-s5p
>    based platforms.
> 3. Based on the new common defines, corresponding changes are made in the
>    affected platforms (S5P6440 and S5P6442).
> 
> Signed-off-by: Jongpill Lee <boyko.lee@samsung.com>
> Signed-off-by: Pannaga Bhushan <p.bhushan@samsung.com>
> Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
> ---
>  arch/arm/mach-s5p6440/include/mach/irqs.h      |    9 +-
>  arch/arm/mach-s5p6442/include/mach/irqs.h      |    5 +-
>  arch/arm/mach-s5pv210/Kconfig                  |    1 +
>  arch/arm/mach-s5pv210/include/mach/irqs.h      |   25 +---
>  arch/arm/mach-s5pv210/include/mach/memory.h    |    2 +-
>  arch/arm/mach-s5pv210/include/mach/regs-gpio.h |   48 +++++
>  arch/arm/plat-s5p/Kconfig                      |    6 +
>  arch/arm/plat-s5p/Makefile                     |    1 +
>  arch/arm/plat-s5p/include/plat/irqs.h          |    7 +
>  arch/arm/plat-s5p/irq-eint.c                   |  218
> ++++++++++++++++++++++++
>  10 files changed, 296 insertions(+), 26 deletions(-)
> ...

Works fine here on S5PC100. I will post relevant patches for s5pc100 in
a minute.

Best regards
--
Marek Szyprowski
Samsung Poland R&D Center
