From: Haibo.Chen@freescale.com (Chen Bough)
Date: Tue, 28 Jul 2015 08:48:08 +0000
Subject: [PATCH 2/5] Documentation: Detail permitted DT properties for the
 imx6ul_tsc
In-Reply-To: <20150727112547.GE9169@leverpostej>
References: <1437996407-27266-1-git-send-email-haibo.chen@freescale.com>
 <1437996407-27266-3-git-send-email-haibo.chen@freescale.com>
 <20150727112547.GE9169@leverpostej>
Message-ID: <BY1PR03MB13888ECA78EBCB233E799BC09A8D0@BY1PR03MB1388.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,



> -----Original Message-----
> From: Mark Rutland [mailto:mark.rutland at arm.com]
> Sent: Monday, July 27, 2015 7:26 PM
> To: Chen Haibo-B51421
> Cc: robh+dt at kernel.org; Pawel Moll; ijc+devicetree at hellion.org.uk;
> galak at codeaurora.org; shawnguo at kernel.org; kernel at pengutronix.de;
> linux at arm.linux.org.uk; dmitry.torokhov at gmail.com; hans.verkuil at cisco.com;
> hadess at hadess.net; mchehab at osg.samsung.com; mamlinav at gmail.com;
> arnd at arndb.de; jonathar at broadcom.com; hdegoede at redhat.com;
> christian.gmeiner at gmail.com; scott.liu at emc.com.tw; geert at linux-m68k.org;
> benjamin.tissoires at redhat.com; sebastien.szymanski at armadeus.com;
> sbranden at broadcom.com; devicetree at vger.kernel.org; linux-
> kernel at vger.kernel.org; linux-arm-kernel at lists.infradead.org; linux-
> input at vger.kernel.org
> Subject: Re: [PATCH 2/5] Documentation: Detail permitted DT properties
> for the imx6ul_tsc
> 
> On Mon, Jul 27, 2015 at 12:26:44PM +0100, Haibo Chen wrote:
> > Here we apply required documentation for the imx6ul touch screen
> > controller driver which describe available properties and how to use
> > them.
> >
> > Signed-off-by: Haibo Chen <haibo.chen@freescale.com>
> > ---
> >  .../devicetree/bindings/input/touchscreen/imx6ul_tsc.txt   | 14
> ++++++++++++++
> >  1 file changed, 14 insertions(+)
> >  create mode 100644
> > Documentation/devicetree/bindings/input/touchscreen/imx6ul_tsc.txt
> >
> > diff --git
> > a/Documentation/devicetree/bindings/input/touchscreen/imx6ul_tsc.txt
> > b/Documentation/devicetree/bindings/input/touchscreen/imx6ul_tsc.txt
> > new file mode 100644
> > index 0000000..e34d752
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/input/touchscreen/imx6ul_tsc.t
> > +++ xt
> > @@ -0,0 +1,14 @@
> > +* Freescale i.MX6UL Touch Controller
> > +
> > +Required properties:
> > +- compatible: must be "fsl,imx6ul-tsc"
> > +
> 
> What about all the other properties in the example?

[haibo] I will add other properties in the documentation. 

> 
> > +Example:
> > +	&tsc {
> > +		pinctrl-names = "default";
> > +		pinctrl-0 = <&pinctrl_tsc>;
> > +		status = "okay";
> > +		xnur-gpio = <&gpio1 3 GPIO_ACTIVE_HIGH>;
> > +		measure_delay_time = <0xfff>;
> > +		pre_charge_time = <0xffff>;
> 
> Thiose underscores should be dashes, and all the properties should be
> documented.

[haibo] I will change to "measure-delay-time" and "pre-charge-time"

Thanks for your review!

Haibo.

> 
> Mark.
