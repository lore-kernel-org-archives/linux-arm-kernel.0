From: andrew@lunn.ch (Andrew Lunn)
Date: Wed, 25 Dec 2013 17:41:19 +0100
Subject: [PATCH] ata: sata_mv: setting PHY speed according to SControl
 speed
In-Reply-To: <20131224194603.GE19878@titan.lakedaemon.net>
References: <1387800455-30629-1-git-send-email-simon.guinot@sequanux.org>
 <20131224194603.GE19878@titan.lakedaemon.net>
Message-ID: <20131225164119.GC31584@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 24, 2013 at 02:46:03PM -0500, Jason Cooper wrote:
> On Mon, Dec 23, 2013 at 01:07:35PM +0100, Simon Guinot wrote:
> > From: Lior Amsalem <alior@marvell.com>
> > 
> > From: Lior Amsalem <alior@marvell.com>
> > 
> > This patch fixes a SATA hotplug issue on the Armada 370 and Armada XP
> > SoCs. Without it, if a disk is unplugged from a SATA port, then further
> > hotplug notification are now longer received on this port.
> > 
> > This should be applied to every -stable kernel supporting Armada SoCs.
> 
> Could we get a little more specific here?  Please determine which commit
> introduced the regression and note it with 'Fixes: <commitish> "oneline"'
> 
> It's really needed here since the sata_mv driver predates the Armada
> SoCs introduction.  Is it possible Kirkwood et al also experience this
> problem?

Hi Jason

It is on my TODO list to try this out on Kirkwood and Dove. I'm pretty
sure replug works on Dove without this, not tried Kirkwood yet.

     Andrew
