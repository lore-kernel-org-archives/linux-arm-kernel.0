From: jlu@pengutronix.de (Jan =?ISO-8859-1?Q?L=FCbbe?=)
Date: Wed, 29 Jul 2015 12:27:30 +0200
Subject: [PATCH] i2c: omap: fix bus recovery setup
In-Reply-To: <20150714121207.GI1517@katana>
References: <1436366127-24756-1-git-send-email-jlu@pengutronix.de>
 <20150714111004.GB1517@katana> <55A4FC19.4040709@ti.com>
 <20150714121207.GI1517@katana>
Message-ID: <1438165650.20986.2.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Di, 2015-07-14 at 14:12 +0200, Wolfram Sang wrote:
> On Tue, Jul 14, 2015 at 03:10:01PM +0300, Grygorii Strashko wrote:
> > Hi Wolfram,
> > 
> > On 07/14/2015 02:10 PM, Wolfram Sang wrote:
> > > On Wed, Jul 08, 2015 at 04:35:27PM +0200, Jan Luebbe wrote:
> > >> At least on the AM335x, enabling OMAP_I2C_SYSTEST_ST_EN is not enough to
> > > 
> > > Felipe: it seems you did not need this; is this AM335x specific?
> > 
> > We need it (Felipe's reply can be delayed).
> 
> So, how did it work for him?
> 
> > It's not AM335x specific. TMODE has to be configured for all OMAP4+ SoCs too.
> 
> Okay, thanks for the stepping in!

Wolfram, will you pick this as-is?

Regards,
Jan
-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
