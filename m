From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Mon, 23 Feb 2015 16:16:39 +0100
Subject: [PATCHv2 03/15] ARM: mvebu: add missing UART alias on Armada 38x
In-Reply-To: <1424451874-25375-4-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1424451874-25375-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1424451874-25375-4-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <54EB4457.50208@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thomas,

On 20/02/2015 18:04, Thomas Petazzoni wrote:
> The Armada 38x had an alias for UART0, but not UART1. This commit
> fixes that.
> 
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

Acked-by: Gregory CLEMENT <gregory.clement@free-electrons.com>


Thanks,

Gregory

> ---
>  arch/arm/boot/dts/armada-38x.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/armada-38x.dtsi b/arch/arm/boot/dts/armada-38x.dtsi
> index 96d7cf0..8c76a8d 100644
> --- a/arch/arm/boot/dts/armada-38x.dtsi
> +++ b/arch/arm/boot/dts/armada-38x.dtsi
> @@ -216,7 +216,7 @@
>  				status = "disabled";
>  			};
>  
> -			serial at 12100 {
> +			uart1: serial at 12100 {
>  				compatible = "snps,dw-apb-uart";
>  				reg = <0x12100 0x100>;
>  				reg-shift = <2>;
> 


-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
