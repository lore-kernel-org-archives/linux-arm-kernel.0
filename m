From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Sat, 9 Mar 2013 09:51:54 +0100
Subject: [GIT PULL 3.9] Various fixes for Marvell EBU platforms
In-Reply-To: <20130308222317.GV23237@titan.lakedaemon.net>
References: <1362565416-15718-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <20130308222317.GV23237@titan.lakedaemon.net>
Message-ID: <20130309095154.33bb27a8@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Jason Cooper,

On Fri, 8 Mar 2013 17:23:17 -0500, Jason Cooper wrote:

> > Heikki Krogerus (1):
> >       arm: mvebu: Reduce reg-io-width with UARTs
> > 
> > Thomas Petazzoni (3):
> >       arm: plat-orion: fix address decoding when > 4GB is used
> >       arm: mvebu: fix address-cells in mpic DT node
> >       arm: mach-orion5x: fix typo in compatible string of a .dts file
> > 
> >  arch/arm/boot/dts/armada-370-xp.dtsi               |    5 ++---
> >  arch/arm/boot/dts/armada-xp.dtsi                   |    4 ++--
> >  .../dts/orion5x-lacie-ethernet-disk-mini-v2.dts    |    2 +-
> >  arch/arm/plat-orion/addr-map.c                     |    7 +++++--
> >  4 files changed, 10 insertions(+), 8 deletions(-)
> 
> All applied to mvebu/fixes

Thanks!

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
