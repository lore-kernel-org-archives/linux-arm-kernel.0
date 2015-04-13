From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon, 13 Apr 2015 08:30:18 +0200
Subject: [PATCH 13/13] thermal: of: implement .set_trips for device tree
 thermal zones
In-Reply-To: <20150407024307.GH4648@localhost.localdomain>
References: <1427385240-6086-1-git-send-email-s.hauer@pengutronix.de>
 <1427385240-6086-14-git-send-email-s.hauer@pengutronix.de>
 <20150407024307.GH4648@localhost.localdomain>
Message-ID: <20150413063018.GT9742@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Eduardo,

On Mon, Apr 06, 2015 at 07:43:08PM -0700, Eduardo Valentin wrote:
> On Thu, Mar 26, 2015 at 04:54:00PM +0100, Sascha Hauer wrote:
> > Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> > ---
> >  drivers/thermal/of-thermal.c | 12 ++++++++++++
> >  include/linux/thermal.h      |  1 +
> >  2 files changed, 13 insertions(+)
> 
> Can you please include at least one user of this call back in your patch
> series?

Thanks for the comments on this series. I'll address them in the next
round. The user for this callback is not yet ready to be posted. I'll
try and move this patch to the end of the series so that the series can
be applied without this one.

Thanks
  Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
