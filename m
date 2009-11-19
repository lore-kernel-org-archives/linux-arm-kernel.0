From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 19 Nov 2009 18:47:55 +0100
Subject: [alsa-devel] i.MX audio support
In-Reply-To: <20091119163241.GB31336@rakim.wolfsonmicro.main>
References: <1258645706-9071-1-git-send-email-s.hauer@pengutronix.de>
	<20091119163241.GB31336@rakim.wolfsonmicro.main>
Message-ID: <20091119174755.GU30179@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 19, 2009 at 04:32:41PM +0000, Mark Brown wrote:
> On Thu, Nov 19, 2009 at 04:48:14PM +0100, Sascha Hauer wrote:
> 
> > There already is a driver for i.MX in the tree, this one is a nearly complete
> > rewrite. I haven't touched the in Kernel driver with these patches. The in
> > Kernel driver has several problems, it doesn't use ioremap, uses direct pointer
> > derefs instead of proper access functions and the only board supported so far is
> > itself not supported in mainline.
> 
> BTW, unless I notice anything particularly bad in there I'm inclined to
> just merge all the arch/arm patches by themselves since obviously you're
> the maintainer they'd normally go via - I'm assuming the other patches
> depend on them?

I'd prefer merging the arm patches myself as I'm afraid of bothering
upstream upstream with merge conflicts. I think I can rebase this series
in a way that there won't be compile breakages during merge.

Sascha


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
