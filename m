From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Mon, 23 Feb 2015 15:54:10 +0100
Subject: [PATCH 3/8] ARM: dts: dove: Fix uart[23] reg property
In-Reply-To: <1424199129-22099-4-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1424199129-22099-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1424199129-22099-4-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <54EB3F12.5040207@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sebastian,

On 17/02/2015 19:52, Sebastian Hesselbarth wrote:
> Fix Dove's register addresses of uart2 and uart3 nodes that seem to
> be broken since ages due to a copy-and-paste error.
> 
> Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>

Acked-by: Gregory CLEMENT <gregory.clement@free-electrons.com>


> ---
> Please consider for stable back to v3.7

If nobody complains about it, I will add the Cc tag for
the stable team when applying this patch to the mvebu tree


Thanks,

Gregory

> 
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
> index a5441d5482a6..3cc8b8320345 100644
> --- a/arch/arm/boot/dts/dove.dtsi
> +++ b/arch/arm/boot/dts/dove.dtsi
> @@ -154,7 +154,7 @@
>  
>  			uart2: serial at 12200 {
>  				compatible = "ns16550a";
> -				reg = <0x12000 0x100>;
> +				reg = <0x12200 0x100>;
>  				reg-shift = <2>;
>  				interrupts = <9>;
>  				clocks = <&core_clk 0>;
> @@ -163,7 +163,7 @@
>  
>  			uart3: serial at 12300 {
>  				compatible = "ns16550a";
> -				reg = <0x12100 0x100>;
> +				reg = <0x12300 0x100>;
>  				reg-shift = <2>;
>  				interrupts = <10>;
>  				clocks = <&core_clk 0>;
> 


-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
