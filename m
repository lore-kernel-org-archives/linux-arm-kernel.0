From: yangbo.lu@nxp.com (Y.B. Lu)
Date: Wed, 31 May 2017 10:16:03 +0000
Subject: [PATCH] arm64: dts: ls208xa: disable SD UHS-I modes by default on
 RDB
In-Reply-To: <VI1PR04MB12626B25EFC90F99044DE9B2E9F10@VI1PR04MB1262.eurprd04.prod.outlook.com>
References: <1496223167-33840-1-git-send-email-yinbo.zhu@nxp.com>
 <VI1PR04MB12626B25EFC90F99044DE9B2E9F10@VI1PR04MB1262.eurprd04.prod.outlook.com>
Message-ID: <DB6PR0401MB2536A3C354A9E3903790286EF8F10@DB6PR0401MB2536.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> -----Original Message-----
> From: Yinbo Zhu
> Sent: Wednesday, May 31, 2017 6:12 PM
> To: Y.B. Lu
> Subject: FW: [PATCH] arm64: dts: ls208xa: disable SD UHS-I modes by
> default on RDB
> 
> 
> 
> -----Original Message-----
> From: yinbo.zhu [mailto:yinbo.zhu at nxp.com]
> Sent: 2017?5?31? PM 5:33
> To: linux-arm-kernel at lists.infradead.org
> Cc: Yinbo Zhu <yinbo.zhu@nxp.com>
> Subject: [PATCH] arm64: dts: ls208xa: disable SD UHS-I modes by default
> on RDB
> 
> Currently SD UHS-I modes were enabled by default on LS208xARDB boards,
> but the new LS2088ARDB RevF board didn't support them any more since SDHC
> circuit had been reworked. This patch is to disable SD UHS-I modes by
> default in case of any issue on LS2088ARDB RevF
> 
> Signed-off-by: yinbo.zhu <yinbo.zhu@nxp.com>

[Lu Yangbo-B47093] It looks good to me.
Acked-by: Yangbo Lu <yangbo.lu@nxp.com>

> ---
>  arch/arm64/boot/dts/freescale/fsl-ls208xa-rdb.dtsi | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls208xa-rdb.dtsi
> b/arch/arm64/boot/dts/freescale/fsl-ls208xa-rdb.dtsi
> index 3a944bb..f06b7f5 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-ls208xa-rdb.dtsi
> +++ b/arch/arm64/boot/dts/freescale/fsl-ls208xa-rdb.dtsi
> @@ -45,10 +45,6 @@
>   */
> 
>  &esdhc {
> -	sd-uhs-sdr104;
> -	sd-uhs-sdr50;
> -	sd-uhs-sdr25;
> -	sd-uhs-sdr12;
>  	status = "okay";
>  };
> 
> --
> 2.1.0.27.g96db324
