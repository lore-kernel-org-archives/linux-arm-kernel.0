From: mpa@pengutronix.de (Markus Pargmann)
Date: Thu, 20 Jun 2013 17:45:14 +0200
Subject: [PATCH 6/6] ARM: dts: Add device tree support for phycard pca100
In-Reply-To: <1371741670.186508416@f66.mail.ru>
References: <1371739815-6666-1-git-send-email-mpa@pengutronix.de>
 <1371739815-6666-7-git-send-email-mpa@pengutronix.de>
 <1371741670.186508416@f66.mail.ru>
Message-ID: <20130620154514.GE8219@s25.your-server.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 20, 2013 at 07:21:10PM +0400, Alexander Shiyan wrote:
> > Based on patches from:
> > 
> > Steffen Trumtrar <s.trumtrar@pengutronix.de>:
> >  - Original patch
> >  - ARM: dts: Set partition offsets for phycard
> >  - ARM: dts: Use CSPI1 instead of CSPI2 on phycard pca100
> >  - ARM: imx27-phytec-phycard-S.dts: resize nand partitions
> > 
> > Jan Luebbe <jlu@pengutronix.de>:
> >  - ARM: dts: Enable bad block table in NAND
> > 
> > Cc: Steffen Trumtrar <s.trumtrar@pengutronix.de>
> > Cc: Jan Luebbe <jlu@pengutronix.de>
> > Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
> ...
> > +			gpio at 10015000 {
> > +				status = "okay";
> > +			};
> > +
> > +			gpio at 10015100 {
> > +				status = "okay";
> > +			};
> > +
> > +			gpio at 10015200 {
> > +				status = "okay";
> > +			};
> > +
> > +			gpio at 10015300 {
> > +				status = "okay";
> > +			};
> > +
> > +			gpio at 10015400 {
> > +				status = "okay";
> > +			};
> > +
> > +			gpio at 10015500 {
> > +				status = "okay";
> > +			};
> 
> No need setup status for devices which not disabled in imx27.dts

Thanks, I removed all unnecessary nodes, gpio and wdog.

Regards,

Markus

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
