From: kgene.kim@samsung.com (Kukjin Kim)
Date: Fri, 19 Aug 2011 14:24:09 +0900
Subject: [PATCH V5 00/15] To use DMA generic APIs for Samsung DMA
In-Reply-To: <1313492476.1603.39.camel@vkoul-udesk3>
References: <1311744697-10264-1-git-send-email-boojin.kim@samsung.com>
	<CACRpkdZvbH1O608n_aa_nVi-Onhmt0Ay6X1yCgBVNES4o9hTrA@mail.gmail.com>
	<1312821923.1539.37.camel@vkoul-udesk3>
	<015101cc57f8$0d7b1da0$287158e0$%kim@samsung.com>
	<1313101649.1603.27.camel@vkoul-udesk3>
	<000701cc596f$08811160$19833420$%kim@samsung.com>
	<1313492476.1603.39.camel@vkoul-udesk3>
Message-ID: <000501cc5e30$3a1752f0$ae45f8d0$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Koul, Vinod wrote:
> 
> On Sat, 2011-08-13 at 13:11 +0900, Kukjin Kim wrote:
> > Koul, Vinod wrote:
> > >
> > > On Thu, 2011-08-11 at 16:26 +0900, Kukjin Kim wrote:
> > > > Koul, Vinod wrote:
> > > > >
> > > > > On Thu, 2011-08-04 at 18:53 +0200, Linus Walleij wrote:
> > > > > > On Wed, Jul 27, 2011 at 7:31 AM, Boojin Kim
> <boojin.kim@samsung.com>
> > > wrote:
> > > > > >
> > > > > > > This patchset adds support DMA generic APIs for Samsung DMA.
> > > > > >
> > > > > > Patches look good to me,
> > > > > > Acked-by: Linus Walleij <linus.walleij@linaro.org>
> > > > >
> > > > > Acked-by: Vinod Koul <vinod.koul@intel.com>
> > > > >
> > > > > Do you want these to go thru slave-dma tree or arm tree, I am okay with
> > > > > either...
> > > >
> > > > Hi Vinod,
> > > >
> > > > Thanks.
> > > >
> > > > I'd like to keep its topic branch in my tree to avoid conflicts with other
> samsung
> > > stuff and I think, it should be merged into your slave-dma tree also for same
> > > reason.
> > > >
> > > > git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git
> #next/topic-
> > > dma-pl330
> > > >
> > > > Or if you want to make some branch for it in your tree, please let me know so
> > > that I can merge it in my tree also.
> > > Okay can you update this branch with latest patchset (I think there were
> > > few comments on last patchset). Once you add all acks let me know the
> > > branch, I will merge it to my next
> >
> > Hi,
> >
> > I updated it so that you can merge it to yours.
> > I think, if any fixing is required on that, it should be small so can be fixed easily
> after this merging.
> >
> > If any problems, please let me know :)
> >
> Well, that not how things are supposed to be done. Fixing an error
> introduced is not recommended, rather original patch set should be
> fixed.
> Since you have already done 5 posting of your patch series, I am okay if
> you split things up, send me the parts that have already been reviewed
> and acked. I will host them on a branch for you. Once rest is reviewed
> and acked, I will merge this entire branch to my next.
> 
OK, Boojin will send whole series soon.
Then if you make a branch for me, I will merge it too.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
