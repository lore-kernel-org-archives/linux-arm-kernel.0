From: tony@atomide.com (Tony Lindgren)
Date: Mon, 1 Apr 2013 08:53:45 -0700
Subject: [PATCH] ARM: OMAP1: remove "config MACH_OMAP_HTCWIZARD"
In-Reply-To: <1363901769.1390.159.camel@x61.thuisdomein>
References: <1363901769.1390.159.camel@x61.thuisdomein>
Message-ID: <20130401155345.GD10155@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Paul Bolle <pebolle@tiscali.nl> [130321 14:40]:
> The Kconfig symbol MACH_OMAP_HTCWIZARD got added in v2.6.30. It has
> never been used. Its entry can safely be removed.
> 
> Signed-off-by: Paul Bolle <pebolle@tiscali.nl>
> ---
> Untested.

Thanks, applying into omap-for-v3.10/fixes-non-critical.

Regards,

Tony
 
>  arch/arm/mach-omap1/Kconfig | 6 ------
>  1 file changed, 6 deletions(-)
> 
> diff --git a/arch/arm/mach-omap1/Kconfig b/arch/arm/mach-omap1/Kconfig
> index 903da8e..cdd05f2 100644
> --- a/arch/arm/mach-omap1/Kconfig
> +++ b/arch/arm/mach-omap1/Kconfig
> @@ -55,12 +55,6 @@ config MACH_OMAP_H3
>  	  TI OMAP 1710 H3 board support. Say Y here if you have such
>  	  a board.
>  
> -config MACH_OMAP_HTCWIZARD
> -	bool "HTC Wizard"
> -	depends on ARCH_OMAP850
> -	help
> -	  HTC Wizard smartphone support (AKA QTEK 9100, ...)
> -
>  config MACH_HERALD
>  	bool "HTC Herald"
>  	depends on ARCH_OMAP850
> -- 
> 1.7.11.7
> 
