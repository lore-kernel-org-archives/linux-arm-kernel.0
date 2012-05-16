From: shawn.guo@freescale.com (Shawn Guo)
Date: Wed, 16 May 2012 14:01:16 +0800
Subject: Pre-merge window status of the arm-soc tree
In-Reply-To: <CAOesGMjxNs2X9F7vus5z_69wqrZuMc2mMXh1CC0415JNcojHDg@mail.gmail.com>
References: <CAOesGMjxNs2X9F7vus5z_69wqrZuMc2mMXh1CC0415JNcojHDg@mail.gmail.com>
Message-ID: <20120516060115.GC21517@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof,

On Tue, May 15, 2012 at 10:09:18PM -0700, Olof Johansson wrote:
> The list of arm-soc topic branches to date are:
> 
> depends/clk/next Common clock infrastructure branch from Mike Turquette
> next/maintainers Updates to MAINTAINERS file
> next/cleanup     General cleanup patches
> next/fixes       Fixes (and a few cleanups) that were not urgent enough for 3.4
> next/dt          Device tree source and support changes
> next/soc         New SoC support, or soc platform development
> next/pinctrl     Changes enabling the new pinctrl subsystem on platforms
> next/pm          power management and clock/reset changes
> next/boards      board changes
> next/defconfig   defconfig updates
> next/drivers     drivers or SoC driver configuration updates
> next/cleanup2    cleanups having dependencies on some of the above branches
> next/clock       patches moving platforms to common clock infrastructure
> next/dt2         device tree updates with dependencies on above branches
> next/soc2        New SoC or SoC driver support depending on above branches
> next/stmp-dev    library infrastructure for stmp-style device register
> layouts and patches using those
> staging/cleanup  late_initcall cleanups (to be moved to a next/* branch)
> 
I think next/stmp-dev should be sorted before next/dt2, since next/dt2
contains mxs/dt which depends on next/stmp-dev.

-- 
Regards,
Shawn
