From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Mon, 23 Feb 2015 15:55:37 +0100
Subject: [PATCH 5/8] ARM: dts: dove: Add node labels for PCIe ports 0 and 1
In-Reply-To: <1424199129-22099-6-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1424199129-22099-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1424199129-22099-6-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <54EB3F69.9060208@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sebastian,


On 17/02/2015 19:52, Sebastian Hesselbarth wrote:
> Add pcie[01] node labels to allow to reference them easily from
> board level.
> 
> Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>

Acked-by: Gregory CLEMENT <gregory.clement@free-electrons.com>


Thanks,

Gregory

> ---
> Cc: Jason Cooper <jason@lakedaemon.net>
> Cc: Andrew Lunn <andrew@lunn.ch>
> Cc: Gregory Clement <gregory.clement@free-electrons.com>
> Cc: Gabriel Dobato <dobatog@gmail.com>
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: linux-kernel at vger.kernel.org
> ---
>  arch/arm/boot/dts/dove.dtsi | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/dove.dtsi b/arch/arm/boot/dts/dove.dtsi
> index cae865435762..81209bd9525a 100644
> --- a/arch/arm/boot/dts/dove.dtsi
> +++ b/arch/arm/boot/dts/dove.dtsi
> @@ -64,7 +64,7 @@
>  				  0x82000000 0x2 0x0 MBUS_ID(0x08, 0xe8) 0 1 0   /* Port 1.0 Mem */
>  				  0x81000000 0x2 0x0 MBUS_ID(0x08, 0xe0) 0 1 0>; /* Port 1.0 I/O */
>  
> -			pcie-port at 0 {
> +			pcie0: pcie-port at 0 {
>  				device_type = "pci";
>  				status = "disabled";
>  				assigned-addresses = <0x82000800 0 0x40000 0 0x2000>;
> @@ -82,7 +82,7 @@
>  				interrupt-map = <0 0 0 0 &intc 16>;
>  			};
>  
> -			pcie-port at 1 {
> +			pcie1: pcie-port at 1 {
>  				device_type = "pci";
>  				status = "disabled";
>  				assigned-addresses = <0x82002800 0 0x80000 0 0x2000>;
> 


-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
