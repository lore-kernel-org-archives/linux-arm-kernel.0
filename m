From: rask@formelder.dk (Rask Ingemann Lambertsen)
Date: Sun, 21 Jan 2018 12:03:19 +0100
Subject: [RFC PATCH 8/9] ARM: dts: suniv: add initial DTSI file for suniv
 and F1C100s
In-Reply-To: <20180119231735.61504-9-icenowy@aosc.io>
References: <20180119231735.61504-1-icenowy@aosc.io>
 <20180119231735.61504-9-icenowy@aosc.io>
Message-ID: <20180121110319.GD3421@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jan 20, 2018 at 07:17:34AM +0800, Icenowy Zheng wrote:
> As we have the support for suniv pin controller and CCU now, add a
> initial DTSI for it.
> 
> F1C100s is one product with the suniv die, which has a 32MiB co-packaged
> DDR1 DRAM chip. As there's nothing special for it, add a dummy DTSI file
> for it.
[...]
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index d0381e9caf21..b877e0bf1823 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -972,6 +972,8 @@ dtb-$(CONFIG_MACH_SUN8I) += \
>  dtb-$(CONFIG_MACH_SUN9I) += \
>  	sun9i-a80-optimus.dtb \
>  	sun9i-a80-cubieboard4.dtb
> +dtb-$(CONFIG_MACH_SUNIV) += \
> +	suniv-f1c100s-licheepi-nano.dtb
>  dtb-$(CONFIG_ARCH_TANGO) += \
>  	tango4-vantage-1172.dtb
>  dtb-$(CONFIG_ARCH_TEGRA_2x_SOC) += \

The hunk above should go with your patch
"[RFC PATCH 9/9] ARM: suniv: f1c100s: add device tree for Lichee Pi Nano"
instead.

-- 
Rask Ingemann Lambertsen
