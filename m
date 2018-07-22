From: tony@atomide.com (Tony Lindgren)
Date: Sat, 21 Jul 2018 23:40:42 -0700
Subject: [GIT PULL] am654 changes for v4.19 merge window
In-Reply-To: <20180721220722.43avzbs6ulpsem37@localhost>
References: <pull-1532152828-552759@atomide.com>
 <20180721220722.43avzbs6ulpsem37@localhost>
Message-ID: <20180722064041.GM99251@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Olof Johansson <olof@lixom.net> [180721 22:28]:
> On Fri, Jul 20, 2018 at 11:05:16PM -0700, Tony Lindgren wrote:
> > From: "Tony Lindgren" <tony@atomide.com>
> > 
> > The following changes since commit ce397d215ccd07b8ae3f71db689aedb85d56ab40:
> > 
> >   Linux 4.18-rc1 (2018-06-17 08:04:49 +0900)
> > 
> > are available in the Git repository at:
> > 
> >   git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/am654-for-v4.19-signed
> > 
> > for you to fetch changes up to d0a064bec75e20a526c7bc0d626912f2660b6e81:
> > 
> >   arm64: dts: ti: Add support for AM654 EVM base board (2018-07-18 11:48:36 -0700)
> > 
> > ----------------------------------------------------------------
> > TI AM654 support for v4.19 merge window
> > 
> > This branch adds initial support for new Texas Instruments AM654
> > quad core A53 ARMv8 SoC. It's the first device for TI K3 multicore SoC
> > architecture.
> > 
> > Initially only basic devices are configured, support for more devices
> > will follow later on. And many of the internal devices familiar from
> > earlier TI SoCs should work with existing kernel device drivers.
> 
> I squinted a bit and merged this into next/dt. Might have been a bit cleaner to
> split it in a SoC and a DT branch, but either way it's pretty small changes.

OK yeah I could have done a separate branch for Kconfig changes.

> Should the support be enabled in arm64's defconfig?

Yes it should, Nishanth, care to check Linux next once your
patches are merged and send a patch for that?

Regards,

Tony
