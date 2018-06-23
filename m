From: festevam@gmail.com (Fabio Estevam)
Date: Sat, 23 Jun 2018 13:00:17 -0300
Subject: [PATCH 1/1] ARM: dts: imx53: PPD: Add fixed-regulator information
In-Reply-To: <20180622145225.17883-1-sebastian.reichel@collabora.co.uk>
References: <20180622145225.17883-1-sebastian.reichel@collabora.co.uk>
Message-ID: <CAOMZO5Bdh9d6nrX80xpkmFdFydfmazSkU+bwzNGFQFGz8dPAPA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sebastian,

On Fri, Jun 22, 2018 at 11:52 AM, Sebastian Reichel
<sebastian.reichel@collabora.co.uk> wrote:

> -       usbphy2: usbphy2 {
> +       usbphy2: usbphy-2 {

This node rename seems to be an unrelated change.

>                 compatible = "usb-nop-xceiv";
> +               vcc-supply = <&reg_3v3>;
>                 reset-gpios = <&gpio4 4 GPIO_ACTIVE_LOW>;
>                 clock-names = "main_clk";
>                 clock-frequency = <24000000>;
> @@ -208,8 +230,9 @@
>                 assigned-clock-parents = <&clks IMX5_CLK_OSC>;
>         };
>
> -       usbphy3: usbphy3 {
> +       usbphy3: usbphy-3 {

Ditto.
