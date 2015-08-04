From: kgene@kernel.org (Kukjin Kim)
Date: Tue, 04 Aug 2015 16:53:37 +0900
Subject: [GIT PULL 1/5] Samsung non-critical-fixes for v4.3
In-Reply-To: <55C06C2D.2010804@samsung.com>
References: <55C06995.2030600@kernel.org> <55C06C2D.2010804@samsung.com>
Message-ID: <052201d0ce8a$aba37790$02ea66b0$@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Krzysztof Kozlowski wrote:
> 
> On 04.08.2015 16:28, Kukjin Kim wrote:
> > Hi Arnd, Olof, Kevin,
> >
> > Here is Samsung non-critical-fixes for v4.3.
> > Please pull.
> >
> > Thanks,
> > Kukjin
> >
> > The following changes since commit d770e558e21961ad6cfdf0ff7df0eb5d7d4f0754:
> >
> >   Linux 4.2-rc1 (2015-07-05 11:01:52 -0700)
> >
> > are available in the git repository at:
> >
> >   git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git
> > tags/samsung-non-critical-1
> >
> > for you to fetch changes up to 2cc6b813579415c4f627b08a043079bdc5b87a33:
> >
> >   ARM: EXYNOS: Use IOMEM_ERR_PTR when function returns iomem (2015-07-21
> > 13:19:06 +0900)
> >
> > ----------------------------------------------------------------
> > Samsung non-critical fixes for v4.3
> >
> > - fix sparse warning for returning iomem
> > - fix clock-frequency of display timing0 for exynos3250-rinato
> 
Hi,

> One more set, which we agreed for pushing to v4.2, is missing:
> 1. cpufreq: exynos: Fix for memory leak in case SOC name does not match

As you can see in ml, I've sent it to Rafael because it would be handled in
cpufreq tree not samsung tree/arm-soc tree.

> 2. video: fbdev: s3c-fb: Constify platform_device_id (this can actually

Same as above, this would be handled in fb tree? Can you please send it?

- Kukjin
