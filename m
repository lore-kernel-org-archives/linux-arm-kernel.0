From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 3 Mar 2014 12:53:25 +0800
Subject: [GIT PULL] kconfig clean-up and mach-virt removal for 3.15
In-Reply-To: <201402281855.18941.arnd@arndb.de>
References: <CAL_Jsq+vd6XAgj6FawKX4p8Yx0R308mxMxVfzgtNgcBTecx-kg@mail.gmail.com>
 <201402281723.00308.arnd@arndb.de>
 <201402281855.18941.arnd@arndb.de>
Message-ID: <20140303045320.GA9706@shlinux1.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 28, 2014 at 06:55:18PM +0100, Arnd Bergmann wrote:
> On Friday 28 February 2014, Arnd Bergmann wrote:
> > On Thursday 20 February 2014, Rob Herring wrote:
> > -------------------------------------------
> > > - Remove common kconfig options required by multi-platform builds out
> > > of individual platforms as they are redundant.
> > > - Make SMP, CACHE_L2X0 and GPIO config options user visible on
> > > multi-platform builds as most platforms enable these options and all
> > > platforms can run with them enabled.
> > > - Make multi-platform v6 default to more optimal v6k rather than v6
> > > - Remove the last bit of mach-virt and convert it to just a kconfig
> > > option.
> > 
> > Merged into next/cleanup. Very much appreciated changes!
> 
> Shawn, a quick warning about this: the Kconfig changes apparently
> cause a few conflicts with your tree in linux-next.
> 
> If you want to avoid them, you can merge
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git
> tags/kconfig-cleanup-for-3.15
> 
> into the conflicting branches. I have merged it into arm-soc and
> is a stable branch in next/cleanups.

Ok, will do.  Thanks for the heads-up.

Shawn
