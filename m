From: narmstrong@baylibre.com (Neil Armstrong)
Date: Fri, 9 Feb 2018 10:04:04 +0100
Subject: [PATCH 08/10] ARM64: dts: meson: Remove "cooling-{min|max}-level"
 for gpio-fan node
In-Reply-To: <24b53440922491982c781a3eb032b04c167d733d.1518166039.git.viresh.kumar@linaro.org>
References: <cover.1518166039.git.viresh.kumar@linaro.org>
 <24b53440922491982c781a3eb032b04c167d733d.1518166039.git.viresh.kumar@linaro.org>
Message-ID: <3237154b-18a9-9e8b-1e5f-a7ce261fe3ae@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/02/2018 09:58, Viresh Kumar wrote:
> The "cooling-min-level" and "cooling-max-level" properties are not
> parsed by any part of the kernel currently and the max cooling state of
> gpio-fan cooling device is found by referring to the
> "gpio-fan,speed-map" instead.
> 
> Remove the unused properties from the gpio-fan node.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts b/arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts
> index 658215c9822c..8ee4a693c438 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts
> +++ b/arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts
> @@ -59,8 +59,6 @@
>  				      1 1
>  				      2 2
>  				      3 3>;
> -		cooling-min-level = <0>;
> -		cooling-max-level = <3>;
>  		#cooling-cells = <2>;
>  	};
>  
> 

Acked-by: Neil Armstrong <narmstrong@baylibre.com>
