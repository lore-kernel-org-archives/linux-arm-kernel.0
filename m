From: hch@lst.de (Christoph Hellwig)
Date: Tue, 20 Jun 2017 15:15:03 +0200
Subject: new dma-mapping tree, was Re: clean up and modularize arch
 dma_mapping interface V2
In-Reply-To: <6025d4d4-1975-9598-c16d-26d17d029ec7@arm.com>
References: <20170620124140.GA27163@lst.de>
 <6025d4d4-1975-9598-c16d-26d17d029ec7@arm.com>
Message-ID: <20170620131503.GA30769@lst.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 20, 2017 at 02:14:36PM +0100, Robin Murphy wrote:
> Hi Christoph,
> 
> On 20/06/17 13:41, Christoph Hellwig wrote:
> > On Fri, Jun 16, 2017 at 08:10:15PM +0200, Christoph Hellwig wrote:
> >> I plan to create a new dma-mapping tree to collect all this work.
> >> Any volunteers for co-maintainers, especially from the iommu gang?
> > 
> > Ok, I've created the new tree:
> > 
> >    git://git.infradead.org/users/hch/dma-mapping.git for-next
> > 
> > Gitweb:
> > 
> >    http://git.infradead.org/users/hch/dma-mapping.git/shortlog/refs/heads/for-next
> > 
> > And below is the patch to add the MAINTAINERS entry, additions welcome.
> 
> I'm happy to be a reviewer, since I've been working in this area for
> some time, particularly with the dma-iommu code and arm64 DMA ops.

Great, I'll add you!
