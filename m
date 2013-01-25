From: horms@verge.net.au (Simon Horman)
Date: Fri, 25 Jan 2013 13:35:39 +0900
Subject: [PATCHv1 for soc 4/5] arm: Add v7_invalidate_l1 to cache-v7.S
In-Reply-To: <20130125041503.GL13691@verge.net.au>
References: <1359075633-13502-1-git-send-email-dinguyen@altera.com>
 <1359075633-13502-5-git-send-email-dinguyen@altera.com>
 <20130125041503.GL13691@verge.net.au>
Message-ID: <20130125043538.GC8930@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 25, 2013 at 01:15:03PM +0900, Simon Horman wrote:
> On Thu, Jan 24, 2013 at 07:00:32PM -0600, dinguyen at altera.com wrote:
> > From: Dinh Nguyen <dinguyen@altera.com>
> > 
> > mach-socfpga is another platform that needs to use
> > v7_invalidate_l1 to bringup additional cores. There was a comment that
> > the ideal place for v7_invalidate_l1 should be in arm/mm/cache-v7.S
> > 
> > Signed-off-by: Dinh Nguyen <dinguyen@altera.com>
> > Cc: Arnd Bergmann <arnd@arndb.de>
> > Cc: Russell King <linux@arm.linux.org.uk>
> > Cc: Olof Johansson <olof@lixom.net>
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Cc: Rob Herring <rob.herring@calxeda.com>
> > Cc: Sascha Hauer <kernel@pengutronix.de>
> > Cc: Simon Horman <horms@verge.net.au>
> > Cc: Magnus Damm <magnus.damm@gmail.com>
> > Cc: Stephen Warren <swarren@wwwdotorg.org>
> > Cc: Pavel Machek <pavel@denx.de>
> 
> mach-shmobile portion:
> 
> Acked-by: Simon Horman <horms+renesas@verge.net.au>

For the record, I tested this on the kzm9g, kzm9d and marzen boards.
