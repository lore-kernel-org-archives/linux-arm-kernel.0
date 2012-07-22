From: kgene.kim@samsung.com (Kukjin Kim)
Date: Mon, 23 Jul 2012 07:36:40 +0900
Subject: [GIT PULL] Samsung devel-2 for v3.6
In-Reply-To: <201207212146.04865.arnd@arndb.de>
References: <194f01cd65fe$7c865790$759306b0$%kim@samsung.com>
 <201207212146.04865.arnd@arndb.de>
Message-ID: <1c6101cd685a$76951700$63bf4500$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd Bergmann wrote:
> 
> On Thursday 19 July 2012, Kukjin Kim wrote:
> > Please pull it from:
> >   git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git
> next/devel-samsung-2
> >
> > The updating cpufreq for 1.7GHz of exynos5250 has been included in
> samsung tree because Rafael
> > thought it was more related in samsung platform and I agreed. And it is
> including new
> > exynos_defconfig for DT configuration of exynos4 and exynos5 together.
> The old exynos4_defconfig
> > will be used for non-DT for a while and we will try to move on using
> exynos_defconfig for only DT.
> > And others are adding G2D clock for exynos4x12 Socs.
> >
> 
> I have pulled all three branches. The next/soc branch was getting pretty
> big now,
> and I already started a late/soc branch for late stuff, so I put devel-2
> into
> late/soc. I also took the liberty to rebase it in order to split out the
> defconfig
> change into a separate series that I applied to the defconfig branch.
> 
Yeah, ok. If any defconfig changes, I'll split them out into a topic branch
next time.

> Please confirm that this is ok. If the rebasing cases problems, I can undo
> that
> and take all of devel-2 into late/soc.
> 
Looks good to me, please keep going on.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
