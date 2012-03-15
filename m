From: nsekhar@ti.com (Nori, Sekhar)
Date: Thu, 15 Mar 2012 18:01:48 +0000
Subject: [GIT PULL] DaVinci fixes for v3.3
In-Reply-To: <201203151552.09922.arnd@arndb.de>
References: <DF0F476B391FA8409C78302C7BA518B6317F5E48@DBDE01.ent.ti.com>
 <201203151552.09922.arnd@arndb.de>
Message-ID: <DF0F476B391FA8409C78302C7BA518B6317F9B4C@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

On Thu, Mar 15, 2012 at 21:22:09, Arnd Bergmann wrote:
> On Wednesday 14 March 2012, Nori, Sekhar wrote:
> > Hi Arnd, Olof,
> > 
> > Can you please pull the following DaVinci fixes for v3.3.
> > They fix a build and section mismatch warning.
> > 
> > Thanks,
> > Sekhar
> > 
> > The following changes since commit fde7d9049e55ab85a390be7f415d74c9f62dd0f9:
> >   Linus Torvalds (1):
> >         Linux 3.3-rc7
> > 
> > are available in the git repository at:
> > 
> >   git://gitorious.org/linux-davinci/linux-davinci.git fixes
> > 
> > Uwe Kleine-K??????nig (2):
> >       ARM: davinci: cpufreq: fix compiler warning
> >       ARM: davinci: DA850: move da850_register_pm to .init.text
> > 
> >  arch/arm/mach-davinci/cpufreq.c |    2 +-
> >  arch/arm/mach-davinci/da850.c   |    2 +-
> >  2 files changed, 2 insertions(+), 2 deletions(-
> > 
> 
> Hi Sekhar,
> 
> I've applied these two to the next/fixes-non-critical branch for v3.4,
> not the fixes branch for v3.3 because they both look like they have
> no impact on production systems other than the build warnings.
> 
> If I missed something and one or both patches are indeed required for 3.3,
> please let me know.

That's right, they will not have impact on production systems and are
not v3.3 regressions either. Queuing for v3.4 is the right choice.

Thanks,
Sekhar
