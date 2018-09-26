From: gregory.clement@bootlin.com (Gregory CLEMENT)
Date: Wed, 26 Sep 2018 14:30:09 +0200
Subject: [PATCH 2/2] arm64: dts: marvell: armada-cp110: describe more PPv2
 interrupts
In-Reply-To: <20180924090002.27939-2-antoine.tenart@bootlin.com> (Antoine
 Tenart's message of "Mon, 24 Sep 2018 11:00:02 +0200")
References: <20180924090002.27939-1-antoine.tenart@bootlin.com>
 <20180924090002.27939-2-antoine.tenart@bootlin.com>
Message-ID: <87bm8ke90u.fsf@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Antoine,
 
 On lun., sept. 24 2018, Antoine Tenart <antoine.tenart@bootlin.com> wrote:

> This patch describes 3 additional interrupts per PPv2 port. Those
> interrupts will be used later in future versions of the Marvell PPv2
> driver, and now the device tree description matches the hardware
> capabilities.
>
> Signed-off-by: Antoine Tenart <antoine.tenart@bootlin.com>

Applied on mvebu/dt64

Thanks,

Gregory
> ---
>  arch/arm64/boot/dts/marvell/armada-cp110.dtsi | 21 ++++++++++++++++---
>  1 file changed, 18 insertions(+), 3 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/marvell/armada-cp110.dtsi b/arch/arm64/boot/dts/marvell/armada-cp110.dtsi
> index 6a13690cf1e4..26d6e602d1ec 100644
> --- a/arch/arm64/boot/dts/marvell/armada-cp110.dtsi
> +++ b/arch/arm64/boot/dts/marvell/armada-cp110.dtsi
> @@ -52,9 +52,14 @@
>  					<ICU_GRP_NSR 47 IRQ_TYPE_LEVEL_HIGH>,
>  					<ICU_GRP_NSR 51 IRQ_TYPE_LEVEL_HIGH>,
>  					<ICU_GRP_NSR 55 IRQ_TYPE_LEVEL_HIGH>,
> +					<ICU_GRP_NSR 59 IRQ_TYPE_LEVEL_HIGH>,
> +					<ICU_GRP_NSR 63 IRQ_TYPE_LEVEL_HIGH>,
> +					<ICU_GRP_NSR 67 IRQ_TYPE_LEVEL_HIGH>,
> +					<ICU_GRP_NSR 71 IRQ_TYPE_LEVEL_HIGH>,
>  					<ICU_GRP_NSR 129 IRQ_TYPE_LEVEL_HIGH>;
>  				interrupt-names = "hif0", "hif1", "hif2",
> -					"hif3", "hif4", "link";
> +					"hif3", "hif4", "hif5", "hif6", "hif7",
> +					"hif8", "link";
>  				port-id = <0>;
>  				gop-port-id = <0>;
>  				status = "disabled";
> @@ -66,9 +71,14 @@
>  					<ICU_GRP_NSR 48 IRQ_TYPE_LEVEL_HIGH>,
>  					<ICU_GRP_NSR 52 IRQ_TYPE_LEVEL_HIGH>,
>  					<ICU_GRP_NSR 56 IRQ_TYPE_LEVEL_HIGH>,
> +					<ICU_GRP_NSR 60 IRQ_TYPE_LEVEL_HIGH>,
> +					<ICU_GRP_NSR 64 IRQ_TYPE_LEVEL_HIGH>,
> +					<ICU_GRP_NSR 68 IRQ_TYPE_LEVEL_HIGH>,
> +					<ICU_GRP_NSR 72 IRQ_TYPE_LEVEL_HIGH>,
>  					<ICU_GRP_NSR 128 IRQ_TYPE_LEVEL_HIGH>;
>  				interrupt-names = "hif0", "hif1", "hif2",
> -					"hif3", "hif4", "link";
> +					"hif3", "hif4", "hif5", "hif6", "hif7",
> +					"hif8", "link";
>  				port-id = <1>;
>  				gop-port-id = <2>;
>  				status = "disabled";
> @@ -80,9 +90,14 @@
>  					<ICU_GRP_NSR 49 IRQ_TYPE_LEVEL_HIGH>,
>  					<ICU_GRP_NSR 53 IRQ_TYPE_LEVEL_HIGH>,
>  					<ICU_GRP_NSR 57 IRQ_TYPE_LEVEL_HIGH>,
> +					<ICU_GRP_NSR 61 IRQ_TYPE_LEVEL_HIGH>,
> +					<ICU_GRP_NSR 65 IRQ_TYPE_LEVEL_HIGH>,
> +					<ICU_GRP_NSR 69 IRQ_TYPE_LEVEL_HIGH>,
> +					<ICU_GRP_NSR 73 IRQ_TYPE_LEVEL_HIGH>,
>  					<ICU_GRP_NSR 127 IRQ_TYPE_LEVEL_HIGH>;
>  				interrupt-names = "hif0", "hif1", "hif2",
> -					"hif3", "hif4", "link";
> +					"hif3", "hif4", "hif5", "hif6", "hif7",
> +					"hif8", "link";
>  				port-id = <2>;
>  				gop-port-id = <3>;
>  				status = "disabled";
> -- 
> 2.17.1
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

-- 
Gregory Clement, Bootlin
Embedded Linux and Kernel engineering
http://bootlin.com
