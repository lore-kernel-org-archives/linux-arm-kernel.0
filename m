From: tony@atomide.com (Tony Lindgren)
Date: Mon, 2 Jul 2018 03:43:46 -0700
Subject: [PATCH v2] ARM: dts: am437x: make edt-ft5x06 a wakeup source
In-Reply-To: <20180617115309.1341-1-daniel@zonque.org>
References: <20180617115309.1341-1-daniel@zonque.org>
Message-ID: <20180702104346.GP112168@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Daniel Mack <daniel@zonque.org> [180617 04:56]:
> The touchscreen driver no longer configures the device as wakeup source by
> default. A "wakeup-source" property is needed.
> 
> Signed-off-by: Daniel Mack <daniel@zonque.org>
> ---
> v1 ? v2: amended subject to not mention imx6 anymore

Sorry for the delay in responding, applying into omap-for-v4.18/fixes.

Thanks,

Tony

>  arch/arm/boot/dts/am437x-sk-evm.dts | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/am437x-sk-evm.dts b/arch/arm/boot/dts/am437x-sk-evm.dts
> index 440351ad0b80..d4be3fd0b6f4 100644
> --- a/arch/arm/boot/dts/am437x-sk-evm.dts
> +++ b/arch/arm/boot/dts/am437x-sk-evm.dts
> @@ -610,6 +610,8 @@
>  
>  		touchscreen-size-x = <480>;
>  		touchscreen-size-y = <272>;
> +
> +		wakeup-source;
>  	};
>  
>  	tlv320aic3106: tlv320aic3106 at 1b {
> -- 
> 2.17.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
