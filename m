From: vinod.koul@intel.com (Koul, Vinod)
Date: Fri, 12 Aug 2011 03:57:29 +0530
Subject: [PATCH V5 00/15] To use DMA generic APIs for Samsung DMA
In-Reply-To: <015101cc57f8$0d7b1da0$287158e0$%kim@samsung.com>
References: <1311744697-10264-1-git-send-email-boojin.kim@samsung.com>
	<CACRpkdZvbH1O608n_aa_nVi-Onhmt0Ay6X1yCgBVNES4o9hTrA@mail.gmail.com>
	<1312821923.1539.37.camel@vkoul-udesk3>
	<015101cc57f8$0d7b1da0$287158e0$%kim@samsung.com>
Message-ID: <1313101649.1603.27.camel@vkoul-udesk3>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2011-08-11 at 16:26 +0900, Kukjin Kim wrote:
> Koul, Vinod wrote:
> > 
> > On Thu, 2011-08-04 at 18:53 +0200, Linus Walleij wrote:
> > > On Wed, Jul 27, 2011 at 7:31 AM, Boojin Kim <boojin.kim@samsung.com> wrote:
> > >
> > > > This patchset adds support DMA generic APIs for Samsung DMA.
> > >
> > > Patches look good to me,
> > > Acked-by: Linus Walleij <linus.walleij@linaro.org>
> > 
> > Acked-by: Vinod Koul <vinod.koul@intel.com>
> > 
> > Do you want these to go thru slave-dma tree or arm tree, I am okay with
> > either...
> 
> Hi Vinod,
> 
> Thanks.
> 
> I'd like to keep its topic branch in my tree to avoid conflicts with other samsung stuff and I think, it should be merged into your slave-dma tree also for same reason.
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git #next/topic-dma-pl330
> 
> Or if you want to make some branch for it in your tree, please let me know so that I can merge it in my tree also.
Okay can you update this branch with latest patchset (I think there were
few comments on last patchset). Once you add all acks let me know the
branch, I will merge it to my next

-- 
~Vinod
