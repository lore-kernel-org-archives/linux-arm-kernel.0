From: stigge@antcom.de (Roland Stigge)
Date: Wed, 12 Feb 2014 16:51:28 +0100
Subject: [PATCH RESEND] ARM: LPC32xx: common.c: Remove unnecessary header
 inclusion
In-Reply-To: <002a01cf2790$3e2d6510$ba882f30$%han@samsung.com>
References: <002a01cf2790$3e2d6510$ba882f30$%han@samsung.com>
Message-ID: <52FB9880.9080300@antcom.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/02/14 02:17, Jingoo Han wrote:
> common.c includes some header files that are not really used.
> 
> Signed-off-by: Jingoo Han <jg1.han@samsung.com>
> ---
> Compile-tested only.
> 
>  arch/arm/mach-lpc32xx/common.c |    6 ------
>  1 file changed, 6 deletions(-)
> 
> diff --git a/arch/arm/mach-lpc32xx/common.c b/arch/arm/mach-lpc32xx/common.c
> index d7aa54c..9713c8b 100644
> --- a/arch/arm/mach-lpc32xx/common.c
> +++ b/arch/arm/mach-lpc32xx/common.c
> @@ -17,12 +17,6 @@
>   */
>  
>  #include <linux/init.h>
> -#include <linux/platform_device.h>
> -#include <linux/interrupt.h>
> -#include <linux/irq.h>
> -#include <linux/err.h>
> -#include <linux/i2c.h>
> -#include <linux/i2c-pnx.h>
>  #include <linux/io.h>
>  
>  #include <asm/mach/map.h>
> 

Acked-by: Roland Stigge <stigge@antcom.de>
