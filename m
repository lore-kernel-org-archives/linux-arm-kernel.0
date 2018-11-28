From: aisheng.dong@nxp.com (Aisheng DONG)
Date: Wed, 28 Nov 2018 15:46:24 +0000
Subject: [PATCH V3 4/4] ARM64: dts: imx: add i.MX8QXP system controller
 RTC support
In-Reply-To: <1543398696-3140-5-git-send-email-Anson.Huang@nxp.com>
References: <1543398696-3140-1-git-send-email-Anson.Huang@nxp.com>
 <1543398696-3140-5-git-send-email-Anson.Huang@nxp.com>
Message-ID: <AM0PR04MB42115A31CAE5A72D047BE7B880D10@AM0PR04MB4211.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[...]
> Subject: [PATCH V3 4/4] ARM64: dts: imx: add i.MX8QXP system controller RTC
> support
> 
> Add i.MX8QXP system controller RTC support.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
>  arch/arm64/boot/dts/freescale/imx8qxp.dtsi | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
> b/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
> index da99b6f..5e8b554 100644
> --- a/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
> @@ -406,4 +406,8 @@
>  		#size-cells = <1>;
>  		ranges = <0x5f000000 0x0 0x5f000000 0x1000000>;
>  	};
> +
> +	rtc: rtc {
> +		compatible = "nxp,imx8qxp-sc-rtc";

As I replied in patch 1, this belongs to scu node as well.

Regards
Dong Aisheng

> +	};
>  };
> --
> 2.7.4
