From: michal.simek@xilinx.com (Michal Simek)
Date: Wed, 18 Jul 2018 09:38:56 +0200
Subject: [PATCH] arm: dts: zynq: Fix memory size on the Zybo Z7 board
In-Reply-To: <20180626232025.14003-1-luaraneda@gmail.com>
References: <20180626232025.14003-1-luaraneda@gmail.com>
Message-ID: <2a551619-63ad-253b-33ae-e3d538aeed9a@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 27.6.2018 01:20, Luis Araneda wrote:
> According to the reference manual, the board has two Micron
> MT41K256M16HA-125 DDR3L memory ICs, which have 512 MiB each
> 
> Tested on a ZYBO-Z7-20 board
> 
> Signed-off-by: Luis Araneda <luaraneda@gmail.com>
> ---
>  arch/arm/boot/dts/zynq-zybo-z7.dts | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/zynq-zybo-z7.dts b/arch/arm/boot/dts/zynq-zybo-z7.dts
> index 1e713dc98..bc81ebee5 100644
> --- a/arch/arm/boot/dts/zynq-zybo-z7.dts
> +++ b/arch/arm/boot/dts/zynq-zybo-z7.dts
> @@ -13,7 +13,7 @@
>  
>  	memory at 0 {
>  		device_type = "memory";
> -		reg = <0x0 0x20000000>;
> +		reg = <0x0 0x40000000>;
>  	};
>  
>  	chosen {
> 

This was already applied through different series.

Thanks,
Michal
