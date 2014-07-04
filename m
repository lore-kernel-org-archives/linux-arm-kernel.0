From: r.schwebel@pengutronix.de (Robert Schwebel)
Date: Fri, 4 Jul 2014 20:18:34 +0200
Subject: i.MX6 graphics status
In-Reply-To: <m34myxrsad.fsf@intrepid.localdomain>
References: <m34myxrsad.fsf@intrepid.localdomain>
Message-ID: <20140704181834.GK5441@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 04, 2014 at 06:40:42PM +0200, Krzysztof Halasa wrote:
> do any of you have, by chance, information about status of i.MX6
> graphics? I mean things like GLX and H.264 encoding and decoding.
> I know Freescale has some (partially binary-only) packages which can do,
> to some degree, GLX and perhaps other things. Is it all I can use, or
> maybe etnaviv/etc. could be used as well? What about IMX DRM driver?

Our focus is now on emptying our internal patch queue, which grew
already too large. Philipp Zabel posted a bunch of CODA and CSI patches;
a lot of review feedback needs to be worked into the series.

We gained some projects recently which involve improving the Etnaviv
stack (we had a prototype running with Qt 5 earlier this year), let's
see where this leads to. All the results will be posted here.

rsc
-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
