From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Tue, 20 Jun 2017 23:04:00 +1000
Subject: new dma-mapping tree, was Re: clean up and modularize arch
 dma_mapping interface V2
In-Reply-To: <20170620124140.GA27163@lst.de>
References: <20170616181059.19206-1-hch@lst.de> <20170620124140.GA27163@lst.de>
Message-ID: <20170620230400.1a5ae889@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Christoph,

On Tue, 20 Jun 2017 14:41:40 +0200 Christoph Hellwig <hch@lst.de> wrote:
>
> On Fri, Jun 16, 2017 at 08:10:15PM +0200, Christoph Hellwig wrote:
> > I plan to create a new dma-mapping tree to collect all this work.
> > Any volunteers for co-maintainers, especially from the iommu gang?  
> 
> Ok, I've created the new tree:
> 
>    git://git.infradead.org/users/hch/dma-mapping.git for-next
> 
> Gitweb:
> 
>    http://git.infradead.org/users/hch/dma-mapping.git/shortlog/refs/heads/for-next
> 
> And below is the patch to add the MAINTAINERS entry, additions welcome.
> 
> Stephen, can you add this to linux-next?

Added from tomorrow.

I have another tree called dma-mapping:

git://git.linaro.org/people/mszyprowski/linux-dma-mapping.git#dma-mapping-next

Contacts: Marek Szyprowski and Kyungmin Park (cc'd)

I have called your tree dma-mapping-hch for now.  The other tree has
not been updated since 4.9-rc1 and I am not sure how general it is.
Marek, Kyungmin, any comments?

Thanks for adding your subsystem tree as a participant of linux-next.  As
you may know, this is not a judgement of your code.  The purpose of
linux-next is for integration testing and to lower the impact of
conflicts between subsystems in the next merge window. 

You will need to ensure that the patches/commits in your tree/series have
been:
     * submitted under GPL v2 (or later) and include the Contributor's
        Signed-off-by,
     * posted to the relevant mailing list,
     * reviewed by you (or another maintainer of your subsystem tree),
     * successfully unit tested, and 
     * destined for the current or next Linux merge window.

Basically, this should be just what you would send to Linus (or ask him
to fetch).  It is allowed to be rebased if you deem it necessary.

-- 
Cheers,
Stephen Rothwell 
sfr at canb.auug.org.au
