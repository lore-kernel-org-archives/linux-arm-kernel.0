From: lauri.hintsala@bluegiga.com (Lauri Hintsala)
Date: Fri, 08 Feb 2013 17:47:41 +0200
Subject: [PATCH 2/3] ARM: dts: imx28-apx4devkit: Enable touchscreen support
In-Reply-To: <1360337803-19858-2-git-send-email-festevam@gmail.com>
References: <1360337803-19858-1-git-send-email-festevam@gmail.com>
 <1360337803-19858-2-git-send-email-festevam@gmail.com>
Message-ID: <51151E1D.3010409@bluegiga.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/08/2013 05:36 PM, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
>
> Provide 'lradc-touchscreen-wires' property to the LRADC driver, so that
> touchscreen can be functional.
>
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>

Acked-by: Lauri Hintsala <lauri.hintsala@bluegiga.com>

Best regards,
Lauri Hintsala


> ---
>   arch/arm/boot/dts/imx28-apx4devkit.dts |    5 +++++
>   1 file changed, 5 insertions(+)
>
> diff --git a/arch/arm/boot/dts/imx28-apx4devkit.dts b/arch/arm/boot/dts/imx28-apx4devkit.dts
> index 5171667..bb615d5 100644
> --- a/arch/arm/boot/dts/imx28-apx4devkit.dts
> +++ b/arch/arm/boot/dts/imx28-apx4devkit.dts
> @@ -131,6 +131,11 @@
>   				};
>   			};
>
> +			lradc at 80050000 {
> +				fsl,lradc-touchscreen-wires = <4>;
> +				status = "okay";
> +			};
> +
>   			duart: serial at 80074000 {
>   				pinctrl-names = "default";
>   				pinctrl-0 = <&duart_pins_a>;
>
