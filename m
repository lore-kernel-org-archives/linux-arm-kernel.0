From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Tue, 18 Feb 2014 12:45:12 -0300
Subject: [PATCH] net: ethernet: remove unneeded dependency of mvneta and
 update help text
In-Reply-To: <20140218151027.710ab2f3@skate>
References: <1392719391-8851-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <20140218122952.GM7862@titan.lakedaemon.net>
 <20140218134532.7607a616@skate>
 <20140218125206.GN7862@titan.lakedaemon.net>
 <20140218141303.77c77272@skate> <20140218135809.GD17984@lunn.ch>
 <20140218151027.710ab2f3@skate>
Message-ID: <20140218154512.GA10691@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 18, 2014 at 03:10:27PM +0100, Thomas Petazzoni wrote:
[..]
> 
> At the very end of the clean up, when even Orion5x support will be
> merged in mach-mvebu/, then we can certainly replace these dependencies
> by a "depends on ARCH_MVEBU". But for the time being, PLAT_ORION seems
> like the right common denominator for all these platforms.
> 

Last time we talked about this with Sebastian and Andrew it was decided
that the right choice is:

  MACH_KIRKWOOD || MACH_DOVE || MACH_ARMADA_370_XP

Which would become MACH_MVEBU.

Of course, this is near the nitpick boundary, so AFAIC you can leave
PLAT_ORION as in v2, if you feel like.
-- 
Ezequiel Garc?a, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
