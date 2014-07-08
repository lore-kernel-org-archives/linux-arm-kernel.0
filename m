From: t.figa@samsung.com (Tomasz Figa)
Date: Tue, 08 Jul 2014 13:47:41 +0200
Subject: [PATCH 1/3] ARM: exynos: remove unused <mach/memory.h>
In-Reply-To: <1404295043-6661-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1404295043-6661-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <53BBDA5D.1020605@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Uwe,

On 02.07.2014 11:57, Uwe Kleine-K?nig wrote:
> ARCH_EXYNOS doesn't select NEED_MACH_MEMORY_H, so <asm/memory.h> doesn't
> include <mach/memory.h> and so this file is not used and can go away.
> 
> Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> ---
> Cc: Kukjin Kim <kgene.kim@samsung.com>
> Cc: linux-samsung-soc at vger.kernel.org
> ---
>  arch/arm/mach-exynos/include/mach/memory.h | 27 ---------------------------
>  1 file changed, 27 deletions(-)
>  delete mode 100644 arch/arm/mach-exynos/include/mach/memory.h

Thanks for the patch.

Reviewed-by: Tomasz Figa <t.figa@samsung.com>

[boot tested on Exynos4412-based Trats2 board]
Tested-by: Tomasz Figa <t.figa@samsung.com>

Best regards,
Tomasz
