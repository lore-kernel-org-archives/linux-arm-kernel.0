From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 3 Sep 2013 08:54:56 +0800
Subject: [PATCH] ARM: mxs: pm: Include "pm.h"
In-Reply-To: <1378087868-29744-1-git-send-email-festevam@gmail.com>
References: <1378087868-29744-1-git-send-email-festevam@gmail.com>
Message-ID: <20130903005454.GF17900@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Sep 01, 2013 at 11:11:08PM -0300, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
> 
> Include "pm.h" in order to fix the following sparse warning:
> 
> arch/arm/mach-mxs/pm.c:37:13: warning: symbol 'mxs_pm_init' was not declared. Should it be static?
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>

Why do you resend a patch that I already applied [1]?

Shawn

[1] http://www.spinics.net/lists/arm-kernel/msg259101.html

> ---
>  arch/arm/mach-mxs/pm.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/mach-mxs/pm.c b/arch/arm/mach-mxs/pm.c
> index b2494d2..0170e99 100644
> --- a/arch/arm/mach-mxs/pm.c
> +++ b/arch/arm/mach-mxs/pm.c
> @@ -15,6 +15,7 @@
>  #include <linux/kernel.h>
>  #include <linux/suspend.h>
>  #include <linux/io.h>
> +#include "pm.h"
>  
>  static int mxs_suspend_enter(suspend_state_t state)
>  {
> -- 
> 1.8.1.2
> 
