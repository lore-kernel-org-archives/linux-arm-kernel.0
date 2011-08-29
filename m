From: vinod.koul@linux.intel.com (Vinod Koul)
Date: Mon, 29 Aug 2011 19:55:51 +0530
Subject: [PATCH v7 02/15] DMA: PL330: Update PL330 DMA API driver
In-Reply-To: <1314627754.1606.145.camel@vkoul-udesk3>
References: <1314238425-6480-1-git-send-email-boojin.kim@samsung.com>
	<1314238425-6480-3-git-send-email-boojin.kim@samsung.com>
	<1314626141.1606.139.camel@vkoul-udesk3>
	<1314627754.1606.145.camel@vkoul-udesk3>
Message-ID: <1314627951.1606.151.camel@vkoul-udesk3>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2011-08-29 at 19:52 +0530, Vinod Koul wrote:
> On Mon, 2011-08-29 at 19:25 +0530, Vinod Koul wrote:
> > On Thu, 2011-08-25 at 11:13 +0900, Boojin Kim wrote:
> > > This patch updates following 3 items.
> > > @@ -69,6 +70,10 @@ struct dma_pl330_chan {
> > >  	 * NULL if the channel is available to be acquired.
> > >  	 */
> > >  	void *pl330_chid;
> > > +
> > > +	/* For D-to-M and M-to-D channels */
> > > +	int burst_sz; /* the peripheral fifo width */
> > > +	dma_addr_t fifo_addr;
> > >  };
> > Why should you store peripheral address and burst size in channel
> > structure. You should take these from the API and dma_slave_structure
> Ignore my comment for burst size, but is valid for peripheral address
Never mind this one as well, I need some more coffee...


-- 
~Vinod
