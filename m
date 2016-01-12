From: festevam@gmail.com (Fabio Estevam)
Date: Tue, 12 Jan 2016 16:43:20 -0200
Subject: [PATCH 2/3] ARM: dts: imx6ul: add support for Ka-Ro electronics
 TXUL modules
In-Reply-To: <1452621710-15336-3-git-send-email-LW@KARO-electronics.de>
References: <1452621710-15336-1-git-send-email-LW@KARO-electronics.de>
 <1452621710-15336-2-git-send-email-LW@KARO-electronics.de>
 <1452621710-15336-3-git-send-email-LW@KARO-electronics.de>
Message-ID: <CAOMZO5Dhho3whg8p0t6FARG8vyU158mFc7d8BHxThjojm-dcQg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 12, 2016 at 4:01 PM, Lothar Wa?mann <LW@karo-electronics.de> wrote:

> +               spi at 0 {
> +                       compatible = "spidev";
> +                       reg = <0>;
> +                       spi-max-frequency = <54000000>;
> +               };
> +
> +               spi at 1 {
> +                       compatible = "spidev";
> +                       reg = <1>;
> +                       spi-max-frequency = <54000000>;
> +               };
> +       };

If you leave the spidev node, the spi core will complain loudly about it.
