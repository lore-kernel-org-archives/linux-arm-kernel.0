From: kgene.kim@samsung.com (Kukjin Kim)
Date: Tue, 15 May 2012 17:55:38 +0900
Subject: [GIT PULL] Samsung boards update for v3.5
In-Reply-To: <201205142003.27537.arnd@arndb.de>
References: <4FAF0326.8000408@samsung.com> <201205142003.27537.arnd@arndb.de>
Message-ID: <07fb01cd3278$7f918540$7eb48fc0$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd Bergmann wrote:

> 
> On Sunday 13 May 2012, Kukjin Kim wrote:
> > Hi Arnd, Olof,
> >
> > Please pull Samsung boards update for v3.5.
> >    git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git
> > next/board-samsung
> >
> > As there were discussions, some exynos4 boards have been updated because
> > current dt cannot support all features for current board files on exynos4.
> >
> > Note, this should be merged after next/devel-samsung because some
> > platform devices are defined in that.
> >
> > If any problems, please let me know.
> 
> Pulled into next/boards now.
> 
Thanks.

> Since we have not pulled the next/devel-samsung branch yet, and that branch
> depends on the sysmmu branch, the dependencies won't easily get fulfilled.

Hmm...I know...but in this case, I had no choice for avoid mess conflicts between them with keeping separate topic branches.

> A test build of exynos4_defconfig showed that there is at least no build
> time problem.
> 
Yeah, could be. Because current exynos4_defconfig doesn't enable newly added feature such as DRM_EXYNOS which has been included in
next/devel-samsung branch for its platform device.

> What is the dependency you are referring to?
> 
Same above.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
