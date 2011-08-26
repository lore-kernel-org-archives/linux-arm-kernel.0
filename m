From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Fri, 26 Aug 2011 10:58:37 +0200
Subject: [PATCH 02/11] clk: Implement clk_set_rate
In-Reply-To: <20110826085509.GB11877@opensource.wolfsonmicro.com>
References: <20110824131324.GB16520@opensource.wolfsonmicro.com>
	<1314191759-16941-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1314191759-16941-2-git-send-email-broonie@opensource.wolfsonmicro.com>
	<20110826085327.GE7526@pengutronix.de>
	<20110826085509.GB11877@opensource.wolfsonmicro.com>
Message-ID: <20110826085837.GF7526@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 26, 2011 at 09:55:10AM +0100, Mark Brown wrote:
> On Fri, Aug 26, 2011 at 10:53:27AM +0200, Sascha Hauer wrote:
> > On Wed, Aug 24, 2011 at 02:15:50PM +0100, Mark Brown wrote:
> > > From: Jeremy Kerr <jeremy.kerr@canonical.com>
> 
> > > +propagate:
> > > +	ret = clk->ops->set_rate(clk->hw, new_rate, &parent_rate);
> 
> > You have to check for clk->ops->set_rate != NULL here for the
> > propagation case.
> 
> Note that I'm just forwarding on Jeremy's patches here, I'm not likely
> to be able to spend too much time developing the core.

Ok, then we have at least some pointer in the archives for the one
who continues on these patches.

Sascha


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
