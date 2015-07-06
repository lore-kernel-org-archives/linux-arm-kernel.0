From: hongtao.jia@freescale.com (Hongtao Jia)
Date: Mon, 6 Jul 2015 02:57:16 +0000
Subject: [PATCH] arm: dts: ls1021a: Add LTC2945 node for LS1021A TWR board
In-Reply-To: <1436150292-15046-1-git-send-email-b18965@freescale.com>
References: <1436150292-15046-1-git-send-email-b18965@freescale.com>
Message-ID: <BLUPR03MB1497B76768ED91760804EBCE1930@BLUPR03MB149.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

LTC2945 is replaced by INA220 in rev2.0.

Please note it as "Superseded" in patchworks.
Thanks.

---
Best Regards,
Hongtao

> -----Original Message-----
> From: Alison Wang [mailto:b18965 at freescale.com]
> Sent: Monday, July 06, 2015 10:38 AM
> To: shawn.guo at linaro.org; Jin Zhengxiong-R64188; linux-arm-
> kernel at lists.infradead.org; linux-kernel at vger.kernel.org
> Cc: Jia Hongtao-B38951
> Subject: [PATCH] arm: dts: ls1021a: Add LTC2945 node for LS1021A TWR
> board
> 
> From: Jia Hongtao <hongtao.jia@freescale.com>
> 
> This patch adds LTC2945 node for LS1021A TWR board.
> 
> Signed-off-by: Jia Hongtao <hongtao.jia@freescale.com>
> ---
>  arch/arm/boot/dts/ls1021a-twr.dts | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/ls1021a-twr.dts
> b/arch/arm/boot/dts/ls1021a-twr.dts
> index a0d9ad6..938b16a 100644
> --- a/arch/arm/boot/dts/ls1021a-twr.dts
> +++ b/arch/arm/boot/dts/ls1021a-twr.dts
> @@ -160,6 +160,13 @@
>  	};
>  };
> 
> +&i2c2 {
> +	status = "okay";
> +	monitor: ltc2945 at 67 {
> +		reg = <0x67>;
> +	};
> +};
> +
>  &ifc {
>  	#address-cells = <2>;
>  	#size-cells = <1>;
> --
> 2.1.0.27.g96db324
