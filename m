From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Mon, 13 Jan 2014 10:00:46 +0100
Subject: ARM: mvebu: dt: add missing alias 'eth3' on Armada XP mv78260
In-Reply-To: <20140112120924.GA1916@1wt.eu>
References: <20140112120924.GA1916@1wt.eu>
Message-ID: <52D3AB3E.2000305@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Willy,
On 12/01/2014 13:09, Willy Tarreau wrote:
> It was correctly set on mv78460 but not on mv78260, resulting in my
> OpenBlocks AX3-4 retrieving only 3 of its 4 MAC addresses from the
> boot loader.
> 
> Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> Cc: Gregory CLEMENT <gregory.clement@free-electrons.com>
> Signed-off-by: Willy Tarreau <w@1wt.eu>

Acked-by: Gregory CLEMENT <gregory.clement@free-electrons.com>


Thanks,

Gregory

> ---
>  arch/arm/boot/dts/armada-xp-mv78260.dtsi | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/armada-xp-mv78260.dtsi b/arch/arm/boot/dts/armada-xp-mv78260.dtsi
> index 6660968..9480cf8 100644
> --- a/arch/arm/boot/dts/armada-xp-mv78260.dtsi
> +++ b/arch/arm/boot/dts/armada-xp-mv78260.dtsi
> @@ -23,6 +23,7 @@
>  		gpio0 = &gpio0;
>  		gpio1 = &gpio1;
>  		gpio2 = &gpio2;
> +		eth3 = &eth3;
>  	};
>  
>  	cpus {
> @@ -291,7 +292,7 @@
>  				interrupts = <91>;
>  			};
>  
> -			ethernet at 34000 {
> +			eth3: ethernet at 34000 {
>  				compatible = "marvell,armada-370-neta";
>  				reg = <0x34000 0x4000>;
>  				interrupts = <14>;
> 


-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
