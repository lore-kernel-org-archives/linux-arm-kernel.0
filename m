From: pmeerw@pmeerw.net (Peter Meerwald)
Date: Tue, 22 Jul 2014 21:46:47 +0200 (CEST)
Subject: [PATCH v2 2/7] arm: dts: omap3-gta04: Fix magnetometer model
In-Reply-To: <1406057420-22269-3-git-send-email-marek@goldelico.com>
References: <1406057420-22269-1-git-send-email-marek@goldelico.com>
 <1406057420-22269-3-git-send-email-marek@goldelico.com>
Message-ID: <alpine.DEB.2.01.1407222145360.27558@pmeerw.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> gta04 is using hmc5843l not hmc5843 so fix wrong compatible
> entry.

I guess you mean hmc5883l
 
> Signed-off-by: Marek Belisko <marek@goldelico.com>
> ---
>  arch/arm/boot/dts/omap3-gta04.dts | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/omap3-gta04.dts b/arch/arm/boot/dts/omap3-gta04.dts
> index 7d7ddd7..6d1a8d8 100644
> --- a/arch/arm/boot/dts/omap3-gta04.dts
> +++ b/arch/arm/boot/dts/omap3-gta04.dts
> @@ -220,7 +220,7 @@
>  
>  	/* compass aka magnetometer */
>  	hmc5843 at 1e {
> -		compatible = "honeywell,hmc5843";
> +		compatible = "honeywell,hmc5843l";
>  		reg = <0x1e>;
>  	};
>  
> 

-- 

Peter Meerwald
+43-664-2444418 (mobile)
