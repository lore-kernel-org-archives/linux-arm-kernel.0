From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Tue, 06 Dec 2011 13:04:53 +0100
Subject: [PATCH 1/3] PM: Provide an always on power domain governor
In-Reply-To: <02d601ccb400$a19380e0$e4ba82a0$%kim@samsung.com>
References: <1322765339-29879-1-git-send-email-broonie@opensource.wolfsonmicro.com>
 <201112042156.59990.rjw@sisk.pl>
 <20111204231005.GA4255@opensource.wolfsonmicro.com>
 <201112050115.18489.rjw@sisk.pl>
 <20111205001500.GA10173@opensource.wolfsonmicro.com>
 <02d601ccb400$a19380e0$e4ba82a0$%kim@samsung.com>
Message-ID: <008101ccb40f$4385c0d0$ca914270$%szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Tuesday, December 06, 2011 11:20 AM Kukjin Kim wrote:
 
> Mark Brown wrote:
> >
> > On Mon, Dec 05, 2011 at 01:15:18AM +0100, Rafael J. Wysocki wrote:
> > > On Monday, December 05, 2011, Mark Brown wrote:
> >
> > > > It might make sense for it to go via the Samsung tree - the third
> > patch
> > > > depends on it and there's some other stuff going on with the s3c64xx
> > > > power management - so let's see what Kukjin thinks is best.
> >
> > > OTOH, it will conflict with some patches I have in the works.
> >
> > Ah, OK - in that case I guess it's sensible if you apply it.  Ideally it
> > could be on a separate branch so it could be cross-merged with other
> > trees if there's a need later.
> 
> Hi Mark and Rafael,
> 
> Looks ok to me on this series and would be nice to me if Rafael could create
> topic branch in his tree and apply this series with my ack for Samsung
> stuff.
> 
> Rafael, please let me know the branch when you create it so that I can merge
> it into Samsung tree to avoid other conflicts.

What about similar patches for S5PV210/S5PC110 series and Exynos4? gen_pd based
power domain code for Exynos4 have been rejected in favor of custom platform-device
based power domain drivers. It would be much easier to have only one type of the
drivers across different Samsung SoCs. This will also help to hide some differences
between the series from the device drivers (clock gating, power management). 
 
Best regards
-- 
Marek Szyprowski
Samsung Poland R&D Center
