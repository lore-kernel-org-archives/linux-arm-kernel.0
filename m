From: heiko@sntech.de (Heiko Stuebner)
Date: Mon, 11 May 2015 23:57:50 +0200
Subject: [PATCH 2/2] ARM: dts: rockchip: add system-power-controller to
 act8846
In-Reply-To: <64DE272A-FD25-406C-A51B-6C5B76DA5171@stud.hs-offenburg.de>
References: <64DE272A-FD25-406C-A51B-6C5B76DA5171@stud.hs-offenburg.de>
Message-ID: <2270228.43yCmaWq86@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Montag, 11. Mai 2015, 22:57:21 schrieb Michael Niew?hner:
> Add system-power-controller to act8846 in rk3188-radxarock.dts in addition
> to the act8846 patch fixing the reboot kernel panic
> 
> Signed-off-by: Michael Niewoehner <mniewoeh@stud.hs-offenburg.de>

I have to ask, are you ok with the pending dts relicensing to a gpl2/x11 dual 
license [0]?

Otherwise this looks fine and the act8846 is the power-controller of the 
radxarock in any case, so I'll take this one in any case.


Heiko

[0] http://lists.infradead.org/pipermail/linux-rockchip/2015-March/002644.html


> ---
>  arch/arm/boot/dts/rk3188-radxarock.dts | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/boot/dts/rk3188-radxarock.dts
> b/arch/arm/boot/dts/rk3188-radxarock.dts index bdf8570..225a0eb 100644
> --- a/arch/arm/boot/dts/rk3188-radxarock.dts
> +++ b/arch/arm/boot/dts/rk3188-radxarock.dts
> @@ -152,6 +152,7 @@
>  		compatible = "active-semi,act8846";
>  		reg = <0x5a>;
>  		status = "okay";
> +		system-power-controller;
> 
>  		pinctrl-names = "default";
>  		pinctrl-0 = <&act8846_dvs0_ctl>;
