From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Wed, 17 May 2017 11:01:00 +0200
Subject: [PATCH 1/3] arm: dts: rk322x: fix i2s1 pinctrl error
In-Reply-To: <1494992451-32542-2-git-send-email-frank.wang@rock-chips.com>
References: <1494992451-32542-1-git-send-email-frank.wang@rock-chips.com>
 <1494992451-32542-2-git-send-email-frank.wang@rock-chips.com>
Message-ID: <2781249.GNsgFIKA50@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Frank,

Am Mittwoch, 17. Mai 2017, 11:40:49 CEST schrieb Frank Wang:
> From: Sugar Zhang <sugar.zhang@rock-chips.com>
> 
> Refer to Chapter 5.3.2 of rk3229 TRM, we can see that GPIO1A[2,4,5]
> using RK_FUNC_2 not RK_FUNC_1. This patch fixes it.
> 
> Signed-off-by: Frank Wang <frank.wang@rock-chips.com>

if the patch has another author, you should preserve his/her Signed-off-by
line, so for example this patch would look like:

Signed-off-by: Sugar Zhang <sugar.zhang@rock-chips.com>
Signed-off-by: Frank Wang <frank.wang@rock-chips.com>

Same for all other patches with differing authors in your 2 series from
today. As this touches the developer-certificate-of-origin, this is also
something I cannot really correct myself.


Heiko


> ---
>  arch/arm/boot/dts/rk322x.dtsi | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/rk322x.dtsi b/arch/arm/boot/dts/rk322x.dtsi
> index 48a0c1c..cc6a27d 100644
> --- a/arch/arm/boot/dts/rk322x.dtsi
> +++ b/arch/arm/boot/dts/rk322x.dtsi
> @@ -621,9 +621,9 @@
>  						<0 12 RK_FUNC_1 &pcfg_pull_none>,
>  						<0 13 RK_FUNC_1 &pcfg_pull_none>,
>  						<0 14 RK_FUNC_1 &pcfg_pull_none>,
> -						<1 2 RK_FUNC_1 &pcfg_pull_none>,
> -						<1 4 RK_FUNC_1 &pcfg_pull_none>,
> -						<1 5 RK_FUNC_1 &pcfg_pull_none>;
> +						<1 2 RK_FUNC_2 &pcfg_pull_none>,
> +						<1 4 RK_FUNC_2 &pcfg_pull_none>,
> +						<1 5 RK_FUNC_2 &pcfg_pull_none>;
>  			};
>  		};
