From: wim@iguana.be (Wim Van Sebroeck)
Date: Fri, 17 Jun 2011 09:20:45 +0200
Subject: [MPCore Watchdog]: Convert from misc_dev to dynamic device node.
In-Reply-To: <201106152136.23971.arnd@arndb.de>
References: <BANLkTinaQpnVxwX5rB1jrabGX6ArvhhS7g@mail.gmail.com>
	<BANLkTinY8bM0PyLLcu6icEsWT=X=KVV3DQ@mail.gmail.com>
	<20110615190945.GA2518@pulham.picochip.com>
	<201106152136.23971.arnd@arndb.de>
Message-ID: <20110617072045.GM23305@infomag.iguana.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

> On Wednesday 15 June 2011 21:09:45 Jamie Iles wrote:
> > On Wed, Jun 15, 2011 at 11:57:12AM -0700, Peter Fordham wrote:
> > > > I've added Wim (watchdog driver maintainer), but I would think that if
> > > > this change is worth doing then it should be done for all drivers.
> > > 
> > > Agreed, but today this may be more work than I'm strictly interested in
> > > doing. If we do decide it's the right thing then I'll look into converting the
> > > other drivers later.
> > 
> > So I'm not fully aware of what particular problem this is solving, but 
> > if it is needed for this driver then it should really be done for all of 
> > them.  That's probably one for Wim to answer though.  Wim posted a 
> > series for a generic watchdog framework a while back[1] but this still 
> > made use of a misc device.
> 
> Let's first wait until the generic watchdog framework gets merged and
> the drivers are converted. After that is in, we can discuss further changes.
> 
> I highly doubt that making an incompatible API change benefits anyone here,
> but it certainly shouldn't be done for a single driver that is separate from
> the framework.

Agree for the full 100%.

Thanks,
Wim.
