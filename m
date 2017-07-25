From: mdf@kernel.org (Moritz Fischer)
Date: Tue, 25 Jul 2017 09:47:22 -0700
Subject: [PATCH 01/10] arm64: zynqmp: Add references to cpu nodes
In-Reply-To: <b9a61dfe7f5d4309b3131c1b9a82890888838087.1500552941.git.michal.simek@xilinx.com>
References: <cover.1500552941.git.michal.simek@xilinx.com>
 <b9a61dfe7f5d4309b3131c1b9a82890888838087.1500552941.git.michal.simek@xilinx.com>
Message-ID: <20170725164722.GA30669@tyrael.ni.corp.natinst.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 20, 2017 at 02:17:00PM +0200, Michal Simek wrote:
> Add missing references to all cpu nodes.
> 
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
Reviewed-by: Moritz Fischer <mdf@kernel.org>
> ---
> 
>  arch/arm64/boot/dts/xilinx/zynqmp.dtsi | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
> index 1a3f5e928bb9..4f7d9905e235 100644
> --- a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
> +++ b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
> @@ -20,28 +20,28 @@
>  		#address-cells = <1>;
>  		#size-cells = <0>;
>  
> -		cpu at 0 {
> +		cpu0: cpu at 0 {
>  			compatible = "arm,cortex-a53", "arm,armv8";
>  			device_type = "cpu";
>  			enable-method = "psci";
>  			reg = <0x0>;
>  		};
>  
> -		cpu at 1 {
> +		cpu1: cpu at 1 {
>  			compatible = "arm,cortex-a53", "arm,armv8";
>  			device_type = "cpu";
>  			enable-method = "psci";
>  			reg = <0x1>;
>  		};
>  
> -		cpu at 2 {
> +		cpu2: cpu at 2 {
>  			compatible = "arm,cortex-a53", "arm,armv8";
>  			device_type = "cpu";
>  			enable-method = "psci";
>  			reg = <0x2>;
>  		};
>  
> -		cpu at 3 {
> +		cpu3: cpu at 3 {
>  			compatible = "arm,cortex-a53", "arm,armv8";
>  			device_type = "cpu";
>  			enable-method = "psci";
> -- 
> 1.9.1
> 
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 455 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170725/16e6bc08/attachment.sig>
