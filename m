From: t.figa@samsung.com (Tomasz Figa)
Date: Tue, 10 Jun 2014 15:56:30 +0200
Subject: [PATCH v3 4/6] ARM: EXYNOS: Remove unused header inclusion from
 hotplug.c
In-Reply-To: <1399706419-13976-5-git-send-email-pankaj.dubey@samsung.com>
References: <1399706287-13919-1-git-send-email-y@samsung.com>
 <1399706419-13976-1-git-send-email-pankaj.dubey@samsung.com>
 <1399706419-13976-5-git-send-email-pankaj.dubey@samsung.com>
Message-ID: <53970E8E.5030408@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Pankaj,

On 10.05.2014 09:20, Pankaj Dubey wrote:
> This patch removed "plat/cpu.h" inclusion from hotplug.c as it
> is not required.
> 
> Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
> ---
>  arch/arm/mach-exynos/hotplug.c |    2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/arch/arm/mach-exynos/hotplug.c b/arch/arm/mach-exynos/hotplug.c
> index 0243ef3..5e19601 100644
> --- a/arch/arm/mach-exynos/hotplug.c
> +++ b/arch/arm/mach-exynos/hotplug.c
> @@ -19,8 +19,6 @@
>  #include <asm/cp15.h>
>  #include <asm/smp_plat.h>
>  
> -#include <plat/cpu.h>
> -
>  #include "common.h"
>  #include "regs-pmu.h"
>  
> 

I don't see this header being included in current linux-next.

Best regards,
Tomasz
