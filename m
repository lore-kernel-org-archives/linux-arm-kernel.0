From: dedekind1@gmail.com (Artem Bityutskiy)
Date: Mon, 11 Mar 2013 09:32:17 +0200
Subject: [PATCH 07/12] mtd: gpmi: move to use generic DMA helper
In-Reply-To: <201303081406.18597.arnd@arndb.de>
References: <1361978748-25281-1-git-send-email-shawn.guo@linaro.org>
 <1361978748-25281-8-git-send-email-shawn.guo@linaro.org>
 <1362748785.5101.4.camel@sauron.fi.intel.com>
 <201303081406.18597.arnd@arndb.de>
Message-ID: <1362987137.5101.33.camel@sauron.fi.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2013-03-08 at 14:06 +0000, Arnd Bergmann wrote:
> On Friday 08 March 2013, Artem Bityutskiy wrote:
> > On Wed, 2013-02-27 at 23:25 +0800, Shawn Guo wrote:
> > > With the generic DMA device tree helper supported by mxs-dma driver,
> > > client devices only need to call dma_request_slave_channel() for
> > > requesting a DMA channel from dmaengine.
> > > 
> > > Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> > > Cc: Artem Bityutskiy <dedekind1@gmail.com>
> > > Cc: linux-mtd at lists.infradead.org
> > 
> > It looks like this ne is rather independent and can go via the MTD tree.
> > So pushed this one to l2-mtd.git - let me know if I am confused. Thanks!
> 
> I think you should not apply this patch on a tree that does not already
> have the first three patches in the series. The easiest way would be
> to keep the series together. As an alternative, Shawn could create a
> git branch with those three patches and let you (and the other subsystem
> maintainers) pull that branch in before applying the subsystem specific
> patch.

OK, this one looked independent to me. Anyway, dropped it and for this
one:

Acked-by: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>

-- 
Best Regards,
Artem Bityutskiy
