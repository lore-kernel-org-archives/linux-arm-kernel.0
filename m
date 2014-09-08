From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Mon, 08 Sep 2014 13:54:36 +0200
Subject: [PATCH v7 1/5] Documentation: Add device tree bindings for
 Freescale i.MX GPC
In-Reply-To: <CAMuHMdUqbk+OZiBMUsebQ_==7jCan+dHsfJLhi+CPUE=xc6yRA@mail.gmail.com>
References: <1409060791-23167-1-git-send-email-p.zabel@pengutronix.de>
 <1409060791-23167-2-git-send-email-p.zabel@pengutronix.de>
 <CAMuHMdUqbk+OZiBMUsebQ_==7jCan+dHsfJLhi+CPUE=xc6yRA@mail.gmail.com>
Message-ID: <1410177276.3981.35.camel@paszta.hi.pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Geert,

Am Freitag, den 05.09.2014, 13:47 +0200 schrieb Geert Uytterhoeven:
> Hi Philipp,
> 
> On Tue, Aug 26, 2014 at 3:46 PM, Philipp Zabel <p.zabel@pengutronix.de> wrote:
> > +++ b/Documentation/devicetree/bindings/power/fsl,imx-gpc.txt
> > @@ -0,0 +1,54 @@
> 
> > +IP cores belonging to a power domain should contain a 'power-domain' property
> 
> power-domains
> 
> > +that is a phandle pointing to the gpc device node and a DOMAIN_INDEX specifying
> > +the power domain the device belongs to.
> > +
> > +Example of a device that is part of the PU power domain:
> > +
> > +       vpu: vpu at 02040000 {
> > +               reg = <0x02040000 0x3c000>;
> > +               /* ... */
> > +               power-domain = <&gpc 1>;
> 
> power-domains

Thanks, I'll change those.

regards
Philipp
