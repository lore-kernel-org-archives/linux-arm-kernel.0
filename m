From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Fri, 6 Jul 2012 08:28:52 +0200
Subject: [PATCH] i2c i.MX: Fix divider table
In-Reply-To: <20120706005249.GA26888@b20223-02.ap.freescale.net>
References: <1341493826-13861-1-git-send-email-s.hauer@pengutronix.de>
 <20120705145236.GA2735@richard-laptop>
 <20120705160153.GT30009@pengutronix.de>
 <20120706005249.GA26888@b20223-02.ap.freescale.net>
Message-ID: <20120706062852.GZ30009@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 06, 2012 at 08:52:50AM +0800, Richard Zhao wrote:
> On Thu, Jul 05, 2012 at 06:01:53PM +0200, Sascha Hauer wrote:
> > On Thu, Jul 05, 2012 at 10:52:39PM +0800, Richard Zhao wrote:
> > > On Thu, Jul 05, 2012 at 03:10:26PM +0200, Sascha Hauer wrote:
> > > > Measurements on i.MX1 and i.MX53 have shown that the divider values
> > > > in the datasheets are wrong. the values from first, third and fourth
> > > > column were all measured to be 8 higher than in the datasheet. It
> > > > should be safe to assume that the SoCs between i.MX1 and i.MX53 behave
> > > > the same as the i2c unit is unchanged since the i.MX1.
> > > We may need to check with IC guys? Or you've done?
> > 
> > I don't have contact to the IC guys. Could you do this? I'd be
> > interested in the results.
> Sure, but it may be slow, as you know, many people are in summer break.

Thanks. It can take longer, the resulting frequencies are all too low,
so we are on the safe side.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
