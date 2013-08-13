From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 13 Aug 2013 16:42:29 +0100
Subject: [PATCH 17/22] ARM: dts: Remove '0x's from OMAP4 DTS file
In-Reply-To: <1374490361-25769-17-git-send-email-lee.jones@linaro.org>
References: <1374490361-25769-1-git-send-email-lee.jones@linaro.org>
 <1374490361-25769-17-git-send-email-lee.jones@linaro.org>
Message-ID: <20130813154229.GC15278@lee--X1>
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
>  arch/arm/boot/dts/omap4.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/omap4.dtsi b/arch/arm/boot/dts/omap4.dtsi
> index 22d9f2b..45708e1 100644
> --- a/arch/arm/boot/dts/omap4.dtsi
> +++ b/arch/arm/boot/dts/omap4.dtsi
> @@ -56,7 +56,7 @@
>  		cache-level = <2>;
>  	};
>  
> -	local-timer at 0x48240600 {
> +	local-timer at 48240600 {
>  		compatible = "arm,cortex-a9-twd-timer";
>  		reg = <0x48240600 0x20>;
>  		interrupts = <GIC_PPI 13 (GIC_CPU_MASK_RAW(3) | IRQ_TYPE_LEVEL_HIGH)>;

-- 
Lee Jones
Linaro ST-Ericsson Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
