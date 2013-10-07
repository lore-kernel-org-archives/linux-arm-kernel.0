From: nm@ti.com (Nishanth Menon)
Date: Mon, 7 Oct 2013 15:32:37 -0500
Subject: [PATCH V2] ARM: OMAP3: Fix hardware detection for omap3630 when
 booted with device tree
In-Reply-To: <1381177842-2678-1-git-send-email-nm@ti.com>
References: <20131007192009.GA8949@atomide.com>
 <1381177842-2678-1-git-send-email-nm@ti.com>
Message-ID: <52531A65.5070803@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/07/2013 03:30 PM, Nishanth Menon wrote:
[...]
> diff --git a/arch/arm/boot/dts/omap3-beagle-xm.dts b/arch/arm/boot/dts/omap3-beagle-xm.dts
> index 0c514dc..02dd4a9 100644
> --- a/arch/arm/boot/dts/omap3-beagle-xm.dts
> +++ b/arch/arm/boot/dts/omap3-beagle-xm.dts
> @@ -11,7 +11,7 @@
>  
>  / {
>  	model = "TI OMAP3 BeagleBoard xM";
> -	compatible = "ti,omap3-beagle-xm", "ti,omap3-beagle", "ti,omap3";
> +	compatible = "ti,omap3-beagle-xm", "ti,omap363x", "ti,omap3";

^^^ yikes - should have been ti,omap36xx -> apologies, my fix was not
committed in local branch :( - will update and resend - grr..


-- 
Regards,
Nishanth Menon
