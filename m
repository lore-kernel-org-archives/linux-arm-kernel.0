From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Thu, 12 Oct 2017 15:53:31 +0200
Subject: [PATCH] arm64: dts: marvell: 7040-db: Document the gpio expander
In-Reply-To: <20171005160511.23683-1-gregory.clement@free-electrons.com>
 (Gregory CLEMENT's message of "Thu, 5 Oct 2017 18:05:11 +0200")
References: <20171005160511.23683-1-gregory.clement@free-electrons.com>
Message-ID: <87fuaobhgk.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,
 
 On jeu., oct. 05 2017, Gregory CLEMENT <gregory.clement@free-electrons.com> wrote:

> Document all the GPIO of the expander based on the schematics
>


Applied on mvebu/dt64

Gregory


> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
> ---
>  arch/arm64/boot/dts/marvell/armada-7040-db.dts | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/marvell/armada-7040-db.dts b/arch/arm64/boot/dts/marvell/armada-7040-db.dts
> index 8f3b395c786c..18a75fad1e8d 100644
> --- a/arch/arm64/boot/dts/marvell/armada-7040-db.dts
> +++ b/arch/arm64/boot/dts/marvell/armada-7040-db.dts
> @@ -143,6 +143,16 @@
>  		gpio-controller;
>  		#gpio-cells = <2>;
>  		reg = <0x21>;
> +		/*
> +		 * IO0_0: USB3_PWR_EN0	IO1_0: USB_3_1_Dev_Detect
> +		 * IO0_1: USB3_PWR_EN1	IO1_1: USB2_1_current_limit
> +		 * IO0_2: DDR3_4_Detect	IO1_2: Hcon_IO_RstN
> +		 * IO0_3: USB2_DEVICE_DETECT
> +		 * IO0_4: GPIO_0	IO1_4: SD_Status
> +		 * IO0_5: GPIO_1	IO1_5: LDO_5V_Enable
> +		 * IO0_6: IHB_5V_Enable	IO1_6: PWR_EN_eMMC
> +		 * IO0_7:		IO1_7: SDIO_Vcntrl
> +		 */
>  	};
>  };
>  
> -- 
> 2.14.2
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
