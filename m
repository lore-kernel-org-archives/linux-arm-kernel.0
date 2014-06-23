From: tharvey@gateworks.com (Tim Harvey)
Date: Mon, 23 Jun 2014 13:23:16 -0700
Subject: [PATCH 1/7] ARM: dts: imx6: ventana, Remove unused ssi2
In-Reply-To: <1402995995-15098-2-git-send-email-mpa@pengutronix.de>
References: <1402995995-15098-1-git-send-email-mpa@pengutronix.de>
 <1402995995-15098-2-git-send-email-mpa@pengutronix.de>
Message-ID: <CAJ+vNU26L=Ypk91wjuipR0SWrq0t-PHZiKp1iz+AUSTay6a8Mg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 17, 2014 at 2:06 AM, Markus Pargmann <mpa@pengutronix.de> wrote:
> ssi2 is not connected to any sound card so it is unused.
>
> Cc: Tim Harvey <tharvey@gateworks.com>
> Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
> ---
>  arch/arm/boot/dts/imx6qdl-gw54xx.dtsi | 5 -----
>  1 file changed, 5 deletions(-)
>
> diff --git a/arch/arm/boot/dts/imx6qdl-gw54xx.dtsi b/arch/arm/boot/dts/imx6qdl-gw54xx.dtsi
> index 698d3063b295..3245ae85f12b 100644
> --- a/arch/arm/boot/dts/imx6qdl-gw54xx.dtsi
> +++ b/arch/arm/boot/dts/imx6qdl-gw54xx.dtsi
> @@ -559,11 +559,6 @@
>         status = "okay";
>  };
>
> -&ssi2 {
> -       fsl,mode = "i2s-slave";
> -       status = "okay";
> -};
> -
>  &uart1 {
>         pinctrl-names = "default";
>         pinctrl-0 = <&pinctrl_uart1>;
> --
> 2.0.0
>

Acked-by: Tim Harvey <tharvey@gateworks.com>

Tim
