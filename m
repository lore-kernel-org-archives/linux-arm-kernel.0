From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 27 May 2015 09:33:41 +0200
Subject: [PATCH 1/5] soc: mediatek: Add infracfg misc driver support
In-Reply-To: <7hfv6jorw9.fsf@deeprootsystems.com>
References: <1431372206-1237-1-git-send-email-s.hauer@pengutronix.de>
 <1431372206-1237-2-git-send-email-s.hauer@pengutronix.de>
 <7hfv6jorw9.fsf@deeprootsystems.com>
Message-ID: <20150527073341.GU6325@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 26, 2015 at 04:12:06PM -0700, Kevin Hilman wrote:
> Sascha Hauer <s.hauer@pengutronix.de> writes:
> 
> > This adds support for some miscellaneous bits of the infracfg controller.
> > The mtk_infracfg_set/clear_bus_protection functions are necessary for
> > the scpsys power domain driver to handle the bus protection bits which
> > are contained in the infacfg register space.
> >
> > Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> 
> IMO, this feature still needs more documentation.  From an earlier
> exchange with James Liao, he was able to get some more details from the
> HW designer[1] which I think belong in comments somewhere in this
> driver.

Ok, I'll add something like this.

Sascha


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
