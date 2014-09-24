From: soren.brinkmann@xilinx.com (=?utf-8?B?U8O2cmVu?= Brinkmann)
Date: Wed, 24 Sep 2014 09:19:57 -0700
Subject: [PATCH 2/2] ARM: zynq: DT: Add missing reference for
 memory-controller
In-Reply-To: <ca95da888c9cd61e5b5e437b0e1b5cea893455ae.1411567289.git.michal.simek@xilinx.com>
References: <fced9e56dc4ef8df9ead34f6444c010cc31c7a61.1411567289.git.michal.simek@xilinx.com>
 <ca95da888c9cd61e5b5e437b0e1b5cea893455ae.1411567289.git.michal.simek@xilinx.com>
Message-ID: <a8d11082-8806-4a24-b904-0718ff0b0896@BN1BFFO11FD020.protection.gbl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2014-09-24 at 04:01PM +0200, Michal Simek wrote:
> Add missing reference for memory-controller.
> 
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> ---
> 
>  arch/arm/boot/dts/zynq-7000.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/zynq-7000.dtsi b/arch/arm/boot/dts/zynq-7000.dtsi
> index fc90f47f9c03..2690e6d01f71 100644
> --- a/arch/arm/boot/dts/zynq-7000.dtsi
> +++ b/arch/arm/boot/dts/zynq-7000.dtsi
> @@ -145,7 +145,7 @@
>  			cache-level = <2>;
>  		};
> 
> -		memory-controller at f8006000 {
> +		mc: memory-controller at f8006000 {
same here. 'mc0', there are definitely options to add more memory
controllers to Zynq in the PL. Also, I'd spell it out instead of
abbreviating the name.

	S?ren
