From: kgene.kim@samsung.com (Kukjin Kim)
Date: Fri, 30 May 2014 10:26:24 +0900
Subject: [GIT PULL 5/5] Samsung Exynos MCPM support for 3.16
In-Reply-To: <CAOesGMj=c3RVQs2=xtWV82nMxjD9w6QNv2Wz4wTi7KrOuHYTig@mail.gmail.com>
References: <014801cf73c8$7d1f9930$775ecb90$@samsung.com>
 <20140522053841.GI32618@quad.lixom.net>
 <CAOesGMj=c3RVQs2=xtWV82nMxjD9w6QNv2Wz4wTi7KrOuHYTig@mail.gmail.com>
Message-ID: <060801cf7ba6$2b815ec0$82841c40$@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Olof Johansson wrote:
> 
> On Wed, May 21, 2014 at 10:38 PM, Olof Johansson <olof@lixom.net> wrote:
> > On Tue, May 20, 2014 at 10:11:54AM +0900, Kukjin Kim wrote:
> >> The following changes since commit d7067f1c5fa0232001502569c6878d22308da268:
> >>
> >>   devicetree: bindings: document SYSRAM binding (2014-05-15 03:30:29 +0900)
> >>
> >> are available in the git repository at:
> >>
> >>   http://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git
> >> tags/exynos-mcpm
> >>
> >> for you to fetch changes up to ccf5511797cd4b48d20a85fa1778f5608eac9fd7:
> >>
> >>   ARM: EXYNOS: Add MCPM call-back functions (2014-05-16 04:26:30 +0900)
> >>
> >> ----------------------------------------------------------------
> >> Exynos MCPM support for v3.16
> >>
> >> - adding MCPM backend support for SMP secondary boot and core switching
> >> on Samsung's Exynos5420.
> >>
> >> Tested on exynos5420-smdk5420 and exynos5420 based chromebook (peach-pit)
> >> using the "/dev/b.L_switcher" user interface. Secondary core boot-up has
> >> also been tested on both the boards.
> >
> > This goes with new SoC enablement as well; we'll merge it after multi-platform.
> 
> Merged now, since multiplatform is going in as well.
> 
> What confused me for a while here was that this branch was based on a
> partial version of the DT branch, but it didn't match any of the

Yeah, I just thought that it would be better if this could be having minimally
the dependent patches.

> branch heads we had merged in. It's not wrong to do so but it's useful
> to get a heads up in the pull request.
> 
OK, I see. I will do as you suggested in future.

Thanks,
Kukjin
