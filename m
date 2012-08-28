From: jason@lakedaemon.net (Jason Cooper)
Date: Tue, 28 Aug 2012 14:40:59 -0400
Subject: [PATCH 3/3] ARM: Kirkwood: increase atomic coherent pool size
In-Reply-To: <503D1005.209@samsung.com>
References: <1345459648-24263-1-git-send-email-m.szyprowski@samsung.com>
 <1345459648-24263-4-git-send-email-m.szyprowski@samsung.com>
 <20120828182523.GI19437@titan.lakedaemon.net>
 <503D1005.209@samsung.com>
Message-ID: <20120828184059.GJ19437@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 28, 2012 at 08:37:57PM +0200, Marek Szyprowski wrote:
> Hello Jason,
> 
> On 8/28/2012 8:25 PM, Jason Cooper wrote:
> >On Mon, Aug 20, 2012 at 12:47:28PM +0200, Marek Szyprowski wrote:
> >>The default 256 KiB coherent pool may be too small for some of the Kirkwood
> >>devices, so increase it to make sure that devices will be able to allocate
> >>their buffers with GFP_ATOMIC flag.
> >>
> >>Suggested-by: Josh Coombs <josh.coombs@gmail.com>
> >>Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> >
> >Acked-by: Jason Cooper <jason@lakedaemon.net>
> >
> >I assume this will go through the dma tree.  Or, if they want to Ack it,
> >I'll take it through mine since I have boards depending on this.
> 
> Thanks for the ack, I would like to push it via my dma-mapping tree
> together with the patches which add init_dma_coherent_pool_size()
> function. I've already added it to fixes-for-3.6 branch.

Great!

thx,

Jason.
