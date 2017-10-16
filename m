From: festevam@gmail.com (Fabio Estevam)
Date: Mon, 16 Oct 2017 18:33:17 -0200
Subject: [PATCH 6/7] ARM: dts: imx6ul: add support for TXUL modules on
 TXUL-Mainboard
In-Reply-To: <1507891383-15452-7-git-send-email-LW@KARO-electronics.de>
References: <1507891383-15452-1-git-send-email-LW@KARO-electronics.de>
 <1507891383-15452-7-git-send-email-LW@KARO-electronics.de>
Message-ID: <CAOMZO5BbRwnggKPUo=evT=nHxo9k6v3d-zNLaiOPWabDNdLgpA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lothar,

On Fri, Oct 13, 2017 at 7:43 AM, Lothar Wa?mann <LW@karo-electronics.de> wrote:

> +/ {
> +       aliases {
> +               lcdif_24bit_pins_a = &pinctrl_disp0_3;
> +               mmc0 = &usdhc1;

Is this mmc0 alias really needed here?

I see it inside imx6ul.dtsi, but even inside imx6ul.dtsi: does it make
sense to have mmc alias?

As far as I recall mmc alias are not supported.
