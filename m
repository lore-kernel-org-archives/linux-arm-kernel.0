From: narmstrong@baylibre.com (Neil Armstrong)
Date: Mon, 15 May 2017 10:17:25 +0200
Subject: [PATCH v2 07/18] arm64: dts: meson-gxm-nexbox-a1: Drop UART
 comment
In-Reply-To: <20170513143337.14278-8-afaerber@suse.de>
References: <20170513143337.14278-1-afaerber@suse.de>
 <20170513143337.14278-8-afaerber@suse.de>
Message-ID: <cee9af76-7d3c-6a56-9a49-7897a20e09eb@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/13/2017 04:33 PM, Andreas F?rber wrote:
> Product pictures show no DB9 connector, so this seems copy&paste.
> 
> Acked-by: Neil Armstrong <narmstrong@baylibre.com>
> Signed-off-by: Andreas F?rber <afaerber@suse.de>
> ---
>  v1 -> v2: Unchanged
>  
>  arch/arm64/boot/dts/amlogic/meson-gxm-nexbox-a1.dts | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/amlogic/meson-gxm-nexbox-a1.dts b/arch/arm64/boot/dts/amlogic/meson-gxm-nexbox-a1.dts
> index 11b0bf46a95c..920fac10de93 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-gxm-nexbox-a1.dts
> +++ b/arch/arm64/boot/dts/amlogic/meson-gxm-nexbox-a1.dts
> @@ -113,7 +113,6 @@
>  	};
>  };
>  
> -/* This UART is brought out to the DB9 connector */
>  &uart_AO {
>  	status = "okay";
>  	pinctrl-0 = <&uart_ao_a_pins>;
> 

Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
