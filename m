From: mpa@pengutronix.de (Markus Pargmann)
Date: Thu, 24 Oct 2013 11:27:52 +0200
Subject: [PATCH v4 6/7] ARM: dts: imx27 phycore pinctrl
In-Reply-To: <1382603424.519504719@f304.i.mail.ru>
References: <1382601233-24253-1-git-send-email-mpa@pengutronix.de>
 <1382601233-24253-7-git-send-email-mpa@pengutronix.de>
 <1382603424.519504719@f304.i.mail.ru>
Message-ID: <20131024092752.GB27073@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 24, 2013 at 12:30:24PM +0400, Alexander Shiyan wrote:
> > Enable pinctrl for phycore devices.
> > 
> > Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
> > Acked-by: Sascha Hauer <s.hauer@pengutronix.de>
> ...
> > diff --git a/arch/arm/boot/dts/imx27-phytec-phycore-som.dts b/arch/arm/boot/dts/imx27-phytec-phycore-som.dts
> > index 4ec402c..3dbdb5e 100644
> > --- a/arch/arm/boot/dts/imx27-phytec-phycore-som.dts
> > +++ b/arch/arm/boot/dts/imx27-phytec-phycore-som.dts
> ...
> >  &uart1 {
> > +	pinctrl-names = "default";
> > +	pinctrl-0 = <&pinctrl_uart1_1 &pinctrl_uart1_rtscts_1>;
> >  	status = "okay";
> >  };
> 
> No. Please put RTS & CTS pins into RDK. There are no hardware dependencies for SOM.

Okay, I will move both uarts into rdk.

Thanks,

Markus

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
