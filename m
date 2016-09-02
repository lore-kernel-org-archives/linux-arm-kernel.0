From: stillcompiling@gmail.com (Joshua Clayton)
Date: Thu, 01 Sep 2016 18:19:07 -0700
Subject: [PATCH] ARM: imx: (trivial) fix a typo
In-Reply-To: <20160901204816.GA8057@reykholt.kaiser.cx>
References: <20160901204816.GA8057@reykholt.kaiser.cx>
Message-ID: <1993847.IzPN1S0Ejq@diplodocus>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday, September 01, 2016 10:48:16 PM Martin Kaiser wrote:
> Signed-off-by: Martin Kaiser <martin@kaiser.cx>
> ---
>  arch/arm/mach-imx/hardware.h |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-imx/hardware.h b/arch/arm/mach-imx/hardware.h
> index a42a6df..2810ffc 100644
> --- a/arch/arm/mach-imx/hardware.h
> +++ b/arch/arm/mach-imx/hardware.h
> @@ -120,7 +120,7 @@
>  	.type = _type,							\
>  }
>  
> -/* There's a off-by-one betweem the gpio bank number and the gpiochip */
> +/* There's a off-by-one between the gpio bank number and the gpiochip */
>  /* range e.g. GPIO_1_5 is gpio 5 under linux */
>  #define IMX_GPIO_NR(bank, nr)		(((bank) - 1) * 32 + (nr))
>  
> 
s/a/an/

while we're in there fixing spelling let's fix the grammar too:

 diff --git a/arch/arm/mach-imx/hardware.h b/arch/arm/mach-imx/hardware.h
 index a42a6df..2810ffc 100644
 --- a/arch/arm/mach-imx/hardware.h
 +++ b/arch/arm/mach-imx/hardware.h
 @@ -120,7 +120,7 @@
  	.type = _type,							\
  }
  
 -/* There's a off-by-one betweem the gpio bank number and the gpiochip */
 +/* There's an off-by-one between the gpio bank number and the gpiochip */
  /* range e.g. GPIO_1_5 is gpio 5 under linux */
  #define IMX_GPIO_NR(bank, nr)		(((bank) - 1) * 32 + (nr))
  
 
