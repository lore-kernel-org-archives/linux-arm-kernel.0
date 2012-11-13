From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 13 Nov 2012 09:21:51 +0000
Subject: [PATCH 0/7] ARM: remove init_consistent_dma_size() stub
In-Reply-To: <50A20AAF.9050809@samsung.com>
References: <1352360783-17523-1-git-send-email-m.szyprowski@samsung.com>
 <201211130849.30280.arnd@arndb.de> <50A20AAF.9050809@samsung.com>
Message-ID: <201211130921.52410.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 13 November 2012, Marek Szyprowski wrote:
> On 11/13/2012 9:49 AM, Arnd Bergmann wrote:
> > On Tuesday 13 November 2012, Kukjin Kim wrote:
> > > Arnd Bergmann wrote:
> > > >
> > > > Applied patches 2-7 to next/cleanup branch, with the Acks that came in.
> > > >
> > > (- many guys in Cc)
> > >
> > > Hi Arnd,
> > >
> > > If possible, please adding my ack on Samsung stuff.
> > >
> > > Acked-by: Kukjin Kim <kgene.kim@samsung.com>
> > >
> >
> > Thanks for your Ack, but I'd prefer not to redo the branch now, since I already
> > merged other patches on top.
> 
> If you redo your branch, please make sure that the patch which removes the
> init_consistent_dma_size() stub from dma-mapping.h (7th in my series) would
> be the last one to avoid build break on git bisect. For unknown reason the
> order of patches on your tree got changed in compared to the series I've 
> sent.

Ok, I've redone the branch now and added Kukjin's Ack.

	Arnd
