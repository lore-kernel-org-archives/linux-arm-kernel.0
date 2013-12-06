From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Fri, 6 Dec 2013 19:12:18 -0300
Subject: Merge order in Armada 370/XP (mvebu) NAND support
In-Reply-To: <20131206192540.GU29282@titan.lakedaemon.net>
References: <20131206184544.GA14986@localhost>
 <20131206192540.GU29282@titan.lakedaemon.net>
Message-ID: <20131206221217.GC2458@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 06, 2013 at 02:25:40PM -0500, Jason Cooper wrote:
> On Fri, Dec 06, 2013 at 03:45:45PM -0300, Ezequiel Garcia wrote:
> > Jason/Brian: What do you think we can do?
> 
> Revert the change adding the compatible string in the first place?
> 

Yes, that probably is the best thing to do.

Brian: what do you think? I can send you a revert of the
"armada370-nand" compatible addition to be pushed for v3.13-rc4?

The compatible can be added on top of l2-mtd.git, after all
the needed support is in the driver.
-- 
Ezequiel Garc?a, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
