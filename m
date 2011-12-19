From: tony@atomide.com (Tony Lindgren)
Date: Mon, 19 Dec 2011 12:23:54 -0800
Subject: [GIT PULL] Non critical fixes for v3.3 merge window, part2
In-Reply-To: <20111219194546.GP6464@atomide.com>
References: <20111219194546.GP6464@atomide.com>
Message-ID: <20111219202354.GA17267@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Resending with mailing lists in Cc.

* Tony Lindgren <tony@atomide.com> [111219 11:45]:
> Hi Arnd & Olof,
> 
> Please pull few non-critical fixes for v3.3 merge window from:
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap fixes-non-critical-part2
> 
> These will be needed for some omap hwmod and ehci changes I'll
> post pull requests for after this. Note that this is based on
> the earlier pull request for fixes, so those two fixes will also
> get pulled in if they don't make it to the -rc cycle.
> 
> Regards,
> 
> Tony
> 
> 
> The following changes since commit 4a4de1d9b47156525ceb46c7faf6ae4042d90aa7:
>   Tony Lindgren (1):
>         Merge branch 'hwmod_data_fixes_3.2rc' of git://git.pwsan.com/linux-2.6 into fixes-hwmod
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap fixes-non-critical-part2
> 
> Benoit Cousson (1):
>       ARM: OMAP4: hwmod: Don't wait for the idle status if modulemode is not supported
> 
> Paul Walmsley (1):
>       ARM: OMAP: AM3517/3505: fix crash on boot due to incorrect voltagedomain data
> 
> Santosh Shilimkar (1):
>       ARM: OMAP4: clock: Add CPU local timer clock node
> 
>  arch/arm/mach-omap2/clock44xx_data.c          |    9 ++
>  arch/arm/mach-omap2/omap_hwmod.c              |   98 ++++++++++++------------
>  arch/arm/mach-omap2/voltagedomains3xxx_data.c |   40 +++++++++--
>  3 files changed, 92 insertions(+), 55 deletions(-)
