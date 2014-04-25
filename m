From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Fri, 25 Apr 2014 23:44:28 +0200
Subject: [PATCH v2 07/10] ARM: EXYNOS: Remove "linux/bug.h" from pmu.c
In-Reply-To: <1398429166-5539-8-git-send-email-pankaj.dubey@samsung.com>
References: <1396425058-4012-1-git-send-email-pankaj.dubey@samsung.com>
 <1398429166-5539-1-git-send-email-pankaj.dubey@samsung.com>
 <1398429166-5539-8-git-send-email-pankaj.dubey@samsung.com>
Message-ID: <535AD73C.5070809@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 25.04.2014 14:32, Pankaj Dubey wrote:
> From: Young-Gun Jang <yg1004.jang@samsung.com>
>
> This patch removes unnecessary header file inclusion from pmu.c.
>
> Signed-off-by: Young-Gun Jang <yg1004.jang@samsung.com>
> ---
>   arch/arm/mach-exynos/pmu.c |    1 -
>   1 file changed, 1 deletion(-)
>
> diff --git a/arch/arm/mach-exynos/pmu.c b/arch/arm/mach-exynos/pmu.c
> index 05c7ce1..4c3453a 100644
> --- a/arch/arm/mach-exynos/pmu.c
> +++ b/arch/arm/mach-exynos/pmu.c
> @@ -11,7 +11,6 @@
>
>   #include <linux/io.h>
>   #include <linux/kernel.h>
> -#include <linux/bug.h>
>
>   #include <plat/cpu.h>
>
>

Reviewed-by: Tomasz Figa <t.figa@samsung.com>

Best regards,
Tomasz
