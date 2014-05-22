From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Thu, 22 May 2014 16:46:46 +0400
Subject: [PATCH] ARM: socfpga: dts: add watchdog0+1
In-Reply-To: <1400753977-11620-1-git-send-email-s.trumtrar@pengutronix.de>
References: <1400753977-11620-1-git-send-email-s.trumtrar@pengutronix.de>
Message-ID: <537DF1B6.5020807@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 22-05-2014 14:19, Steffen Trumtrar wrote:

> The SoCFPGA has two watchdog timers. Add them to the dtsi.

> Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
> ---
>   arch/arm/boot/dts/socfpga.dtsi | 16 ++++++++++++++++
>   1 file changed, 16 insertions(+)

> diff --git a/arch/arm/boot/dts/socfpga.dtsi b/arch/arm/boot/dts/socfpga.dtsi
> index 56fc214..ee10fa6 100644
> --- a/arch/arm/boot/dts/socfpga.dtsi
> +++ b/arch/arm/boot/dts/socfpga.dtsi
> @@ -549,6 +549,22 @@
>   			reg = <0xffd05000 0x1000>;
>   		};
>
> +		watchdog0: wd at ffd02000 {

    The node name should be "watchdog", according to section 2.2.2 of the 
ePPAR standard [1].


> +		watchdog1: wd at ffd04000 {

    Same here.

[1] http://www.power.org/resources/downloads/Power_ePAPR_APPROVED_v1.0.pdf

WBR, Sergei
