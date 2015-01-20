From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 20 Jan 2015 14:29:16 +0800
Subject: [PATCH v2] ARM: dts: imx6q: enable dma for ecspi5
In-Reply-To: <1421172248-15765-1-git-send-email-anton_bondarenko@mentor.com>
References: <315825>
 <1421172248-15765-1-git-send-email-anton_bondarenko@mentor.com>
Message-ID: <20150120062915.GS2766@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 13, 2015 at 07:04:08PM +0100, Anton Bondarenko wrote:
> Enable dma support for ecspi5 controller
> 
> Signed-off-by: Anton Bondarenko <anton_bondarenko@mentor.com>

Applied, thanks.

> ---
>  arch/arm/boot/dts/imx6q.dtsi | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/imx6q.dtsi b/arch/arm/boot/dts/imx6q.dtsi
> index 37ee4e5..93ec79b 100644
> --- a/arch/arm/boot/dts/imx6q.dtsi
> +++ b/arch/arm/boot/dts/imx6q.dtsi
> @@ -95,6 +95,8 @@
>  					clocks = <&clks IMX6Q_CLK_ECSPI5>,
>  						 <&clks IMX6Q_CLK_ECSPI5>;
>  					clock-names = "ipg", "per";
> +					dmas = <&sdma 11 7 1>, <&sdma 12 7 2>;
> +					dma-names = "rx", "tx";
>  					status = "disabled";
>  				};
>  			};
> -- 
> 2.2.1
> 
