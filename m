From: festevam@gmail.com (Fabio Estevam)
Date: Wed, 9 Jan 2013 15:24:38 -0200
Subject: [RFC PATCH 5/5] ARM i.MX5: Add system reset controller (SRC) to
 i.MX51 and i.MX53 device tree
In-Reply-To: <1357751839-19680-6-git-send-email-p.zabel@pengutronix.de>
References: <1357751839-19680-1-git-send-email-p.zabel@pengutronix.de>
 <1357751839-19680-6-git-send-email-p.zabel@pengutronix.de>
Message-ID: <CAOMZO5AeC13LO+o91H5MW9E_zfxJPghtxs-q_ne-ZRH2bK=vFQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 9, 2013 at 3:17 PM, Philipp Zabel <p.zabel@pengutronix.de> wrote:

> diff --git a/arch/arm/boot/dts/imx53.dtsi b/arch/arm/boot/dts/imx53.dtsi
> index edc3f1e..7266942 100644
> --- a/arch/arm/boot/dts/imx53.dtsi
> +++ b/arch/arm/boot/dts/imx53.dtsi
> @@ -72,6 +72,9 @@
>                         compatible = "fsl,imx53-ipu";
>                         reg = <0x18000000 0x080000000>;
>                         interrupts = <11 10>;
> +                       clocks = <&clks 59>, <&clks 110>, <&clks 61>;
> +                       clock-names = "bus", "di0", "di1";

This seems to be an unrelated change.
