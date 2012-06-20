From: tony@atomide.com (Tony Lindgren)
Date: Wed, 20 Jun 2012 07:48:59 -0700
Subject: [PATCH RESEND] ARM: omap: Fix dts files w/ status property:
 "disable" -> "disabled"
In-Reply-To: <1340051110-23746-1-git-send-email-stigge@antcom.de>
References: <1340051110-23746-1-git-send-email-stigge@antcom.de>
Message-ID: <20120620144859.GS12766@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Roland Stigge <stigge@antcom.de> [120618 13:29]:
> This patches fixes some status = "disable" strings to "disabled", the correct
> way of disabling nodes in the devicetree.
> 
> Just the OMAP part here, the rest goes via other patches and trees.

Thanks applying into fixes.

Tony
 
> Signed-off-by: Roland Stigge <stigge@antcom.de>
> Acked-by: Rob Herring <rob.herring@calxeda.com>
> Acked-by: Benoit Cousson <b-cousson@ti.com>
> 
> ---
> Applies to v3.5-rc3
> 
>  arch/arm/boot/dts/omap3-beagle.dts |    4 ++--
>  arch/arm/boot/dts/omap4-panda.dts  |    6 +++---
>  arch/arm/boot/dts/omap4-sdp.dts    |    4 ++--
>  3 files changed, 7 insertions(+), 7 deletions(-)
> 
> --- linux-2.6.orig/arch/arm/boot/dts/omap3-beagle.dts
> +++ linux-2.6/arch/arm/boot/dts/omap3-beagle.dts
> @@ -61,9 +61,9 @@
>  };
>  
>  &mmc2 {
> -	status = "disable";
> +	status = "disabled";
>  };
>  
>  &mmc3 {
> -	status = "disable";
> +	status = "disabled";
>  };
> --- linux-2.6.orig/arch/arm/boot/dts/omap4-panda.dts
> +++ linux-2.6/arch/arm/boot/dts/omap4-panda.dts
> @@ -74,15 +74,15 @@
>  };
>  
>  &mmc2 {
> -	status = "disable";
> +	status = "disabled";
>  };
>  
>  &mmc3 {
> -	status = "disable";
> +	status = "disabled";
>  };
>  
>  &mmc4 {
> -	status = "disable";
> +	status = "disabled";
>  };
>  
>  &mmc5 {
> --- linux-2.6.orig/arch/arm/boot/dts/omap4-sdp.dts
> +++ linux-2.6/arch/arm/boot/dts/omap4-sdp.dts
> @@ -147,11 +147,11 @@
>  };
>  
>  &mmc3 {
> -	status = "disable";
> +	status = "disabled";
>  };
>  
>  &mmc4 {
> -	status = "disable";
> +	status = "disabled";
>  };
>  
>  &mmc5 {
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
