From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Thu, 15 May 2014 18:11:59 +0200
Subject: [PATCH 2/2] ARM: at91/dt: add NAND + DMA property for at91sam9rl
In-Reply-To: <e1b405979615b46321a63df3f91f1998763b22fe.1400166895.git.nicolas.ferre@atmel.com>
References: <47a342121566bca0025a20a57282fb72c990ce09.1400166895.git.nicolas.ferre@atmel.com>
 <e1b405979615b46321a63df3f91f1998763b22fe.1400166895.git.nicolas.ferre@atmel.com>
Message-ID: <20140515161159.GU29318@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15/05/2014 at 17:15:24 +0200, Nicolas Ferre wrote :
> Add the "atmel,nand-has-dma" property to NAND node
> 
> Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
Acked-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> ---
>  arch/arm/boot/dts/at91sam9rl.dtsi | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/boot/dts/at91sam9rl.dtsi b/arch/arm/boot/dts/at91sam9rl.dtsi
> index 412617084cfd..f21163c7dc2b 100644
> --- a/arch/arm/boot/dts/at91sam9rl.dtsi
> +++ b/arch/arm/boot/dts/at91sam9rl.dtsi
> @@ -95,6 +95,7 @@
>  			      <0xffffe800 0x200>;
>  			atmel,nand-addr-offset = <21>;
>  			atmel,nand-cmd-offset = <22>;
> +			atmel,nand-has-dma;
>  			pinctrl-names = "default";
>  			pinctrl-0 = <&pinctrl_nand>;
>  			gpios = <&pioD 17 GPIO_ACTIVE_HIGH>,
> -- 
> 1.8.2.2
> 

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
