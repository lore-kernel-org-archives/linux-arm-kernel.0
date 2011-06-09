From: grant.likely@secretlab.ca (Grant Likely)
Date: Thu, 9 Jun 2011 12:46:14 -0600
Subject: [PATCH v2 5/5] spi/ep93xx: add DMA support
In-Reply-To: <1307637757.10976.93.camel@vkoul-udesk3>
References: <20110603204400.GH17972@ponder.secretlab.ca>
	<20110607171403.GA3011@acer>
	<BANLkTikKOcc2Vg1p3kG4ZSLjJ0RTZWS=2A@mail.gmail.com>
	<20110607190607.GB3011@acer>
	<20110607191824.GA2035@ponder.secretlab.ca>
	<20110607192945.GC3011@acer>
	<20110607194034.GC2035@ponder.secretlab.ca>
	<1307505512.10976.91.camel@vkoul-udesk3>
	<20110608215356.GA17138@ponder.secretlab.ca>
	<1307637757.10976.93.camel@vkoul-udesk3>
Message-ID: <20110609184614.GA5800@ponder.secretlab.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 09, 2011 at 10:12:37PM +0530, Koul, Vinod wrote:
> On Wed, 2011-06-08 at 15:53 -0600, Grant Likely wrote:
> > On Wed, Jun 08, 2011 at 09:28:32AM +0530, Koul, Vinod wrote:
> > > Acked-by: Vinod Koul <vinod.koul@intel.com>
> > > 
> > > Let me know which branch you have pushed and I will merge that to my
> > > tree
> > 
> > Just pushed out to the branch below.  Take a look, make sure it is
> > correct, and if it looks good to you then go ahead and merge it, and I
> > ll also merge it into spi/next.
> > 
> > The following changes since commit 59c5f46fbe01a00eedf54a23789634438bb80603:
> > 
> >   Linux 3.0-rc2 (2011-06-06 18:06:33 +0900)
> > 
> > are available in the git repository at:
> >   git://git.secretlab.ca/git/linux-2.6 ep93xx-dma
>
> Thanks, I have merged them into my slave-dma next.

Good.  I've merged it into spi/next also.

g.
