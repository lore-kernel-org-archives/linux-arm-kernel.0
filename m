From: bcousson@baylibre.com (Benoit Cousson)
Date: Tue, 24 Sep 2013 11:35:17 +0200
Subject: [PATCH] ARM: DTS: omap3-devkit8000.dts: fix a typo
In-Reply-To: <1379720414-14960-1-git-send-email-aaro.koskinen@iki.fi>
References: <1379720414-14960-1-git-send-email-aaro.koskinen@iki.fi>
Message-ID: <52415CD5.8050209@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Aaro,

On 21/09/2013 01:40, Aaro Koskinen wrote:
> "gpmc,sync-clki-ps" is not defined/documented, it should be
> "gpmc,sync-clk-ps" instead.

Thanks for the fix. I've just applied it with a slight change in the 
subject for consistency:

ARM: dts: omap3-devkit8000: fix a typo in GMPC node

Regards,
Benoit

>
> Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
> ---
>   arch/arm/boot/dts/omap3-devkit8000.dts | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm/boot/dts/omap3-devkit8000.dts b/arch/arm/boot/dts/omap3-devkit8000.dts
> index 7ef2827..4665421 100644
> --- a/arch/arm/boot/dts/omap3-devkit8000.dts
> +++ b/arch/arm/boot/dts/omap3-devkit8000.dts
> @@ -125,7 +125,7 @@
>   		nand-bus-width = <16>;
>
>   		gpmc,device-nand;
> -		gpmc,sync-clki-ps = <0>;
> +		gpmc,sync-clk-ps = <0>;
>   		gpmc,cs-on-ns = <0>;
>   		gpmc,cs-rd-off-ns = <44>;
>   		gpmc,cs-wr-off-ns = <44>;
>
