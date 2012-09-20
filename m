From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 20 Sep 2012 15:56:56 +0000
Subject: [PATCH v2 00/34] i.MX multi-platform support
In-Reply-To: <20120920145342.GI2450@S2101-09.ap.freescale.net>
References: <1348123547-31082-1-git-send-email-shawn.guo@linaro.org>
 <201209200739.34899.arnd@arndb.de>
 <20120920145342.GI2450@S2101-09.ap.freescale.net>
Message-ID: <201209201556.57171.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 20 September 2012, Shawn Guo wrote:
> 
> On Thu, Sep 20, 2012 at 07:39:34AM +0000, Arnd Bergmann wrote:
> > The first five branches are scheduled to go through the arm-soc tree, so
> > I'm fine with that. For the sound/for-3.7 branch, I'd like to know when
> > to expect that hitting mainline. If it always gets in very early during the
> > merge window, it's probably ok to put the imx/multi-platform patches into
> > the same branch as the other ones in arm-soc and wait for the sound stuff
> > to hit mainline first, otherwise I'd suggest we start a second
> > next/multiplatform-2 branch for imx and send the first part early on
> > but then wait with the second batch before sound gets in.
> > 
> It seems that we will have to go with next/multiplatform-2.  I just
> tried to merge the series with linux-next together, and got some
> non-trivial conflicts with media and mtd tree.  I might have to rebase
> my series on top of these trees to sort out those conflicts.  That said,
> I will have several dependencies outside arm-soc tree, and have to pend
> my series until all those trees get merged into mainline.

Ok, fair enough. I think we can put it in arm-soc/for-next as a staging
branch anyway to give it some exposure to linux-next, and then we can
decide whether a rebase is necessary before sending it to Linus.

	Arnd
