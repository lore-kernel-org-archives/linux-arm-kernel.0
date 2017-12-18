From: clg@kaod.org (=?UTF-8?Q?C=c3=a9dric_Le_Goater?=)
Date: Mon, 18 Dec 2017 10:02:55 +0100
Subject: [PATCH v2 06/19] ARM: dts: aspeed: Add watchdog clocks
In-Reply-To: <20171215062443.23059-7-joel@jms.id.au>
References: <20171215062443.23059-1-joel@jms.id.au>
 <20171215062443.23059-7-joel@jms.id.au>
Message-ID: <a4018717-0ffa-e7cc-1a8d-e6937ac0a57c@kaod.org>
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
> index cf407b4db630..2e3666d4fbeb 100644
> --- a/arch/arm/boot/dts/aspeed-g4.dtsi
> +++ b/arch/arm/boot/dts/aspeed-g4.dtsi
> @@ -177,11 +177,13 @@
>  			wdt1: watchdog at 1e785000 {
>  				compatible = "aspeed,ast2400-wdt";
>  				reg = <0x1e785000 0x1c>;
> +				clocks = <&syscon ASPEED_CLK_APB>;
>  			};
>  
>  			wdt2: watchdog at 1e785020 {
>  				compatible = "aspeed,ast2400-wdt";
>  				reg = <0x1e785020 0x1c>;
> +				clocks = <&syscon ASPEED_CLK_APB>;
>  			};
>  
>  			vuart: serial at 1e787000 {
> diff --git a/arch/arm/boot/dts/aspeed-g5.dtsi b/arch/arm/boot/dts/aspeed-g5.dtsi
> index ab26156d6822..24bb2d16b900 100644
> --- a/arch/arm/boot/dts/aspeed-g5.dtsi
> +++ b/arch/arm/boot/dts/aspeed-g5.dtsi
> @@ -219,16 +219,19 @@
>  			wdt1: watchdog at 1e785000 {
>  				compatible = "aspeed,ast2500-wdt";
>  				reg = <0x1e785000 0x20>;
> +				clocks = <&syscon ASPEED_CLK_APB>;
>  			};
>  
>  			wdt2: watchdog at 1e785020 {
>  				compatible = "aspeed,ast2500-wdt";
>  				reg = <0x1e785020 0x20>;
> +				clocks = <&syscon ASPEED_CLK_APB>;
>  			};
>  
>  			wdt3: watchdog at 1e785040 {
>  				compatible = "aspeed,ast2500-wdt";
>  				reg = <0x1e785040 0x20>;
> +				clocks = <&syscon ASPEED_CLK_APB>;
>  				status = "disabled";
>  			};
>  
> 
