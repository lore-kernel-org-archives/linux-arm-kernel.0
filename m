From: soren.brinkmann@xilinx.com (=?utf-8?B?U8O2cmVu?= Brinkmann)
Date: Wed, 24 Sep 2014 09:18:14 -0700
Subject: [PATCH 1/2] ARM: zynq: DT: Add missing reference for ADC
In-Reply-To: <fced9e56dc4ef8df9ead34f6444c010cc31c7a61.1411567289.git.michal.simek@xilinx.com>
References: <fced9e56dc4ef8df9ead34f6444c010cc31c7a61.1411567289.git.michal.simek@xilinx.com>
Message-ID: <68d34c42-b0e0-4e8f-8b92-0bc8fd233d52@BN1AFFO11FD056.protection.gbl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2014-09-24 at 04:01PM +0200, Michal Simek wrote:
> Add missing reference for ADC node.
> 
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> ---
> 
>  arch/arm/boot/dts/zynq-7000.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/zynq-7000.dtsi b/arch/arm/boot/dts/zynq-7000.dtsi
> index 772381fe07bb..fc90f47f9c03 100644
> --- a/arch/arm/boot/dts/zynq-7000.dtsi
> +++ b/arch/arm/boot/dts/zynq-7000.dtsi
> @@ -64,7 +64,7 @@
>  		interrupt-parent = <&intc>;
>  		ranges;
> 
> -		adc at f8007100 {
> +		adc: adc at f8007100 {
I think we enumerated all labels. I.e. 'adc0' is probably better.

	S?ren
