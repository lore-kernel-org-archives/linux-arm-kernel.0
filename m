From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Fri, 15 Dec 2017 15:56:53 +0100
Subject: [PATCH] ARM: dts: armada-38x: Add NAND RB pinctrl information
In-Reply-To: <20171128084902.12134-1-sean.nyekjaer@prevas.dk> (Sean Nyekjaer's
 message of "Tue, 28 Nov 2017 09:49:02 +0100")
References: <20171128084902.12134-1-sean.nyekjaer@prevas.dk>
Message-ID: <87a7ykkpje.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sean,
 
 On mar., nov. 28 2017, Sean Nyekjaer <sean.nyekjaer@prevas.dk> wrote:

> Add pin control information for the NAND flash interface.
>
> Signed-off-by: Sean Nyekjaer <sean.nyekjaer@prevas.dk>

Applied on mvebu/dt

Thanks,

Gregory
> ---
>  arch/arm/boot/dts/armada-38x.dtsi | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/arch/arm/boot/dts/armada-38x.dtsi b/arch/arm/boot/dts/armada-38x.dtsi
> index 00ff549d4e39..a6cc568f74f7 100644
> --- a/arch/arm/boot/dts/armada-38x.dtsi
> +++ b/arch/arm/boot/dts/armada-38x.dtsi
> @@ -279,6 +279,11 @@
>  					marvell,function = "dev";
>  				};
>  
> +				nand_rb: nand-rb {
> +					marvell,pins = "mpp41";
> +					marvell,function = "nand";
> +				};
> +
>  				uart0_pins: uart-pins-0 {
>  					marvell,pins = "mpp0", "mpp1";
>  					marvell,function = "ua0";
> -- 
> 2.15.0
>

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
