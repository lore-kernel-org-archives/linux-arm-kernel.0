From: rogerq@ti.com (Roger Quadros)
Date: Mon, 21 May 2018 15:23:12 -0500
Subject: [PATCH] ARM: DTS: dra7: fix DCAN node addresses
In-Reply-To: <20180521200832.24213-1-khilman@baylibre.com>
References: <20180521200832.24213-1-khilman@baylibre.com>
Message-ID: <cf431fca-0372-bd50-88e7-d478e4aa52da@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 21/05/18 15:08, Kevin Hilman wrote:
> Fix the DT node addresses to match the reg property addresses,
> which were verified to match the TRM:
> http://www.ti.com/lit/pdf/sprui30
> 
> Cc: Roger Quadros <rogerq@ti.com>
> Signed-off-by: Kevin Hilman <khilman@baylibre.com>

Thanks Kevin.

Acked-by: Roger Quadros <rogerq@ti.com>

> ---
>  arch/arm/boot/dts/dra7.dtsi | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
> index f4ddd86f2c77..8b423eacf76b 100644
> --- a/arch/arm/boot/dts/dra7.dtsi
> +++ b/arch/arm/boot/dts/dra7.dtsi
> @@ -1895,7 +1895,7 @@
>  			};
>  		};
>  
> -		dcan1: can at 481cc000 {
> +		dcan1: can at 4ae3c000 {
>  			compatible = "ti,dra7-d_can";
>  			ti,hwmods = "dcan1";
>  			reg = <0x4ae3c000 0x2000>;
> @@ -1905,7 +1905,7 @@
>  			status = "disabled";
>  		};
>  
> -		dcan2: can at 481d0000 {
> +		dcan2: can at 48480000 {
>  			compatible = "ti,dra7-d_can";
>  			ti,hwmods = "dcan2";
>  			reg = <0x48480000 0x2000>;
> 

-- 
cheers,
-roger

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
