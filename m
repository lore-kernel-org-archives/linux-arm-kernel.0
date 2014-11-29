From: kgene@kernel.org (Kukjin Kim)
Date: Sat, 29 Nov 2014 09:13:02 +0900
Subject: [GIT PULL 4/4] Samsung exynos7 updates for v3.19
In-Reply-To: <201411281335.55663.arnd@arndb.de>
References: <5476CD88.1030406@kernel.org> <201411281335.55663.arnd@arndb.de>
Message-ID: <013701d00b69$3d7761d0$b8662570$@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd Bergmann wrote:
> 
> On Thursday 27 November 2014, Kukjin Kim wrote:
> > Samsung arch/arm64 DT updates for v3.19
> >
> > - to support ARMv8 based exynos7 SoC
> >   : add initial device tree and add pinctrl, PMU, mmc, i2c, rtc,
> >     watchdog, and adc nodes for exynos7 SoC and exynos7 based
> >     espresso board.
> >
> > NOTE that this is including following dependencies
> > : cleanup/dts-subdirs in arm-soc for arm64 vendor support
> > : tags/samsung-driver for samsung serial
> > : for-v3.19/exynos-clk in samsung-clk tree for exynos7 clk
> >
> > One more NOTE, for support exynos7 we need Liviu's "arm64: Create
> > link to include/dt-bindings to enable C preprocessor use" in arm-soc
> > tree and arm64 defconfig update should be handled directly.
> 
> I'm confused by the dependencies. I don't see a "for-v3.19/exynos-clk"
> in arm-soc, you haven't put the clk maintainer on Cc and I see no indication
> that he has this in his tree already, so I'm not pulling this until further
> clarification.
> 
Hi,

Sorry for insufficient description.

Since the exynos7 stuff requires regarding clk stuff for kernel build, I talked
to Mike, Sylwester and Mike suggested pulling the branch into Samsung tree.

http://www.spinics.net/lists/linux-samsung-soc/msg39368.html

If any problems, please let me know.

Thanks,
Kukjin
