From: cjb@laptop.org (Chris Ball)
Date: Wed, 19 Sep 2012 03:21:17 -0400
Subject: [PATCH 2/5] mmc: msm_sdcc: Remove unnecessary include
In-Reply-To: <1348038044-1790-3-git-send-email-sboyd@codeaurora.org> (Stephen
 Boyd's message of "Wed, 19 Sep 2012 00:00:41 -0700")
References: <1348038044-1790-1-git-send-email-sboyd@codeaurora.org>
 <1348038044-1790-3-git-send-email-sboyd@codeaurora.org>
Message-ID: <m3txuuh40i.fsf@pullcord.laptop.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Sep 19 2012, Stephen Boyd wrote:
> This driver has no reason to include msm_iomap.h. Remove it so
> that we can remove msm_iomap.h from include/mach in the future.
>
> Cc: Chris Ball <cjb@laptop.org>
> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
> ---
>  drivers/mmc/host/msm_sdcc.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/mmc/host/msm_sdcc.c b/drivers/mmc/host/msm_sdcc.c
> index 1d14cda..8bcb330 100644
> --- a/drivers/mmc/host/msm_sdcc.c
> +++ b/drivers/mmc/host/msm_sdcc.c
> @@ -43,7 +43,6 @@
>  #include <asm/sizes.h>
>  
>  #include <mach/mmc.h>
> -#include <mach/msm_iomap.h>
>  #include <mach/dma.h>
>  #include <mach/clk.h>

Acked-by: Chris Ball <cjb@laptop.org>

Sending this via the MSM tree is fine.  Thanks,

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
