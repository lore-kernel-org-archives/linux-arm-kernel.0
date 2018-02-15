From: horms@verge.net.au (Simon Horman)
Date: Thu, 15 Feb 2018 17:18:54 +0100
Subject: [PATCH 3/9] ARM: dts: kzm9d: Fix "debounce-interval" property
 misspelling
In-Reply-To: <1518531335-5170-4-git-send-email-geert+renesas@glider.be>
References: <1518531335-5170-1-git-send-email-geert+renesas@glider.be>
 <1518531335-5170-4-git-send-email-geert+renesas@glider.be>
Message-ID: <20180215161853.m5wqgj6myjla3aab@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[Cc linux-renesas-soc]

On Tue, Feb 13, 2018 at 03:15:29PM +0100, Geert Uytterhoeven wrote:
> "debounce_interval" was never supported.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Cc: Simon Horman <horms@verge.net.au>
> Cc: Magnus Damm <magnus.damm@gmail.com>
> ---
> Please apply to your tree when appropriate.

Thanks, applied.

> 
>  arch/arm/boot/dts/emev2-kzm9d.dts | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/emev2-kzm9d.dts b/arch/arm/boot/dts/emev2-kzm9d.dts
> index 60d0a732833aaada..c238407133bfe2d7 100644
> --- a/arch/arm/boot/dts/emev2-kzm9d.dts
> +++ b/arch/arm/boot/dts/emev2-kzm9d.dts
> @@ -38,28 +38,28 @@
>  		#size-cells = <0>;
>  
>  		one {
> -			debounce_interval = <50>;
> +			debounce-interval = <50>;
>  			wakeup-source;
>  			label = "DSW2-1";
>  			linux,code = <KEY_1>;
>  			gpios = <&gpio0 14 GPIO_ACTIVE_HIGH>;
>  		};
>  		two {
> -			debounce_interval = <50>;
> +			debounce-interval = <50>;
>  			wakeup-source;
>  			label = "DSW2-2";
>  			linux,code = <KEY_2>;
>  			gpios = <&gpio0 15 GPIO_ACTIVE_HIGH>;
>  		};
>  		three {
> -			debounce_interval = <50>;
> +			debounce-interval = <50>;
>  			wakeup-source;
>  			label = "DSW2-3";
>  			linux,code = <KEY_3>;
>  			gpios = <&gpio0 16 GPIO_ACTIVE_HIGH>;
>  		};
>  		four {
> -			debounce_interval = <50>;
> +			debounce-interval = <50>;
>  			wakeup-source;
>  			label = "DSW2-4";
>  			linux,code = <KEY_4>;
> -- 
> 2.7.4
> 
