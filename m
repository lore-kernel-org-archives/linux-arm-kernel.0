From: narmstrong@baylibre.com (Neil Armstrong)
Date: Mon, 23 Jan 2017 09:55:49 +0100
Subject: [PATCH 06/18] ARM64: dts: meson-gxm-nexbox-a1: Drop UART comment
In-Reply-To: <20170120222118.21476-7-afaerber@suse.de>
References: <20170120222118.21476-1-afaerber@suse.de>
 <20170120222118.21476-7-afaerber@suse.de>
Message-ID: <cf00a71c-59cf-7eaf-d0c9-a4acd6a3a98b@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/20/2017 11:21 PM, Andreas F?rber wrote:
> Product pictures show no DB9 connector, so this seems copy&paste.
> 
> Cc: Neil Armstrong <narmstrong@baylibre.com>
> Signed-off-by: Andreas F?rber <afaerber@suse.de>
> ---
>  arch/arm64/boot/dts/amlogic/meson-gxm-nexbox-a1.dts | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/amlogic/meson-gxm-nexbox-a1.dts b/arch/arm64/boot/dts/amlogic/meson-gxm-nexbox-a1.dts
> index 5a337d339df1..439060652689 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-gxm-nexbox-a1.dts
> +++ b/arch/arm64/boot/dts/amlogic/meson-gxm-nexbox-a1.dts
> @@ -102,7 +102,6 @@
>  	};
>  };
>  
> -/* This UART is brought out to the DB9 connector */
>  &uart_AO {
>  	status = "okay";
>  	pinctrl-0 = <&uart_ao_a_pins>;
> 

Exact

Acked-by: Neil Armstrong <narmstrong@baylibre.com>
