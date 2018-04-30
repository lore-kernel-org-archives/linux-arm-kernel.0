From: gregory.clement@bootlin.com (Gregory CLEMENT)
Date: Mon, 30 Apr 2018 15:01:26 +0200
Subject: [PATCH 11/17] arm64: marvell: enable SEI driver
In-Reply-To: <20180421135537.24716-12-miquel.raynal@bootlin.com> (Miquel
 Raynal's message of "Sat, 21 Apr 2018 15:55:31 +0200")
References: <20180421135537.24716-1-miquel.raynal@bootlin.com>
 <20180421135537.24716-12-miquel.raynal@bootlin.com>
Message-ID: <87in88c0gp.fsf@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Miquel,
 
 On sam., avril 21 2018, Miquel Raynal <miquel.raynal@bootlin.com> wrote:

> Enable the newly introduced Marvell SEI driver for the 64-bit Marvell
> EBU platforms.
>
> Suggested-by: Haim Boot <hayim@marvell.com>
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>

Reviewed-by: Gregory CLEMENT <gregory.clement@bootlin.com>

Once the driver will be accepted, I will apply this patch on mvebu/arm64

Thanks,

Gregory


> ---
>  arch/arm64/Kconfig.platforms | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
> index 2b1535cdeb7c..dc3c42938051 100644
> --- a/arch/arm64/Kconfig.platforms
> +++ b/arch/arm64/Kconfig.platforms
> @@ -121,6 +121,7 @@ config ARCH_MVEBU
>  	select MVEBU_ICU
>  	select MVEBU_ODMI
>  	select MVEBU_PIC
> +	select MVEBU_SEI
>  	select OF_GPIO
>  	select PINCTRL
>  	select PINCTRL_ARMADA_37XX
> -- 
> 2.14.1
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
