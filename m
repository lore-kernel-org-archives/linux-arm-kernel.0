From: LW@KARO-electronics.de (Lothar =?UTF-8?B?V2HDn21hbm4=?=)
Date: Mon, 15 Sep 2014 09:31:16 +0200
Subject: [Patch v4 net-next 12/12] ARM: dts: imx6sx: add multi-queue
 support enet
In-Reply-To: <1410555657-10744-13-git-send-email-Frank.Li@freescale.com>
References: <1410555657-10744-1-git-send-email-Frank.Li@freescale.com>
 <1410555657-10744-13-git-send-email-Frank.Li@freescale.com>
Message-ID: <20140915093116.3a9b7cb0@ipc1.ka-ro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Frank.Li at freescale.com wrote:
> From: Frank Li <Frank.Li@freescale.com>
> 
> Enable 3 queues suppport for ethernet
> 
> Signed-off-by: Frank Li <Frank.Li@freescale.com>
> ---
>  arch/arm/boot/dts/imx6sx.dtsi | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/imx6sx.dtsi b/arch/arm/boot/dts/imx6sx.dtsi
> index f4b9da6..0a03260 100644
> --- a/arch/arm/boot/dts/imx6sx.dtsi
> +++ b/arch/arm/boot/dts/imx6sx.dtsi
> @@ -776,6 +776,8 @@
>  					 <&clks IMX6SX_CLK_ENET_PTP>;
>  				clock-names = "ipg", "ahb", "ptp",
>  					      "enet_clk_ref", "enet_out";
> +				fsl,num-tx-queues=<3>;
> +				fsl,num-rx-queues=<3>;
missing spaces around '='


Lothar Wa?mann
-- 
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra?e 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch?ftsf?hrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info at karo-electronics.de
___________________________________________________________
