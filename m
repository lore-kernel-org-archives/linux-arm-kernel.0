From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Thu, 6 Mar 2014 21:10:01 -0300
Subject: [PATCH 0/4] ARM: mvebu: Device Tree updates for Armada XP boards
In-Reply-To: <20140306200543.GG1872@titan.lakedaemon.net>
References: <1393951022-18114-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <20140306200543.GG1872@titan.lakedaemon.net>
Message-ID: <20140307001001.GA13690@arch.cereza>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mar 06, Jason Cooper wrote:
> On Tue, Mar 04, 2014 at 05:36:58PM +0100, Thomas Petazzoni wrote:
> > Hello,
> > 
> > This set of commits updates the Armada XP DB and Armada XP GP Device
> > Trees to work with the newest DT capable bootloaders from Marvell that
> > remap internal registers at 0xf1000000 and move the MBus Window base
> > address to 0xf0000000.
> > 
> > Also, the last commit updates the available amount of RAM on the
> > Armada XP Matrix board.
> > 
> > Thomas
> > 
> > Thomas Petazzoni (4):
> >   ARM: mvebu: change the default PCIe apertures for Armada 370/XP
> >   ARM: mvebu: switch the Armada XP DB to use internal registers at
> >     0xf1000000
> >   ARM: mvebu: switch the Armada XP GP to use internal registers at
> >     0xf1000000
> >   ARM: mvebu: the Armada XP Matrix board has 4 GB
> > 
> >  arch/arm/boot/dts/armada-370-xp.dtsi   |  4 ++--
> >  arch/arm/boot/dts/armada-xp-db.dts     | 13 +++++++++++--
> >  arch/arm/boot/dts/armada-xp-gp.dts     | 22 ++++++++++++++++------
> >  arch/arm/boot/dts/armada-xp-matrix.dts |  7 ++++++-
> >  4 files changed, 35 insertions(+), 11 deletions(-)
> 
> Whole series applied to mvebu/dt.
> 
> fyi - we only have one more day of -next (tonight, 7pm US East Coast
> time) before -rc6 drops.
> 
> I'm comfortable sending a lightly tested mvebu/dt pull request with all
> the stuff submitted in the last couple days, but I fear there isn't
> enough testing time before arm-soc stops taking pull requests.
> 
> I'm particularly concerned about the watchdog changes and the coherency

Hm... I wasn't really aiming v3.15, as I thought it was already too late.

On the other side, if we can get someone to review the changes and someone
to double-check them on 370/XP/Kirkwood, you could pull it soon enough?

Anyway, it's not a big deal if it gets pulled in v3.16. We are already
doing *a lot* of mvebu movement in this release, IMHO.
-- 
Ezequiel Garc?a, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
