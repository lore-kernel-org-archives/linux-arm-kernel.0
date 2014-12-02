From: dinguyen@opensource.altera.com (Dinh Nguyen)
Date: Tue, 2 Dec 2014 10:46:41 -0600
Subject: [PATCH v3 3/3] ARM: dts: socfpga: Add l3nic node
In-Reply-To: <1417292052-12974-4-git-send-email-s.trumtrar@pengutronix.de>
References: <1417292052-12974-1-git-send-email-s.trumtrar@pengutronix.de>
 <1417292052-12974-4-git-send-email-s.trumtrar@pengutronix.de>
Message-ID: <547DECF1.5040409@opensource.altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

+CC: Alan Tull

On 11/29/2014 02:14 PM, Steffen Trumtrar wrote:
> Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
> ---
>  arch/arm/boot/dts/socfpga.dtsi | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/socfpga.dtsi b/arch/arm/boot/dts/socfpga.dtsi
> index 4472fd92685c..e47b69c9f6cd 100644
> --- a/arch/arm/boot/dts/socfpga.dtsi
> +++ b/arch/arm/boot/dts/socfpga.dtsi
> @@ -628,6 +628,11 @@
>  			arm,data-latency = <2 1 1>;
>  		};
>  
> +		l3regs: gpv at ff800000 {
> +			compatible = "altr,l3-nic";
> +			reg = <0xff800000 0x100000>;
> +		};
> +
>  		mmc: dwmmc0 at ff704000 {
>  			compatible = "altr,socfpga-dw-mshc";
>  			reg = <0xff704000 0x1000>;
> 
