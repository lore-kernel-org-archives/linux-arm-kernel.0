From: jlu@pengutronix.de (Jan =?ISO-8859-1?Q?L=FCbbe?=)
Date: Mon, 17 Jul 2017 12:51:31 +0200
Subject: [PATCH 0/8] EDAC drivers for Armada XP L2 and DDR
In-Reply-To: <20170717102214.GC23129@nazgul.tnic>
References: <20170630145106.29820-1-jlu@pengutronix.de>
 <1500286727.6946.7.camel@pengutronix.de>
 <20170717102214.GC23129@nazgul.tnic>
Message-ID: <1500288691.6946.10.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2017-07-17 at 12:22 +0200, Borislav Petkov wrote:
> On Mon, Jul 17, 2017 at 12:18:47PM +0200, Jan L?bbe wrote:
> > Patches 5-7 only touch drivers/edac. If you are fine the them as
> > is, maybe you could pick them from the current version and I'll
> > drop them from v2.
> 
> No, send them all together. I'd like to have patches adding new
> interfaces and their users go together.

OK.

> I'll take a look at v2 as a whole then.

As the drivers/edac patches won't change in v2 based on the current
feedback, I hoped to reduce reduce the list traffic by addressing your
review comments in v2 as well. 

Regards,
Jan
-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
