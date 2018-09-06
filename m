From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Thu, 06 Sep 2018 12:42:31 +0200
Subject: [PATCH v3 1/4] dt-bindings: media: Add i.MX Pixel Pipeline binding
In-Reply-To: <20180906103642.GA26723@frolo.macqel>
References: <20180906090215.15719-1-p.zabel@pengutronix.de>
 <20180906090215.15719-2-p.zabel@pengutronix.de>
 <20180906103642.GA26723@frolo.macqel>
Message-ID: <1536230551.5357.7.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Philippe,

On Thu, 2018-09-06 at 12:36 +0200, Philippe De Muyter wrote:
[...]
> > --- /dev/null
> +++ b/Documentation/devicetree/bindings/media/fsl-pxp.txt
> > @@ -0,0 +1,26 @@
> > +Freescale Pixel Pipeline
> > +========================
> > +
> > +The Pixel Pipeline (PXP) is a memory-to-memory graphics processing engine
> > +that supports scaling, colorspace conversion, alpha blending, rotation, and
> > +pixel conversion via lookup table. Different versions are present on various
> > +i.MX SoCs from i.MX23 to i.MX7.
> > +
> > +Required properties:
> > +- compatible: should be "fsl,<soc>-pxp", where SoC can be one of imx23, imx28,
> > +  imx6dl, imx6sl, imx6ul, imx6sx, imx6ull, or imx7d.
> 
> Is imx6q also compatible ?

There is no pixel pipeline on i.MX6Q. It has the IPU image converter
that can be used for scaling and colorspace conversion instead [1].

[1] https://patchwork.linuxtv.org/patch/51045/

regards
Philipp
