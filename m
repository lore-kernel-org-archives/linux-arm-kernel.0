From: marex@denx.de (Marek Vasut)
Date: Tue, 26 Jun 2012 13:47:01 +0200
Subject: [PATCH] mtd/m25p80: add device tree probe support
In-Reply-To: <20120626081546.GB4928@S2101-09.ap.freescale.net>
References: <1311601063-16581-1-git-send-email-shawn.guo@linaro.org>
 <201206251850.10839.marex@denx.de>
 <20120626081546.GB4928@S2101-09.ap.freescale.net>
Message-ID: <201206261347.01995.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Shawn Guo,

> On Mon, Jun 25, 2012 at 06:50:10PM +0200, Marek Vasut wrote:
> > 116                         ssp2: ssp at 80014000 {
> > 117                                 #address-cells = <1>;
> > 118                                 #size-cells = <0>;
> > 119                                 compatible = "fsl,imx28-spi";
> > 120                                 pinctrl-names = "default";
> > 121                                 pinctrl-0 = <&spi2_pins_a>;
> > 122                                 status = "okay";
> > 123
> > 124                                 flash: m25p80 at 0 {
> > 125                                         #address-cells = <1>;
> > 126                                         #size-cells = <1>;
> > 127                                         compatible = "m25p80";
> > 128                                         spi-max-frequency =
> > <25000000>; 129                                         reg = <0>;
> > 130                                 };
> > 131                         };
> > 
> > I use this + my SPI patches I submitted recently.
> 
> I do not have the flash on my imx28-evk board, but I just tested on
> imx6q-sabrelite, and yes, it can be probed without the patch.  I'm
> fine then.

Good, let's discard this patch and close this issue :-)

Best regards,
Marek Vasut
