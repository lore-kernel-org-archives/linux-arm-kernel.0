From: kgene.kim@samsung.com (Kukjin Kim)
Date: Sat, 04 Jan 2014 11:20:58 +0900
Subject: [GIT PULL 2nd 2/5] Samsung cleanup for v3.14
In-Reply-To: <20131228231354.GA22753@quad.lixom.net>
References: <52B5DCA2.6080107@samsung.com>
 <20131228231354.GA22753@quad.lixom.net>
Message-ID: <22f901cf08f3$9b049e40$d10ddac0$@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Olof Johansson wrote:
> 
> On Sun, Dec 22, 2013 at 03:23:30AM +0900, Kukjin Kim wrote:
> > The following changes since commit
> 7c394e7be4d267c02eaaac8fa197a7c1b023c99b:
> >
> >   ARM: EXYNOS: Constify clksrc immutable register restore tables
> > (2013-12-12 07:09:33 +0900)
> >
> > are available in the git repository at:
> >
> 
> > git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git
> > tags/samsung-cleanup-2
> >
> > for you to fetch changes up to 1fd3cbccaf47aefbe3bfb026d310cd2f5d0685c6:
> >
> >   ARM: EXYNOS: Kill exynos_pm_late_initcall() (2013-12-21 06:40:44
+0900)
> >
> > ----------------------------------------------------------------
> > Samsung cleanup 2nd for v3.14
> > - remove <mach/regs-clock.h> for exynos
> > - remove <mach/regs-irq.h> for exynos
> > - local <mach/regs-pmu.h> into mach-exynos
> > - select PM_GENERIC_DOMAINS for ARCH_EXYNOS4
> >   instead of each SOC_EXYNOS4XXX in Kconfig
> > - call pm_genpd_poweroff_unused() instead of via
> >   exynos_pm_late_initcall() because no need to
> >   handle whether CONFIG_PM_GENERIC_DOMAINS is enalbed
> 
> Great! Merged into next/cleanup. See a separate comment on one of the
> patches
> when they were posted regarding bisectability though.
> 
Sure, thanks.

Happy new year ;-)
- Kukjin
