From: martin@kaiser.cx (Martin Kaiser)
Date: Mon, 17 Jul 2017 23:04:25 +0200
Subject: [PATCH v2 1/3] Documentation: devicetree: add Freescale RNGC
 binding
In-Reply-To: <20160318194213.GA10766@rob-hp-laptop>
References: <1457705200-16951-1-git-send-email-s.trumtrar@pengutronix.de>
 <20160318194213.GA10766@rob-hp-laptop>
Message-ID: <20170717210425.GB15429@reykholt.kaiser.cx>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I'd like to pick this up and get the rngc driver merged finally.

Thus wrote Rob Herring (robh at kernel.org):

> The MXC name is still not dead?

looks like no. There's still CONFIG_ARCH_MXC etc. The other similar rng
driver is called mxc-rnga.c so it makes sense to use mxc-rngc.

> >  1 file changed, 16 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/rng/mxc_rngc.txt

> > diff --git a/Documentation/devicetree/bindings/rng/mxc_rngc.txt b/Documentation/devicetree/bindings/rng/mxc_rngc.txt
> > new file mode 100644
> > index 000000000000..e147a6dde40a
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/rng/mxc_rngc.txt
> > @@ -0,0 +1,16 @@
> > +Freescale RNGC (Random Number Generator Version C)
> > +
> > +Required properties:
> > +- compatible : Should be "fsl,imx25-rng"

> What about i.MX3/5 compatible strings?

I couldn't find an imx5 chip that has this rng. I added a compatible
string for imx35.

Best regards,

   Martin
