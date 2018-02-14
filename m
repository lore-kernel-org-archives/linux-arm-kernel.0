From: gregory.clement@bootlin.com (Gregory CLEMENT)
Date: Wed, 14 Feb 2018 11:46:08 +0100
Subject: [PATCH] arm64: dts: marvell: mcbin: fix board name typo
In-Reply-To: <19520b813a8f8f9ac3d8cbd777a955c8cd6eccdf.1517382055.git.baruch@tkos.co.il>
 (Baruch Siach's message of "Wed, 31 Jan 2018 09:00:55 +0200")
References: <19520b813a8f8f9ac3d8cbd777a955c8cd6eccdf.1517382055.git.baruch@tkos.co.il>
Message-ID: <87r2pnonm7.fsf@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Baruch,
 
 On mer., janv. 31 2018, Baruch Siach <baruch@tkos.co.il> wrote:

> Signed-off-by: Baruch Siach <baruch@tkos.co.il>

Applied on mvebu/dt64, I also add the following commit log to avoid
having an empty one:

"A 'C' was missing in the model name, this patch fixes it."

Thanks,

Gregory
> ---
>  arch/arm64/boot/dts/marvell/armada-8040-mcbin.dts | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm64/boot/dts/marvell/armada-8040-mcbin.dts b/arch/arm64/boot/dts/marvell/armada-8040-mcbin.dts
> index 122d2257ebc4..787bc6c44e2d 100644
> --- a/arch/arm64/boot/dts/marvell/armada-8040-mcbin.dts
> +++ b/arch/arm64/boot/dts/marvell/armada-8040-mcbin.dts
> @@ -49,7 +49,7 @@
>  #include <dt-bindings/gpio/gpio.h>
>  
>  / {
> -	model = "Marvell 8040 MACHIATOBin";
> +	model = "Marvell 8040 MACCHIATOBin";
>  	compatible = "marvell,armada8040-mcbin", "marvell,armada8040",
>  			"marvell,armada-ap806-quad", "marvell,armada-ap806";
>  
> -- 
> 2.15.1
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

-- 
Gregory Clement, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
http://bootlin.com
