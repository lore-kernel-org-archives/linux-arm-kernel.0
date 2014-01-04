From: kgene.kim@samsung.com (Kukjin Kim)
Date: Sat, 04 Jan 2014 11:17:09 +0900
Subject: [GIT PULL 2nd 5/5] Samsung SoC update for v3.14
In-Reply-To: <20131228231735.GC22753@quad.lixom.net>
References: <52B5DCBD.5020202@samsung.com>
 <20131228231735.GC22753@quad.lixom.net>
Message-ID: <22f701cf08f3$12670410$37350c30$@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Olof Johansson wrote:
> 
> On Sun, Dec 22, 2013 at 03:23:57AM +0900, Kukjin Kim wrote:
> > The following changes since commit
> 538cfbb4c40ab59688236484138133b8e3e89220:
> >
> >   ARM: dts: Add initial support for Arndale Octa board (2013-12-16
> > 05:05:43 +0900)
> >
> > are available in the git repository at:
> >
> 
> > git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git
> > tags/samsung-soc-2
> >
> > for you to fetch changes up to 7a28f198735d040f4d318511827d913d4b53f355:
> >
> >   ARM: dts: add board dts file for EXYNOS4412 based TINY4412 board
> > (2013-12-19 05:34:26 +0900)
> >
> > ----------------------------------------------------------------
> > Samsung SoC 2nd update for v3.14
> > - add exynos4412-tiny4412 board dt
> >   for FriendlyARM's TINY4412 board
> >
> > ----------------------------------------------------------------
> > Alex Ling (1):
> >       ARM: dts: add board dts file for EXYNOS4412 based TINY4412 board
> >
> >  arch/arm/boot/dts/Makefile                |  1 +
> >  arch/arm/boot/dts/exynos4412-tiny4412.dts | 93
> > +++++++++++++++++++++++++++++++
> >  2 files changed, 94 insertions(+)
> >  create mode 100644 arch/arm/boot/dts/exynos4412-tiny4412.dts
> 
> Hi,
> 
> This is really just a DT patch, and given that I didn't take the base
> patch it
> makes sense to take this in a DT branch instead. Please resend on top of
> dt-2.
> 
Olof, you mean adding new DT is OK?

Sounds good, let me send a new pull-request for exynos4412-tiny4412 and
exynos5420-arndale-octa tonight, I replied with different opinion on other
Sachin's email though ;-)

Sachin, you don't need to concern about that :-)

Thanks,
Kukjin
