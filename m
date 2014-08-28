From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 28 Aug 2014 10:17:58 +0100
Subject: [RESEND PATCH] ARM: dts: make arch-timer always on in rk3288 soc
In-Reply-To: <1409190017-12656-1-git-send-email-kever.yang@rock-chips.com>
References: <1409190017-12656-1-git-send-email-kever.yang@rock-chips.com>
Message-ID: <20140828091758.GB14650@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kever,

On Thu, Aug 28, 2014 at 02:40:17AM +0100, Kever Yang wrote:
> We need use the hrtimer, which need the arch-timer to be 'always-on'

I asked a question on the last posting [1]. Can you please confirm
either way?

Thanks,
Mark.

[1] lists.infradead.org/pipermail/linux-arm-kernel/2014-August/282327.html

> Signed-off-by: Kever Yang <kever.yang@rock-chips.com>
> ---
> 
>  arch/arm/boot/dts/rk3288.dtsi | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/boot/dts/rk3288.dtsi b/arch/arm/boot/dts/rk3288.dtsi
> index 5950b0a..698e6ea 100644
> --- a/arch/arm/boot/dts/rk3288.dtsi
> +++ b/arch/arm/boot/dts/rk3288.dtsi
> @@ -76,6 +76,7 @@
>  			     <GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>,
>  			     <GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
>  		clock-frequency = <24000000>;
> +		always-on;
>  	};
>  
>  	i2c1: i2c at ff140000 {
> -- 
> 1.9.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
