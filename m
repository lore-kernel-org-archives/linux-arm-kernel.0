From: nm@ti.com (Nishanth Menon)
Date: Thu, 13 Feb 2014 08:41:36 -0600
Subject: [PATCH v2 2/4] ARM: dts: omap3-tobi: Use the correct vendor prefix
In-Reply-To: <1392287116-4548-3-git-send-email-florian.vaussard@epfl.ch>
References: <1392287116-4548-1-git-send-email-florian.vaussard@epfl.ch>
 <1392287116-4548-3-git-send-email-florian.vaussard@epfl.ch>
Message-ID: <52FCD9A0.1070600@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/13/2014 04:25 AM, Florian Vaussard wrote:
> Gumstix is the correct vendor for all Overo related products.
> 
> Reported-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
> Signed-off-by: Florian Vaussard <florian.vaussard@epfl.ch>
Acked-by: Nishanth Menon <nm@ti.com>
> ---
>  arch/arm/boot/dts/omap3-tobi.dts | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/omap3-tobi.dts b/arch/arm/boot/dts/omap3-tobi.dts
> index 0e3b8bf..c742afa 100644
> --- a/arch/arm/boot/dts/omap3-tobi.dts
> +++ b/arch/arm/boot/dts/omap3-tobi.dts
> @@ -17,7 +17,7 @@
>  
>  / {
>  	model = "TI OMAP3 Gumstix Overo on Tobi";
> -	compatible = "ti,omap3-tobi", "ti,omap3-overo", "ti,omap36xx", "ti,omap3";
> +	compatible = "gumstix,omap3-tobi", "gumstix,omap3-overo", "ti,omap36xx", "ti,omap3";
>  
>  	leds {
>  		compatible = "gpio-leds";
> 


-- 
Regards,
Nishanth Menon
