From: stillcompiling@gmail.com (Joshua Clayton)
Date: Fri, 02 Sep 2016 05:42:24 -0700
Subject: [PATCH] ARM: imx: (trivial) fix typo and grammar
In-Reply-To: <1472805280-5927-1-git-send-email-martin@kaiser.cx>
References: <1993847.IzPN1S0Ejq@diplodocus>
 <1472805280-5927-1-git-send-email-martin@kaiser.cx>
Message-ID: <2647588.TvIB393KzZ@diplodocus>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday, September 02, 2016 10:34:40 AM Martin Kaiser wrote:
> Signed-off-by: Martin Kaiser <martin@kaiser.cx>
> ---
>  arch/arm/mach-imx/hardware.h |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-imx/hardware.h b/arch/arm/mach-imx/hardware.h
> index a42a6df..90e10cb 100644
> --- a/arch/arm/mach-imx/hardware.h
> +++ b/arch/arm/mach-imx/hardware.h
> @@ -120,7 +120,7 @@
>  	.type = _type,							\
>  }
>  
> -/* There's a off-by-one betweem the gpio bank number and the gpiochip */
> +/* There's an off-by-one between the gpio bank number and the gpiochip */
>  /* range e.g. GPIO_1_5 is gpio 5 under linux */
>  #define IMX_GPIO_NR(bank, nr)		(((bank) - 1) * 32 + (nr))
>  
> 
That's Betterer! ;)

Reviewed-by Joshua Clayton <stillcompiling@gmail.com>
