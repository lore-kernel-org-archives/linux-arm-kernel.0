From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Fri, 06 Oct 2017 14:48:05 +0200
Subject: [PATCH 13/16] arm64: dts: marvell: armada-37xx: add UART clock
In-Reply-To: <20171006101344.15590-14-miquel.raynal@free-electrons.com>
 (Miquel Raynal's message of "Fri, 6 Oct 2017 12:13:41 +0200")
References: <20171006101344.15590-1-miquel.raynal@free-electrons.com>
 <20171006101344.15590-14-miquel.raynal@free-electrons.com>
Message-ID: <87shewe92y.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Miquel,
 
 On ven., oct. 06 2017, Miquel Raynal <miquel.raynal@free-electrons.com> wrote:

> Add the missing clock property to armada-3700 UART node.
>
> This clock will be used to derive the prescaler value to comply to the
> requested baudrate.
>
> Signed-off-by: Miquel Raynal <miquel.raynal@free-electrons.com>

Acked-by: Gregory CLEMENT <gregory.clement@free-electrons.com>

Thanks,

Gregory

> ---
>  arch/arm64/boot/dts/marvell/armada-37xx.dtsi | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm64/boot/dts/marvell/armada-37xx.dtsi b/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
> index b554cdaf5e53..a36d667f770e 100644
> --- a/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
> +++ b/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
> @@ -135,6 +135,7 @@
>  			uart0: serial at 12000 {
>  				compatible = "marvell,armada-3700-uart";
>  				reg = <0x12000 0x200>;
> +				clocks = <&xtalclk>;
>  				interrupts = <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
>  				status = "disabled";
>  			};
> -- 
> 2.11.0
>

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
