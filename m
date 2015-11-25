From: marc_gonzalez@sigmadesigns.com (Marc Gonzalez)
Date: Wed, 25 Nov 2015 10:20:37 +0100
Subject: [PATCH v10 1/2] arm-soc: Import initial tango4 device tree
In-Reply-To: <56549C1A.8010109@sigmadesigns.com>
References: <56549B3A.8010703@sigmadesigns.com>
 <56549C1A.8010109@sigmadesigns.com>
Message-ID: <56557D65.5080607@sigmadesigns.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 24/11/2015 18:19, Marc Gonzalez wrote:

> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index 246473a244f6..2499295051d5 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -605,6 +605,8 @@ dtb-$(CONFIG_MACH_SUN8I) += \
>  dtb-$(CONFIG_MACH_SUN9I) += \
>  	sun9i-a80-optimus.dtb \
>  	sun9i-a80-cubieboard4.dtb
> +dtb-$(CONFIG_ARCH_TANGOX) += \

<sigh> Missed an ARCH_TANGOX here.
