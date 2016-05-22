From: heiko@sntech.de (Heiko Stuebner)
Date: Sun, 22 May 2016 11:27:34 +0200
Subject: [PATCH 05/54] MAINTAINERS: Add file patterns for rockchip device
 tree bindings
In-Reply-To: <1463907991-7916-6-git-send-email-geert@linux-m68k.org>
References: <1463907991-7916-1-git-send-email-geert@linux-m68k.org>
 <1463907991-7916-6-git-send-email-geert@linux-m68k.org>
Message-ID: <1575416.jfSztnP7S8@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Geert,

Am Sonntag, 22. Mai 2016, 11:05:42 schrieb Geert Uytterhoeven:
> Submitters of device tree binding documentation may forget to CC
> the subsystem maintainer if this is missing.

The "N:	rockchip" line at the bottom of the block catches this nicely 
already (also just verified with a get_maintainer.pl -f call), so I don't 
think this new more explicit line is really necessary?


Thanks
Heiko


> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Cc: Heiko Stuebner <heiko@sntech.de>
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: linux-rockchip at lists.infradead.org
> ---
> Please apply this patch directly if you want to be involved in device
> tree binding documentation for your subsystem.
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index ea4e25a2f188aca1..e6b84eba4d574d13 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1577,6 +1577,7 @@ L:	linux-arm-kernel at lists.infradead.org (moderated
> for non-subscribers) L:	linux-rockchip at lists.infradead.org
>  T:	git
> git://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip.git
> S:	Maintained
> +F:	Documentation/devicetree/bindings/soc/rockchip/
>  F:	arch/arm/boot/dts/rk3*
>  F:	arch/arm/mach-rockchip/
>  F:	drivers/clk/rockchip/
