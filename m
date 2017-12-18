From: clg@kaod.org (=?UTF-8?Q?C=c3=a9dric_Le_Goater?=)
Date: Mon, 18 Dec 2017 10:03:01 +0100
Subject: [PATCH v2 07/19] ARM: dts: aspeed: Add flash controller clocks
In-Reply-To: <20171215062443.23059-8-joel@jms.id.au>
References: <20171215062443.23059-1-joel@jms.id.au>
 <20171215062443.23059-8-joel@jms.id.au>
Message-ID: <36771f62-35d0-94c9-a0ac-cfaf35e6ff4f@kaod.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/15/2017 07:24 AM, Joel Stanley wrote:
> Signed-off-by: Joel Stanley <joel@jms.id.au>


Reviewed-by: C?dric Le Goater <clg@kaod.org>


> ---
>  arch/arm/boot/dts/aspeed-g4.dtsi | 2 ++
>  arch/arm/boot/dts/aspeed-g5.dtsi | 3 +++
>  2 files changed, 5 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/aspeed-g4.dtsi b/arch/arm/boot/dts/aspeed-g4.dtsi
> index 2e3666d4fbeb..afac0ca0cb10 100644
> --- a/arch/arm/boot/dts/aspeed-g4.dtsi
> +++ b/arch/arm/boot/dts/aspeed-g4.dtsi
> @@ -56,6 +56,7 @@
>  			#address-cells = <1>;
>  			#size-cells = <0>;
>  			compatible = "aspeed,ast2400-fmc";
> +			clocks = <&syscon ASPEED_CLK_AHB>;
>  			status = "disabled";
>  			interrupts = <19>;
>  			flash at 0 {
> @@ -71,6 +72,7 @@
>  			#address-cells = <1>;
>  			#size-cells = <0>;
>  			compatible = "aspeed,ast2400-spi";
> +			clocks = <&syscon ASPEED_CLK_AHB>;
>  			status = "disabled";
>  			flash at 0 {
>  				reg = < 0 >;
> diff --git a/arch/arm/boot/dts/aspeed-g5.dtsi b/arch/arm/boot/dts/aspeed-g5.dtsi
> index 24bb2d16b900..f3689caf6fe2 100644
> --- a/arch/arm/boot/dts/aspeed-g5.dtsi
> +++ b/arch/arm/boot/dts/aspeed-g5.dtsi
> @@ -56,6 +56,7 @@
>  			#address-cells = <1>;
>  			#size-cells = <0>;
>  			compatible = "aspeed,ast2500-fmc";
> +			clocks = <&syscon ASPEED_CLK_AHB>;
>  			status = "disabled";
>  			interrupts = <19>;
>  			flash at 0 {
> @@ -81,6 +82,7 @@
>  			#address-cells = <1>;
>  			#size-cells = <0>;
>  			compatible = "aspeed,ast2500-spi";
> +			clocks = <&syscon ASPEED_CLK_AHB>;
>  			status = "disabled";
>  			flash at 0 {
>  				reg = < 0 >;
> @@ -100,6 +102,7 @@
>  			#address-cells = <1>;
>  			#size-cells = <0>;
>  			compatible = "aspeed,ast2500-spi";
> +			clocks = <&syscon ASPEED_CLK_AHB>;
>  			status = "disabled";
>  			flash at 0 {
>  				reg = < 0 >;
> 
