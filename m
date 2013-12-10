From: vinod.koul@intel.com (Vinod Koul)
Date: Tue, 10 Dec 2013 15:43:31 +0530
Subject: [PATCH] dma: mv_xor: remove mv_desc_get_dest_addr()
In-Reply-To: <20131209235035.GA11632@n2100.arm.linux.org.uk>
References: <1385408365-8072-1-git-send-email-jason@lakedaemon.net>
 <20131128055706.GM8834@intel.com>
 <20131209235035.GA11632@n2100.arm.linux.org.uk>
Message-ID: <20131210101331.GG29580@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 09, 2013 at 11:50:35PM +0000, Russell King - ARM Linux wrote:
> On Thu, Nov 28, 2013 at 11:27:06AM +0530, Vinod Koul wrote:
> > + Dan
> > 
> > On Mon, Nov 25, 2013 at 07:39:25PM +0000, Jason Cooper wrote:
> > > The following commit:
> > > 
> > >   54f8d501e842 dmaengine: remove DMA unmap from drivers
> > > 
> > > removed the last caller to mv_desc_get_dest_addr(), creating the
> > > warning:
> > > 
> > >   drivers/dma/mv_xor.c:57:12: warning: 'mv_desc_get_dest_addr' defined
> > >   but not used [-Wunused-function]
> > > 
> > > Remove it.
> > > 
> > > Signed-off-by: Jason Cooper <jason@lakedaemon.net>
> > Acked-by: Vinod Koul <vinod.koul@intel.com>
> > 
> > This should go thru Dan's tree
> 
> So what's happening with this patch?  I don't see it in -rc yet.
Dan has applied this to his next. So this should show us in next rc1

--
~Vinod
