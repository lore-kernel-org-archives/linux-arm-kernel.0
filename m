From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Mon, 14 Apr 2014 10:58:09 +0200
Subject: [PATCH 4/4] ARM: at91: move sam9n12 SoC to the CCF
In-Reply-To: <1397463399-11771-5-git-send-email-boris.brezillon@free-electrons.com>
References: <1397463399-11771-1-git-send-email-boris.brezillon@free-electrons.com>
 <1397463399-11771-5-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <20140414085809.GN2967@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14/04/2014 at 10:16:39 +0200, Boris Brezillon wrote :
> This patch removes the selection of AT91_USE_OLD_CLK when selecting
> sam9n12 SoC support. This will automatically enable COMMON_CLK_AT91 option
> and add support for at91 common clk implementation.
> 
> Signed-off-by: Boris BREZILLON <boris.brezillon@free-electrons.com>
Acked-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> ---
>  arch/arm/mach-at91/Kconfig | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/arch/arm/mach-at91/Kconfig b/arch/arm/mach-at91/Kconfig
> index b2d2cf4..a1ac430 100644
> --- a/arch/arm/mach-at91/Kconfig
> +++ b/arch/arm/mach-at91/Kconfig
> @@ -183,7 +183,6 @@ config SOC_AT91SAM9N12
>  	select HAVE_AT91_DBGU0
>  	select HAVE_FB_ATMEL
>  	select SOC_AT91SAM9
> -	select AT91_USE_OLD_CLK
>  	select HAVE_AT91_USB_CLK
>  	help
>  	  Select this if you are using Atmel's AT91SAM9N12 SoC.
> -- 
> 1.8.3.2
> 

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
