From: kgene.kim@samsung.com (Kukjin Kim)
Date: Sat, 04 Jan 2014 11:20:05 +0900
Subject: [PATCH 03/11] ARM: EXYNOS: local regs-pmu.h header file
In-Reply-To: <CAOesGMjJXodfZUSwHWdYgJsTWL4FANxXnP519B0AUiwpEn4bQQ@mail.gmail.com>
References: <116101cefb1e$69ddfe70$3d99fb50$@kernel.org>
 <CAOesGMjJXodfZUSwHWdYgJsTWL4FANxXnP519B0AUiwpEn4bQQ@mail.gmail.com>
Message-ID: <22f801cf08f3$7b259750$7170c5f0$@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Olof Johansson wrote:
> 
> Hi,
> 
Hi,

> 
> On Tue, Dec 17, 2013 at 3:52 AM,  <kgene@kernel.org> wrote:
> > From: Kukjin Kim <kgene.kim@samsung.com>
> >
> > This moves regs-pmu.h file into mach-exynos directory.
> >
> > Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
> > ---
> >  arch/arm/mach-exynos/common.c                      |    3 ++-
> >  arch/arm/mach-exynos/cpuidle.c                     |    2 +-
> >  arch/arm/mach-exynos/hotplug.c                     |    2 +-
> >  arch/arm/mach-exynos/mach-exynos5-dt.c             |    2 +-
> >  arch/arm/mach-exynos/platsmp.c                     |    2 +-
> >  arch/arm/mach-exynos/pm.c                          |    2 +-
> >  arch/arm/mach-exynos/pm_domains.c                  |    3 ++-
> >  arch/arm/mach-exynos/pmu.c                         |    2 +-
> >  arch/arm/mach-exynos/{include/mach => }/regs-pmu.h |    0
> >  9 files changed, 10 insertions(+), 8 deletions(-)
> >  rename arch/arm/mach-exynos/{include/mach => }/regs-pmu.h (100%)
> 
> This looks OK, but when you committed, you did the move of the include
> file in another commit (e44de221d3ddb99387b04cfd49483bcd05daa6fb).
> That means that between that commit and this patch, there's build
> breakage. Please try to avoid that in the future since if something
> needs to be bisected near here it can cause problems.
> 
Yeah, you're right. Sorry and I'll try to avoid that per your suggestion.

Thanks,
Kukjin
