From: monstr@monstr.eu (Michal Simek)
Date: Fri, 02 Aug 2013 13:37:35 +0200
Subject: [PATCH] arm: zynq: dt: Set correct L2 ram latencies
In-Reply-To: <1375313099-8402-1-git-send-email-soren.brinkmann@xilinx.com>
References: <1375313099-8402-1-git-send-email-soren.brinkmann@xilinx.com>
Message-ID: <51FB99FF.9080003@monstr.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/01/2013 01:24 AM, Soren Brinkmann wrote:
> Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
> ---
>  arch/arm/boot/dts/zynq-7000.dtsi | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/zynq-7000.dtsi b/arch/arm/boot/dts/zynq-7000.dtsi
> index 6f54a64..e32b92b 100644
> --- a/arch/arm/boot/dts/zynq-7000.dtsi
> +++ b/arch/arm/boot/dts/zynq-7000.dtsi
> @@ -41,8 +41,8 @@
>  		L2: cache-controller {
>  			compatible = "arm,pl310-cache";
>  			reg = <0xF8F02000 0x1000>;
> -			arm,data-latency = <2 3 2>;
> -			arm,tag-latency = <2 3 2>;
> +			arm,data-latency = <3 2 2>;
> +			arm,tag-latency = <2 2 2>;
>  			cache-unified;
>  			cache-level = <2>;
>  		};
> 

Applied to zynq/dt.

Thanks,
Michal

-- 
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Microblaze cpu - http://www.monstr.eu/fdt/
Maintainer of Linux kernel - Xilinx Zynq ARM architecture
Microblaze U-BOOT custodian and responsible for u-boot arm zynq platform


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 263 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130802/495f5ce3/attachment-0001.sig>
