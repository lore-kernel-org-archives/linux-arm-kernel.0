From: bcousson@baylibre.com (Benoit Cousson)
Date: Wed, 14 Aug 2013 10:08:11 +0200
Subject: [PATCH] ARM: dts: omap3-beagle-xm: fix string error in compatible
 property
In-Reply-To: <1375884855-19414-1-git-send-email-robertcnelson@gmail.com>
References: <1375884855-19414-1-git-send-email-robertcnelson@gmail.com>
Message-ID: <520B3AEB.4030809@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Robert,

On 07/08/2013 16:14, Robert Nelson wrote:
> Signed-off-by: Robert Nelson <robertcnelson@gmail.com>
> ---
>   arch/arm/boot/dts/omap3-beagle-xm.dts |    2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm/boot/dts/omap3-beagle-xm.dts b/arch/arm/boot/dts/omap3-beagle-xm.dts
> index afdb164..0c514dc 100644
> --- a/arch/arm/boot/dts/omap3-beagle-xm.dts
> +++ b/arch/arm/boot/dts/omap3-beagle-xm.dts
> @@ -11,7 +11,7 @@
>
>   / {
>   	model = "TI OMAP3 BeagleBoard xM";
> -	compatible = "ti,omap3-beagle-xm, ti,omap3-beagle", "ti,omap3";
> +	compatible = "ti,omap3-beagle-xm", "ti,omap3-beagle", "ti,omap3";

Thanks for the fix.

I'll apply it for -rc6.

Regards,
Benoit
