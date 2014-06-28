From: jason@lakedaemon.net (Jason Cooper)
Date: Sat, 28 Jun 2014 11:07:06 -0400
Subject: [GIT PULL] ARM: mvebu: SoC changes for v3.17
In-Reply-To: <20140628162302.48b6b835@free-electrons.com>
References: <20140627124655.GF23978@titan.lakedaemon.net>
 <20140628162302.48b6b835@free-electrons.com>
Message-ID: <20140628150706.GM23978@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jun 28, 2014 at 04:23:02PM +0200, Thomas Petazzoni wrote:
> Dear Jason Cooper,
> 
> On Fri, 27 Jun 2014 08:46:55 -0400, Jason Cooper wrote:
> 
> > ----------------------------------------------------------------
> > mvebu SoC changes for v3.17
> > 
> >  - kirkwood
> >     - add setup file for netxbig LEDs (non-trivial DT binding doesn't exist yet)
> > 
> >  - mvebu
> >     - staticize where needed
> >     - add CPU hotplug for Armada XP
> >     - add public datasheet for Armada XP
> 
> It's actually Armada 370 that got a datasheet published.

oops, I must've copied from the line above in my head.  You are correct
of course.

> >     - don't apply thermal quirk by default
> >     - make Aramada 375 external abort logic a quirk
> >     - update L2/PCIe deadlock workaround after L2CC cleanup
> 
> This patch is needed in 3.16, not in 3.17. They really are bug fixes,
> fixing a complete system deadlock under PCI load.

crap.  :(  Ok, guys, please ignore this pull request and I'll send a new
one with this done properly.

Thomas, you say 'patch', but you quote three.  Should all three be in
mvebu/fixes?  Or, just the last one?

thx,

Jason.
