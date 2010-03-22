From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Mon, 22 Mar 2010 22:09:46 +0100
Subject: [PULL REQUEST] runtime physoffset [Was: change boot requirements]
In-Reply-To: <20100308121550.GC9233@matterhorn.verdurent.com>
References: <20100119083803.GA17904@pengutronix.de>
	<20100122115831.GA8377@pengutronix.de>
	<20100125173201.GA14834@pengutronix.de>
	<4B5DF1C9.6090102@bluewatersys.com>
	<20100130210231.GC16345@pengutronix.de>
	<20100204095147.GA6562@pengutronix.de>
	<20100212110350.GB18221@pengutronix.de>
	<20100308121550.GC9233@matterhorn.verdurent.com>
Message-ID: <20100322210946.GE10157@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Mon, Mar 08, 2010 at 02:15:50PM +0200, Amit Kucheria wrote:
> On 10 Feb 12, Uwe Kleine-K?nig wrote:
> > Hello Russell,
> > 
> > On Thu, Feb 04, 2010 at 10:51:47AM +0100, Uwe Kleine-K?nig wrote:
> > > > The following changes since commit 499a2673713c85734a54c37dd90b4b729de399c4:
> > > >   Linus Torvalds (1):
> > > >         Merge branch 'for-linus' of git://git.kernel.org/.../dtor/input
> > > > 
> > > > are available in the git repository at:
> > > > 
> > > >   git://git.pengutronix.de/git/ukl/linux-2.6.git arm/booting
> > > 
> > > Can you please pull this branch for the .34 merge window?  Since the
> > > last post one new patch was added to that branch.  I'll send it in reply
> > > to this mail.
> > Do you consider pulling?  If not, can you please say why?
> > 
> > Best regards
> > Uwe
> 
> Bumping up this thread since these patches are necessary to reach our
> eventual goal of a common kernel.
Actually the patches in arm/booting are only some cleanups.  This series
contained in arm/booting doesn't contain the two runtime physoffset
patches[1]

Russell?

Best regards
Uwe

[1] these are in my arm/booting-pu branch

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
