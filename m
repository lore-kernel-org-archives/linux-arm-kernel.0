From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 22 Nov 2012 09:54:29 +0100
Subject: [PATCH] ARM i.MX6: Fix ethernet PLL clocks
In-Reply-To: <20121122091618.GH24693@S2100-06.ap.freescale.net>
References: <1353505652-28200-1-git-send-email-s.hauer@pengutronix.de>
 <20121122084228.GF24693@S2100-06.ap.freescale.net>
 <20121122084707.GA10369@pengutronix.de>
 <20121122091618.GH24693@S2100-06.ap.freescale.net>
Message-ID: <20121122085429.GC10369@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 22, 2012 at 05:16:21PM +0800, Shawn Guo wrote:
> On Thu, Nov 22, 2012 at 09:47:07AM +0100, Sascha Hauer wrote:
> > On Thu, Nov 22, 2012 at 04:42:31PM +0800, Shawn Guo wrote:
> > > On Wed, Nov 21, 2012 at 02:47:32PM +0100, Sascha Hauer wrote:
> > > > In current code the ethernet PLL (according to code pll8, according to datasheet
> > > > pll6)
> > > 
> > > Yes, just checked the latest RM, it gets renumbered so.
> > 
> > So do we want to keep current code or change it according to the
> > datasheet?
> > 
> While you are there, yeah, let's make it match doc :)

Will do.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
