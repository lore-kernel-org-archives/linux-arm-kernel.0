From: mpa@pengutronix.de (Markus Pargmann)
Date: Sat, 31 Aug 2013 08:49:40 +0200
Subject: [PATCH v2 2/7] pinctrl: imx27: imx27 pincontrol driver
In-Reply-To: <20130821012301.GA30533@S2101-09.ap.freescale.net>
References: <1376921234-26682-1-git-send-email-mpa@pengutronix.de>
 <1376921234-26682-3-git-send-email-mpa@pengutronix.de>
 <20130821012301.GA30533@S2101-09.ap.freescale.net>
Message-ID: <20130831064940.GW20071@s25.your-server.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 21, 2013 at 09:23:03AM +0800, Shawn Guo wrote:
> On Mon, Aug 19, 2013 at 04:07:09PM +0200, Markus Pargmann wrote:
> > imx27 pincontrol driver using the imx1 core driver. The DT bindings are
> > similar to other imx pincontrol drivers.
> > 
> > Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
> > ---
> >  .../bindings/pinctrl/fsl,imx27-pinctrl.txt         |  53 +++
> >  drivers/pinctrl/Kconfig                            |   8 +
> >  drivers/pinctrl/Makefile                           |   1 +
> >  drivers/pinctrl/pinctrl-imx27.c                    | 477 +++++++++++++++++++++
> >  4 files changed, 539 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/pinctrl/fsl,imx27-pinctrl.txt
> >  create mode 100644 drivers/pinctrl/pinctrl-imx27.c
> > 
> > diff --git a/Documentation/devicetree/bindings/pinctrl/fsl,imx27-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/fsl,imx27-pinctrl.txt
> > new file mode 100644
> > index 0000000..016fc89
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/pinctrl/fsl,imx27-pinctrl.txt
> > @@ -0,0 +1,53 @@
> > +* Freescale IMX27 IOMUX Controller
> > +
> > +Please refer to fsl,imx-pinctrl.txt in this directory for common binding part
> > +and usage.
> 
> Since imx-pinctrl and imx1-pinctrl are now two completely different
> drivers/bindings, is there actually anything from fsl,imx-pinctrl.txt
> could be referred to here?

No, fixed, thanks.

Regards,

Markus

> 
> Shawn
> 
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
