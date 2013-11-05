From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 5 Nov 2013 10:41:33 +0800
Subject: [PATCH v3 04/11] ARM: dts: imx6: add anatop phandle for usbphy
In-Reply-To: <1383616183-10511-5-git-send-email-peter.chen@freescale.com>
References: <1383616183-10511-1-git-send-email-peter.chen@freescale.com>
 <1383616183-10511-5-git-send-email-peter.chen@freescale.com>
Message-ID: <20131105024130.GG19770@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 05, 2013 at 09:49:36AM +0800, Peter Chen wrote:
> Add anatop phandle for usbphy
> 
> Signed-off-by: Peter Chen <peter.chen@freescale.com>
> ---
>  arch/arm/boot/dts/imx6qdl.dtsi |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)

Does imx6sl.dtsi need the same update?

Shawn

> 
> diff --git a/arch/arm/boot/dts/imx6qdl.dtsi b/arch/arm/boot/dts/imx6qdl.dtsi
> index 226ce75..bb79678 100644
> --- a/arch/arm/boot/dts/imx6qdl.dtsi
> +++ b/arch/arm/boot/dts/imx6qdl.dtsi
> @@ -559,6 +559,7 @@
>  				reg = <0x020c9000 0x1000>;
>  				interrupts = <0 44 0x04>;
>  				clocks = <&clks 182>;
> +				fsl,anatop = <&anatop>;
>  			};
>  
>  			usbphy2: usbphy at 020ca000 {
> @@ -566,6 +567,7 @@
>  				reg = <0x020ca000 0x1000>;
>  				interrupts = <0 45 0x04>;
>  				clocks = <&clks 183>;
> +				fsl,anatop = <&anatop>;
>  			};
>  
>  			snvs at 020cc000 {
> -- 
> 1.7.1
> 
> 
