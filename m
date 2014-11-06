From: tony@atomide.com (Tony Lindgren)
Date: Thu, 6 Nov 2014 10:21:32 -0800
Subject: [PATCH] ARM: dts: am335x-evm: Fix 5th NAND partition's name
In-Reply-To: <1413890745-3855-1-git-send-email-rogerq@ti.com>
References: <1413890745-3855-1-git-send-email-rogerq@ti.com>
Message-ID: <20141106182131.GB31454@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Roger Quadros <rogerq@ti.com> [141021 04:27]:
> The 5th NAND partition should be named "NAND.u-boot-spl-os"
> instead of "NAND.u-boot-spl". This is to be consistent with other
> TI boards as well as u-boot.

Applying into omap-for-v3.18/fixes thanks.

Tony
 
> Fixes: 91994facdd2d ("ARM: dts: am335x-evm: NAND: update MTD partition table")
> 
> Signed-off-by: Roger Quadros <rogerq@ti.com>
> Signed-off-by: Sekhar Nori <nsekhar@ti.com>
> ---
>  arch/arm/boot/dts/am335x-evm.dts | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/am335x-evm.dts b/arch/arm/boot/dts/am335x-evm.dts
> index e2156a5..c4b968f 100644
> --- a/arch/arm/boot/dts/am335x-evm.dts
> +++ b/arch/arm/boot/dts/am335x-evm.dts
> @@ -489,7 +489,7 @@
>  			reg = <0x00060000 0x00020000>;
>  		};
>  		partition at 4 {
> -			label = "NAND.u-boot-spl";
> +			label = "NAND.u-boot-spl-os";
>  			reg = <0x00080000 0x00040000>;
>  		};
>  		partition at 5 {
> -- 
> 1.8.3.2
> 
