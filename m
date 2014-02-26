From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Wed, 26 Feb 2014 16:31:23 +0000
Subject: [PATCH] ARM: XEN depends on having a MMU
In-Reply-To: <20140226160415.GK6865@pengutronix.de>
References: <1393425046-23317-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <alpine.DEB.2.02.1402261445020.31489@kaball.uk.xensource.com>
 <20140226160415.GK6865@pengutronix.de>
Message-ID: <alpine.DEB.2.02.1402261629550.31489@kaball.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 26 Feb 2014, Uwe Kleine-K?nig wrote:
> Hello Stefano,
> 
> On Wed, Feb 26, 2014 at 02:45:19PM +0000, Stefano Stabellini wrote:
> > On Wed, 26 Feb 2014, Uwe Kleine-K?nig wrote:
> > > arch/arm/xen/enlighten.c (and maybe others) use MMU-specific functions
> > > like pte_mkspecial which are only available on MMU builds. So let XEN
> > > depend on MMU.
> > > 
> > > Suggested-by: Arnd Bergmann <arnd@arndb.de>
> > > Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> > 
> > Acked-by: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
> Who will apply this patch? I expected that you pick it up.

OK, that's fine, I'll add it to the xentip tree.
