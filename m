From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed, 01 Jun 2011 14:52:57 -0700
Subject: [PATCH/NEXT] ARM: exynos4: fix typo in platsmp.c
In-Reply-To: <1306164953-31593-1-git-send-email-marc.zyngier@arm.com>
References: <1306164953-31593-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <4DE6B4B9.8040906@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/23/11 08:35, Marc Zyngier wrote:
> Commit e2a083dc0da9aa6437e14811198379b18cdfa7f8 (ARM: consolidate
> SMP cross call implementation) introduced a typo which leads
> to a compilation error. Just fix it.
>
> Cc: Russell King<rmk+kernel@arm.linux.org.uk>
> Signed-off-by: Marc Zyngier<marc.zyngier@arm.com>
> ---
>   arch/arm/mach-exynos4/platsmp.c |    2 +-
>   1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/arch/arm/mach-exynos4/platsmp.c b/arch/arm/mach-exynos4/platsmp.c
> index 8403dd2..c5e65a0 100644
> --- a/arch/arm/mach-exynos4/platsmp.c
> +++ b/arch/arm/mach-exynos4/platsmp.c
> @@ -22,7 +22,7 @@
>   #include<linux/io.h>
>
>   #include<asm/cacheflush.h>
> -#include<asm/hardare/gic.h>
> +#include<asm/hardware/gic.h>
>   #include<asm/smp_scu.h>
>   #include<asm/unified.h>
>

Hi Marc,

Maybe, Russell fixed this when applied.

As a note, the commit is 0f7b332f9777819a39a3b325690379a7efef89d1
(ARM: consolidate SMP cross call implementation) in mainline now.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
