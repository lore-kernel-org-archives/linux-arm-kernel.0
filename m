From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Tue, 31 Jan 2017 12:12:44 +0100
Subject: [PATCH] arm: mvebu: Fix whitespace in armada-xp-98dx3236.dtsi
In-Reply-To: <20170131034209.3848-1-chris.packham@alliedtelesis.co.nz> (Chris
 Packham's message of "Tue, 31 Jan 2017 16:42:09 +1300")
References: <20170131034209.3848-1-chris.packham@alliedtelesis.co.nz>
Message-ID: <8737fz1o0j.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Chris,
 
 On mar., janv. 31 2017, Chris Packham <chris.packham@alliedtelesis.co.nz> wrote:

> Change sequences of 8 spaces to hard-tabs.
>
> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>

Here again I directly squashed this patch in "ARM: dts: mvebu: Add
device tree for 98DX3236 SoCs". By the way I also fixed the topic, as
for device tree files the topic must start by "ARM: dts: "

Thanks,

Gregory

> ---
> I think this crept in during review and I didn't notice. The file is new enough
> that we shouldn't lose any useful history.
>
>  arch/arm/boot/dts/armada-xp-98dx3236.dtsi | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/arch/arm/boot/dts/armada-xp-98dx3236.dtsi b/arch/arm/boot/dts/armada-xp-98dx3236.dtsi
> index 9461128fae24..f6a03dcee5ef 100644
> --- a/arch/arm/boot/dts/armada-xp-98dx3236.dtsi
> +++ b/arch/arm/boot/dts/armada-xp-98dx3236.dtsi
> @@ -201,13 +201,13 @@
>  			#size-cells = <1>;
>  			ranges = <0 MBUS_ID(0x08, 0x00) 0 0x100000>;
>  
> -                        dfx_coredivclk: corediv-clock at f8268 {
> -                                compatible = "marvell,mv98dx3236-corediv-clock";
> -                                reg = <0xf8268 0xc>;
> -                                #clock-cells = <1>;
> -                                clocks = <&mainpll>;
> -                                clock-output-names = "nand";
> -                        };
> +			dfx_coredivclk: corediv-clock at f8268 {
> +				compatible = "marvell,mv98dx3236-corediv-clock";
> +				reg = <0xf8268 0xc>;
> +				#clock-cells = <1>;
> +				clocks = <&mainpll>;
> +				clock-output-names = "nand";
> +			};
>  
>  			dfx: dfx at 0 {
>  				compatible = "marvell,dfx-server";
> -- 
> 2.11.0.24.ge6920cf
>

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
