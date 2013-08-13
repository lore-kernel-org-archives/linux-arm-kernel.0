From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 13 Aug 2013 16:43:31 +0100
Subject: [PATCH 14/22] ARM: dts: Remove '0x's from OMAP3 IGEP0030 DTS file
In-Reply-To: <1374490361-25769-14-git-send-email-lee.jones@linaro.org>
References: <1374490361-25769-1-git-send-email-lee.jones@linaro.org>
 <1374490361-25769-14-git-send-email-lee.jones@linaro.org>
Message-ID: <20130813154331.GF15278@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tony, Benoit,

Poke

On Mon, 22 Jul 2013, Lee Jones wrote:

> Cc: Beno?t Cousson <b-cousson@ti.com>
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: linux-omap at vger.kernel.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  arch/arm/boot/dts/omap3-igep0030.dts | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/omap3-igep0030.dts b/arch/arm/boot/dts/omap3-igep0030.dts
> index 644d0538..f628200 100644
> --- a/arch/arm/boot/dts/omap3-igep0030.dts
> +++ b/arch/arm/boot/dts/omap3-igep0030.dts
> @@ -74,19 +74,19 @@
>  			label = "SPL";
>  			reg = <0 0x100000>;
>  		};
> -		partition at 0x80000 {
> +		partition at 80000 {
>  			label = "U-Boot";
>  			reg = <0x100000 0x180000>;
>  		};
> -		partition at 0x1c0000 {
> +		partition at 1c0000 {
>  			label = "Environment";
>  			reg = <0x280000 0x100000>;
>  		};
> -		partition at 0x280000 {
> +		partition at 280000 {
>  			label = "Kernel";
>  			reg = <0x380000 0x300000>;
>  		};
> -		partition at 0x780000 {
> +		partition at 780000 {
>  			label = "Filesystem";
>  			reg = <0x680000 0x1f980000>;
>  		};

-- 
Lee Jones
Linaro ST-Ericsson Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
