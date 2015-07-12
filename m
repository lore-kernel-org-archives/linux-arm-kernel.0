From: santosh.shilimkar@oracle.com (santosh.shilimkar at oracle.com)
Date: Sun, 12 Jul 2015 12:04:16 -0700
Subject: [PATCH 3/7] ARM: keystone: Remove clk-provider.h include
In-Reply-To: <1436568347-24554-4-git-send-email-sboyd@codeaurora.org>
References: <1436568347-24554-1-git-send-email-sboyd@codeaurora.org>
 <1436568347-24554-4-git-send-email-sboyd@codeaurora.org>
Message-ID: <55A2BA30.1000903@oracle.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 7/10/15 3:45 PM, Stephen Boyd wrote:
> This file doesn't use the clk provider APIs. Remove the include.
>
> Cc: Nishanth Menon <nm@ti.com>
> Cc: Sekhar Nori <nsekhar@ti.com>
> Cc: Santosh Shilimkar <ssantosh@kernel.org>
> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
> ---
>
> Please ack if you want this to go through clk-tree.
>
Sure.
Acked-by: Santosh Shilimkar <ssantosh@kernel.org>

>   arch/arm/mach-keystone/pm_domain.c | 1 -
>   1 file changed, 1 deletion(-)
>
> diff --git a/arch/arm/mach-keystone/pm_domain.c b/arch/arm/mach-keystone/pm_domain.c
> index edea697e8253..e283939a216f 100644
> --- a/arch/arm/mach-keystone/pm_domain.c
> +++ b/arch/arm/mach-keystone/pm_domain.c
> @@ -16,7 +16,6 @@
>   #include <linux/pm_runtime.h>
>   #include <linux/pm_clock.h>
>   #include <linux/platform_device.h>
> -#include <linux/clk-provider.h>
>   #include <linux/of.h>
>
>   static struct dev_pm_domain keystone_pm_domain = {
>
