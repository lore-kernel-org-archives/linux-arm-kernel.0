From: olof@lixom.net (Olof Johansson)
Date: Tue, 22 Dec 2015 13:24:51 -0800
Subject: [GIT PULL] few minor omap fixes against v4.4-rc6
In-Reply-To: <20151221205418.GD2793@atomide.com>
References: <20151221205418.GD2793@atomide.com>
Message-ID: <20151222212451.GG30172@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 21, 2015 at 12:54:19PM -0800, Tony Lindgren wrote:
> The following changes since commit 14054fb1da099fd89208b8b319a00e0b902c7645:
> 
>   ARM: dts: am4372: fix clock source for arm twd and global timers (2015-12-09 16:46:25 -0800)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v4.4/fixes-rc6
> 
> for you to fetch changes up to 0b4d6972d7b052b23d33ff9bdbb52958664fbb26:
> 
>   ARM: dts: Fix UART wakeirq for omap4 duovero parlor (2015-12-18 16:43:22 -0800)
> 
> ----------------------------------------------------------------
> Few fixes for omaps to allow am437x only builds to boot properly with
> CPU_IDLE and ARM TWD timer. This is probably a common configuration setup
> for people making products with these SoCs so let's make sure it works.
> 
> Also a wakeirq fix for duovero parlor making my life a bit easier as that
> allows me to run basic PM regression tests on it.
> 
> It would be nice to have these in v4.4, but if it gets too late for that
> because of the holidays, it is not super critical if these get merged for
> v4.5.
> 

Merged into fixes for v4.4.


Thanks,

-Olof
