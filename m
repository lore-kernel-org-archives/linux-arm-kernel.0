From: fujita.tomonori@lab.ntt.co.jp (FUJITA Tomonori)
Date: Thu, 16 Sep 2010 16:08:02 +0900
Subject: [PATCH 3/5] DMA: reduce the number of memory allocations
In-Reply-To: <20100916070442.GA19994@n2100.arm.linux.org.uk>
References: <Pine.LNX.4.64.1009150919400.31624@axis700.grange>
	<20100916115815W.fujita.tomonori@lab.ntt.co.jp>
	<20100916070442.GA19994@n2100.arm.linux.org.uk>
Message-ID: <20100916160802G.fujita.tomonori@lab.ntt.co.jp>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 16 Sep 2010 08:04:42 +0100
Russell King - ARM Linux <linux@arm.linux.org.uk> wrote:

> On Thu, Sep 16, 2010 at 11:58:15AM +0900, FUJITA Tomonori wrote:
> > > to live with a few broken platforms and drivers until 2.6.37, or we'll 
> > > have to find another solution, or that NAK has to be reconsidered
> > 
> > Needs to revert the patch that causes the regression. The patch does
> > the right thing but also breaks some working platforms. You need to
> > fix "working" platforms that does wrong things before the patch.
> 
> Not going to happen.

Then, as Paul said, we live with the breakage for 2.6.36; systems that
rely on wrong behaviors could be broken.
