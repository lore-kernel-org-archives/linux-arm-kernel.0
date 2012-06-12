From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 12 Jun 2012 17:39:22 +0000
Subject: [PATCH v2] arm: Add basic support for new Marvell Armada 370 and
 Armada XP SoC
In-Reply-To: <20120612154020.GF14756@titan.lakedaemon.net>
References: <1339433585-28087-1-git-send-email-gregory.clement@free-electrons.com>
 <201206121459.14114.arnd@arndb.de>
 <20120612154020.GF14756@titan.lakedaemon.net>
Message-ID: <201206121739.22705.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 12 June 2012, Jason Cooper wrote:
> > 
> > FWIW, the board-dt.c from mach-kirkwood should just become kirkwood.c
> > and we might want to merge it with the kirkwood common.c file in the long
> > run, if any contents from that file remain for the dt version.
> 
> So, there would be an orion5x.c, dove.c as well?  Or, should it be
> mvebu.c to encompass all of them?

Yes, I think we should have one of those files contain the DT_MACHINE
definition for that soc type, unless they are unified to the point where
we only need one.

	Arnd
