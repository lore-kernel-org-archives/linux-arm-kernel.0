From: grant.likely@secretlab.ca (Grant Likely)
Date: Tue, 5 Jul 2011 12:04:04 -0600
Subject: [PATCH 7/7] ASoC: Samsung: Update DMA interface
In-Reply-To: <00bf01cc3ae3$d5a29150$80e7b3f0$%kim@samsung.com>
References: <1309781915-31549-1-git-send-email-kgene.kim@samsung.com>
	<1309781915-31549-8-git-send-email-kgene.kim@samsung.com>
	<20110704170259.GC28726@opensource.wolfsonmicro.com>
	<00bf01cc3ae3$d5a29150$80e7b3f0$%kim@samsung.com>
Message-ID: <20110705180404.GA7810@ponder.secretlab.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 05, 2011 at 04:19:05PM +0900, Kukjin Kim wrote:
> Mark Brown wrote:
> > 
> Hi Mark,
> 
> Please refer to my other comment which includes block diagram, it can help
> our understanding about current Samsung DMA usage.
> 
> > Two questions here:
> > 
> > - It looks like a lot of this code can be shared between all the drivers
> >   using the dmaengine API.  Is there any reason not to factor it out?
> 
> Hmm...I'm not sure, but let us think/check your suggestions. Thanks :)
> 
> > - Should this not be adding a new driver for dmaengine based Samsung
> >   CPUs?  The ifdefs are very big.
> 
> OK, we will try.
> 
> Grant, I think, Mark's suggestion can support multiple platform...

Yes, it should.

g.
