From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 1 Mar 2012 19:30:23 +0100
Subject: [PATCH] ARM: 3ds_debugboard: Let ethernet be functional again
In-Reply-To: <20120301182139.GE10915@opensource.wolfsonmicro.com>
References: <20120213082741.GN3852@pengutronix.de>
 <20120213144820.GA3494@opensource.wolfsonmicro.com>
 <20120214105823.GS3852@pengutronix.de>
 <20120214172902.GB3916@opensource.wolfsonmicro.com>
 <20120216073236.GE3852@pengutronix.de>
 <20120216075825.GA11631@opensource.wolfsonmicro.com>
 <20120301100847.GF26642@pengutronix.de>
 <20120301105239.GA3124@opensource.wolfsonmicro.com>
 <20120301182025.GC3852@pengutronix.de>
 <20120301182139.GE10915@opensource.wolfsonmicro.com>
Message-ID: <20120301183023.GD3852@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 01, 2012 at 06:21:39PM +0000, Mark Brown wrote:
> On Thu, Mar 01, 2012 at 07:20:25PM +0100, Sascha Hauer wrote:
> > On Thu, Mar 01, 2012 at 10:52:40AM +0000, Mark Brown wrote:
> 
> > > I've already suggested just fixing the fixed voltage regulator to be
> > > more sensible when it doesn't have a voltage but you say that won't work
> > > without explaining why you think that is the case and are still ignoring
> > > my repeated queries about that.
> 
> > Maybe because I don't understand what you mean. What should the fixed
> > regulator do when voltage == 0?
> 
> Not report that it has a voltage so report an error when asked and not
> claim you can enumerate them.

Now I got it. That was a loooong way ;)

Thanks
 Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
