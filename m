From: soren.brinkmann@xilinx.com (=?utf-8?B?U8O2cmVu?= Brinkmann)
Date: Thu, 28 Aug 2014 10:15:36 -0700
Subject: [PATCH] ARM: zynq: DT: Add LEDs to zc702 DT
In-Reply-To: <1409242973-2735-1-git-send-email-soren.brinkmann@xilinx.com>
References: <1409242973-2735-1-git-send-email-soren.brinkmann@xilinx.com>
Message-ID: <48d3362c-a688-4245-8258-cd1062f954a1@BN1AFFO11FD035.protection.gbl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2014-08-28 at 09:22AM -0700, Soren Brinkmann wrote:
> From: Ezra Savard <ezra.savard@xilinx.com>
> 
> Adds LEDs to the zc702 devicetree for use with the leds-gpio driver.
> 
> Signed-off-by: Ezra Savard <ezra.savard@xilinx.com>
> Reviewed-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
> ---
>  arch/arm/boot/dts/zynq-zc702.dts | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/zynq-zc702.dts b/arch/arm/boot/dts/zynq-zc702.dts
> index 835c3089c61c..4e9fe26b3e85 100644
> --- a/arch/arm/boot/dts/zynq-zc702.dts
> +++ b/arch/arm/boot/dts/zynq-zc702.dts
> @@ -27,6 +27,16 @@
>  		bootargs = "console=ttyPS0,115200 earlyprintk";
>  	};
>  
> +	gpio-leds {
The node name should rather be just 'leds'. That slipped through, sorry.
Do you want a v2 for that?

	Soren
