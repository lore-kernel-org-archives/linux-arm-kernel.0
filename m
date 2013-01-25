From: sachin.kamat@linaro.org (Sachin Kamat)
Date: Fri, 25 Jan 2013 08:25:27 +0530
Subject: [PATCH 01/15] ARM: shmobile: Remove duplicate inclusion of
 dma-mapping.h in setup-r8a7740.c
In-Reply-To: <1359080013-29189-2-git-send-email-horms+renesas@verge.net.au>
References: <1359080013-29189-1-git-send-email-horms+renesas@verge.net.au>
 <1359080013-29189-2-git-send-email-horms+renesas@verge.net.au>
Message-ID: <CAK9yfHzCywTj10sURg6z6fuVp=PtgXTyQD9evzrVVDV5a6FSdQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Simon,

You seem to have changed the authorship of this patch.

Original one at:
https://patchwork.kernel.org/patch/1771091/

Regards
Sachin

On 25 January 2013 07:43, Simon Horman <horms+renesas@verge.net.au> wrote:
> linux/dma-mapping.h was included twice.
>
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> ---
>  arch/arm/mach-shmobile/setup-r8a7740.c |    1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/arch/arm/mach-shmobile/setup-r8a7740.c b/arch/arm/mach-shmobile/setup-r8a7740.c
> index 03c69f9..9ef397d 100644
> --- a/arch/arm/mach-shmobile/setup-r8a7740.c
> +++ b/arch/arm/mach-shmobile/setup-r8a7740.c
> @@ -27,7 +27,6 @@
>  #include <linux/serial_sci.h>
>  #include <linux/sh_dma.h>
>  #include <linux/sh_timer.h>
> -#include <linux/dma-mapping.h>
>  #include <mach/dma-register.h>
>  #include <mach/r8a7740.h>
>  #include <mach/pm-rmobile.h>
> --
> 1.7.10.4
>
