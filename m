From: kgene.kim@samsung.com (Kukjin Kim)
Date: Fri, 30 May 2014 10:45:07 +0900
Subject: [GIT PULL 3rd 2/3] Samsung Exynos SoC updates for 3.16
In-Reply-To: <20140529194002.GG18481@quad.lixom.net>
References: <035701cf7897$6fb5e460$4f21ad20$@samsung.com>
 <20140529194002.GG18481@quad.lixom.net>
Message-ID: <060a01cf7ba8$c9614130$5c23c390$@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Olof Johansson wrote:
> 
> On Mon, May 26, 2014 at 01:03:22PM +0900, Kukjin Kim wrote:
> > The following changes since commit be1f7c8d7e2bc8b8c76846aa6f276e8d2ef8975a:
> >
> >   cpufreq: exynos: Fix the compile error (2014-05-26 04:05:01 +0900)
> >
> > are available in the git repository at:
> >
> >   http://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git
> > tags/exynos-soc
> >
> > for you to fetch changes up to 455ae9aba2f05e77eaf1073b78e887b06f93a4fd:
> >
> >   ARM: dts: Add device tree sources for exynos3250 (2014-05-26 05:32:02
> > +0900)
> >
> > ----------------------------------------------------------------
> > Exynos new SoCs support for v3.16
> >
> > - add support for exynos5260 SoC and exynos5260-xyref5260 board
> > - add support for exynos5800 SoC and exynos5800-peach-pi board
> > - add support for exynos3250 SoC
> >
> > Note that this branch is on top of tags/samsung-cleanup.
> 
> This branch mixes contents from what should be two branches: One quite short
> one that just contains the code/Kconfig changes for the new SoCs. And the rest
> (DTS/DTSI additions) should go in a DT branch.
> 
Oh, OK. I will re-sort them out.

> Please respin as two separate branches. This will include respinning the
> multiplatform branches too, etc, unfortunately. Please post fresh pull requests
> for any respun/rebased branch.
> 
OK. I will do it tonight in my time.

Thanks for your pulling others ;-)

- Kukjin
