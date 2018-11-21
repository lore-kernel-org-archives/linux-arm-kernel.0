From: konrad.wilk@oracle.com (Konrad Rzeszutek Wilk)
Date: Wed, 21 Nov 2018 10:11:33 -0500
Subject: [PATCH 0/2] SWIOTLB fixes for 4.20
In-Reply-To: <20181121130331.GA1373@lst.de>
References: <cover.1542722463.git.robin.murphy@arm.com>
 <20181120160818.GC2492@lst.de>
 <20181120163441.GD31199@char.us.oracle.com>
 <20181121130331.GA1373@lst.de>
Message-ID: <20181121151133.GC26925@char.us.oracle.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 21, 2018 at 02:03:31PM +0100, Christoph Hellwig wrote:
> On Tue, Nov 20, 2018 at 11:34:41AM -0500, Konrad Rzeszutek Wilk wrote:
> > > Konrad, are you ok with me picking up both through the dma-mapping
> > > tree?
> > 
> > Yes, albeit I would want Stefano to take a peek at patch #2 just in case.
> 
> Stefano, can you take a look asap?  This is a pretty trivial fix for
> a nasty bug that breaks boot on real life systems.  I'd like to merge
> it by tomorrow so that I can send it off to Linus for the next rc
> (I will be offline for about two days after Friday morning)

It is Turkey Day in US so he may be busy catching those pesky turkeys.
How about Tuesday? And in can also send the GIT PULL.
