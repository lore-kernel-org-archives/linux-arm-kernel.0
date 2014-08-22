From: horms@verge.net.au (Simon Horman)
Date: Fri, 22 Aug 2014 10:46:06 +0900
Subject: [PATCH v2 3/5] ARM: shmobile: armadillo800eva-reference: Sort
 includes
In-Reply-To: <1407801882-2561-4-git-send-email-horms+renesas@verge.net.au>
References: <1407801882-2561-1-git-send-email-horms+renesas@verge.net.au>
 <1407801882-2561-4-git-send-email-horms+renesas@verge.net.au>
Message-ID: <20140822014606.GB9099@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 12, 2014 at 09:04:40AM +0900, Simon Horman wrote:
> Sorted includes seems to be the done thing these days.
> 
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

I have queued up this patch but I am leaving the rest of the series for
now.

> ---
>  arch/arm/mach-shmobile/board-armadillo800eva-reference.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-shmobile/board-armadillo800eva-reference.c b/arch/arm/mach-shmobile/board-armadillo800eva-reference.c
> index 84bc6cb..c392632 100644
> --- a/arch/arm/mach-shmobile/board-armadillo800eva-reference.c
> +++ b/arch/arm/mach-shmobile/board-armadillo800eva-reference.c
> @@ -21,9 +21,9 @@
>  
>  #include <linux/clk.h>
>  #include <linux/err.h>
> -#include <linux/kernel.h>
>  #include <linux/gpio.h>
>  #include <linux/io.h>
> +#include <linux/kernel.h>
>  
>  #include <asm/mach/arch.h>
>  #include <asm/hardware/cache-l2x0.h>
> -- 
> 2.0.0.rc2
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
