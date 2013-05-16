From: jason@lakedaemon.net (Jason Cooper)
Date: Thu, 16 May 2013 12:12:02 -0400
Subject: [PATCHv9 7/9] pci: PCIe driver for Marvell Armada 370/XP systems
In-Reply-To: <20130516180850.3622e1a8@skate>
References: <1368624323-24311-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1368624323-24311-8-git-send-email-thomas.petazzoni@free-electrons.com>
 <20130516093312.GB2459@localhost>
 <20130516154031.GF6563@titan.lakedaemon.net>
 <20130516174903.3a7a07ef@skate>
 <20130516155617.GH6563@titan.lakedaemon.net>
 <20130516180850.3622e1a8@skate>
Message-ID: <20130516161201.GI6563@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 16, 2013 at 06:08:50PM +0200, Thomas Petazzoni wrote:
> Dear Jason Cooper,
> 
> On Thu, 16 May 2013 11:56:17 -0400, Jason Cooper wrote:
> 
> > > > > Building this showed a warning here. It seems you forgot
> > > > > to mark this one as __init.
> > > > 
> > > > Thomas, I'll fix this up when I pull this in, no need to resend. :)
> > > 
> > > I'll resend, because beyond this function pointed by Ezequiel, there
> > > are two other functions that can be marked __init. The one pointed by
> > > Ezequiel is important because it causes a section mismatch
> > > when !CONFIG_MODULES, because in this case platform_driver_probe() is
> > > __init (and this explains what I wasn't seeing the warning, since I'm
> > > building CONFIG_MODULES=y). The two other functions are more cosmetic,
> > > but good to have as well.
> > > 
> > > It would already been sent if git hadn't decided to do a 'git gc' right
> > > after my rebase. It's been gc-ing for quite some time now...
> > 
> > Dear boss,
> > 
> > I am in desperate need of a 500GB SSD on which to do my kernel work.
> > 
> > Thanks,
> > 
> > Kranky Kernel Developer
> > 
> > hehehe...
> 
> Adding boss in the Cc list :-)

Hey, whatever works for you.  Good luck!

thx,

Jason.
