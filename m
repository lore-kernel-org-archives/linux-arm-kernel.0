From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Thu, 08 Jun 2017 19:08:30 +0200
Subject: [PATCH v2 6/7] arm64: dts: marvell: remove clock-output-names on
 ap806
In-Reply-To: <4626d359351df74e4e327a2235ecf6ed2a7b11e8.1496239589.git-series.gregory.clement@free-electrons.com>
 (Gregory CLEMENT's message of "Wed, 31 May 2017 16:07:27 +0200")
References: <cover.21754b3184e2122d1c83a664477ed26ec562b3e9.1496239589.git-series.gregory.clement@free-electrons.com>
 <cover.21754b3184e2122d1c83a664477ed26ec562b3e9.1496239589.git-series.gregory.clement@free-electrons.com>
 <4626d359351df74e4e327a2235ecf6ed2a7b11e8.1496239589.git-series.gregory.clement@free-electrons.com>
Message-ID: <87poeepfu9.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,
 
 On mer., mai 31 2017, Gregory CLEMENT <gregory.clement@free-electrons.com> wrote:

> The clock-output-names of the ap806-system-controller node are not used
> anymore, so remove them.
>
> Reviewed-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>

Applied on mvebu/dt64

Gregory

> ---
>  arch/arm64/boot/dts/marvell/armada-ap806.dtsi | 4 ----
>  1 file changed, 4 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/marvell/armada-ap806.dtsi b/arch/arm64/boot/dts/marvell/armada-ap806.dtsi
> index fe41bf9c301e..0c25ec62a2a3 100644
> --- a/arch/arm64/boot/dts/marvell/armada-ap806.dtsi
> +++ b/arch/arm64/boot/dts/marvell/armada-ap806.dtsi
> @@ -244,10 +244,6 @@
>  				compatible = "marvell,ap806-system-controller",
>  					     "syscon";
>  				#clock-cells = <1>;
> -				clock-output-names = "ap-cpu-cluster-0",
> -						     "ap-cpu-cluster-1",
> -						     "ap-fixed", "ap-mss",
> -						     "ap-emmc";
>  				reg = <0x6f4000 0x1000>;
>  			};
>  		};
> -- 
> git-series 0.9.1
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
