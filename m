From: shawn.guo@linaro.org (Shawn Guo)
Date: Sat, 5 Oct 2013 10:24:23 +0800
Subject: [PATCH] ARM: imx: Include linux/err.h
In-Reply-To: <1380542691-24756-1-git-send-email-treding@nvidia.com>
References: <1380542691-24756-1-git-send-email-treding@nvidia.com>
Message-ID: <20131005022422.GF2734@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 30, 2013 at 02:04:51PM +0200, Thierry Reding wrote:
> The IS_ERR() macro is defined in the linux/err.h header file, so include
> it explicitly.

Hmm, I can not find IS_ERR() in arch/arm/mach-imx/cpu.c

Shawn

> Signed-off-by: Thierry Reding <treding@nvidia.com>
> ---
>  arch/arm/mach-imx/cpu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-imx/cpu.c b/arch/arm/mach-imx/cpu.c
> index fae2c9a..ba3b498 100644
> --- a/arch/arm/mach-imx/cpu.c
> +++ b/arch/arm/mach-imx/cpu.c
> @@ -1,4 +1,4 @@
> -
> +#include <linux/err.h>
>  #include <linux/module.h>
>  #include <linux/io.h>
>  #include <linux/of.h>
> -- 
> 1.8.4
> 
