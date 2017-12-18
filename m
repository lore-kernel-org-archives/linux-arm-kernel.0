From: clg@kaod.org (=?UTF-8?Q?C=c3=a9dric_Le_Goater?=)
Date: Mon, 18 Dec 2017 10:00:13 +0100
Subject: [PATCH] ARM: dts: aspeed-g4: Correct VUART IRQ number
In-Reply-To: <20171215053332.31690-1-joel@jms.id.au>
References: <20171215053332.31690-1-joel@jms.id.au>
Message-ID: <6c68ec45-a0d8-f601-08e3-c21db0b8f925@kaod.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/15/2017 06:33 AM, Joel Stanley wrote:
> This should have always been 8.
> 
> Fixes: db4d6d9d80fa ("ARM: dts: aspeed: Correctly order UART nodes")
> Cc: stable at vger.kernel.org
> Signed-off-by: Joel Stanley <joel@jms.id.au>

Reviewed-by: C?dric Le Goater <clg@kaod.org>

> ---
> ARM maintainers, please include this fix for 4.15
> 
>  arch/arm/boot/dts/aspeed-g4.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/aspeed-g4.dtsi b/arch/arm/boot/dts/aspeed-g4.dtsi
> index 45d815a86d42..de08d9045cb8 100644
> --- a/arch/arm/boot/dts/aspeed-g4.dtsi
> +++ b/arch/arm/boot/dts/aspeed-g4.dtsi
> @@ -219,7 +219,7 @@
>  				compatible = "aspeed,ast2400-vuart";
>  				reg = <0x1e787000 0x40>;
>  				reg-shift = <2>;
> -				interrupts = <10>;
> +				interrupts = <8>;
>  				clocks = <&clk_uart>;
>  				no-loopback-test;
>  				status = "disabled";
> 
