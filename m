From: gregory.clement@bootlin.com (Gregory CLEMENT)
Date: Wed, 26 Sep 2018 14:29:38 +0200
Subject: [PATCH 1/2] arm64: dts: marvell: armada-cp110: change the PPv2
 IRQ names
In-Reply-To: <20180924090002.27939-1-antoine.tenart@bootlin.com> (Antoine
 Tenart's message of "Mon, 24 Sep 2018 11:00:01 +0200")
References: <20180924090002.27939-1-antoine.tenart@bootlin.com>
Message-ID: <87ftxwe91p.fsf@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Antoine,
 
 On lun., sept. 24 2018, Antoine Tenart <antoine.tenart@bootlin.com> wrote:

> This patch changes the PPv2 IRQ names in the CP110 device tree to match
> a corresponding change in the Marvell PPv2 driver. The reason this was
> updated is the IRQ where names after Tx/Rx interrupts, but this is not
> true and can be configured. A following patch will add more of them and
> the names wouldn't make sense.
>
> Signed-off-by: Antoine Tenart <antoine.tenart@bootlin.com>

Applied on mvebu/dt64

Thanks,

Gregory
> ---
>  arch/arm64/boot/dts/marvell/armada-cp110.dtsi | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/marvell/armada-cp110.dtsi b/arch/arm64/boot/dts/marvell/armada-cp110.dtsi
> index 840c8454d03e..6a13690cf1e4 100644
> --- a/arch/arm64/boot/dts/marvell/armada-cp110.dtsi
> +++ b/arch/arm64/boot/dts/marvell/armada-cp110.dtsi
> @@ -53,8 +53,8 @@
>  					<ICU_GRP_NSR 51 IRQ_TYPE_LEVEL_HIGH>,
>  					<ICU_GRP_NSR 55 IRQ_TYPE_LEVEL_HIGH>,
>  					<ICU_GRP_NSR 129 IRQ_TYPE_LEVEL_HIGH>;
> -				interrupt-names = "tx-cpu0", "tx-cpu1", "tx-cpu2",
> -					"tx-cpu3", "rx-shared", "link";
> +				interrupt-names = "hif0", "hif1", "hif2",
> +					"hif3", "hif4", "link";
>  				port-id = <0>;
>  				gop-port-id = <0>;
>  				status = "disabled";
> @@ -67,8 +67,8 @@
>  					<ICU_GRP_NSR 52 IRQ_TYPE_LEVEL_HIGH>,
>  					<ICU_GRP_NSR 56 IRQ_TYPE_LEVEL_HIGH>,
>  					<ICU_GRP_NSR 128 IRQ_TYPE_LEVEL_HIGH>;
> -				interrupt-names = "tx-cpu0", "tx-cpu1", "tx-cpu2",
> -					"tx-cpu3", "rx-shared", "link";
> +				interrupt-names = "hif0", "hif1", "hif2",
> +					"hif3", "hif4", "link";
>  				port-id = <1>;
>  				gop-port-id = <2>;
>  				status = "disabled";
> @@ -81,8 +81,8 @@
>  					<ICU_GRP_NSR 53 IRQ_TYPE_LEVEL_HIGH>,
>  					<ICU_GRP_NSR 57 IRQ_TYPE_LEVEL_HIGH>,
>  					<ICU_GRP_NSR 127 IRQ_TYPE_LEVEL_HIGH>;
> -				interrupt-names = "tx-cpu0", "tx-cpu1", "tx-cpu2",
> -					"tx-cpu3", "rx-shared", "link";
> +				interrupt-names = "hif0", "hif1", "hif2",
> +					"hif3", "hif4", "link";
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
