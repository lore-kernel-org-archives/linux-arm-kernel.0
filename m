From: s.trumtrar@pengutronix.de (Steffen Trumtrar)
Date: Tue, 8 Apr 2014 00:41:10 +0200
Subject: [PATCH 3/3] ARM: socfpga: dts: add reset-controller
In-Reply-To: <1396905121.25236.2.camel@linux-builds1>
References: <1396629087-23727-1-git-send-email-s.trumtrar@pengutronix.de>
 <1396629087-23727-4-git-send-email-s.trumtrar@pengutronix.de>
 <1396905121.25236.2.camel@linux-builds1>
Message-ID: <20140407224110.GA28399@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 07, 2014 at 04:12:01PM -0500, Dinh Nguyen wrote:
> On Fri, 2014-04-04 at 18:31 +0200, Steffen Trumtrar wrote:
> > Add the necessary #reset-cells property to the rst-mgr node and
> > provide a header-file with all possible resets specified.
> > 
> > Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
> > ---
> >  arch/arm/boot/dts/socfpga.dtsi           |  8 ++-
> >  include/dt-bindings/reset/altr,rst-mgr.h | 90 ++++++++++++++++++++++++++++++++
> 
> Does this file belong under dt-bindings/reset/ or
> dt-bindings/reset-controller/?
> 

ATM there is no such directory, or is there ?
So, reset seems appropriate I think.

But this reminds me, that I wanted to move the binding documentation from
Documentation/devicetree/bindings/arm/altera/socfpga-reset.txt ->
Documentation/devicetree/bindings/reset/socfpga-reset.txt

I will have to add a patch for that to the series in v2.

Thanks,
Steffen

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
