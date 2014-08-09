From: olof@lixom.net (Olof Johansson)
Date: Sat, 9 Aug 2014 08:24:21 -0700
Subject: [GIT PULL] few omap fixes for v3.17 merge window
In-Reply-To: <20140801111600.GB26699@atomide.com>
References: <20140801111600.GB26699@atomide.com>
Message-ID: <20140809152421.GB5053@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 01, 2014 at 04:16:00AM -0700, Tony Lindgren wrote:
> The following changes since commit 3965f5ba0489c01f419216c8909965b9a6a39388:
> 
>   Merge branch 'omap-for-v3.17/mailbox' into omap-for-v3.17/soc (2014-07-23 01:26:02 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v3.17/soc-fixes
> 
> for you to fetch changes up to ae21e6180a03c147514c606b4e649690e0cbd40e:
> 
>   ARM: OMAP3: Fix coding style problems in arch/arm/mach-omap2/control.c (2014-08-01 01:21:14 -0700)
> 
> ----------------------------------------------------------------
> Few fixes for the v3.17 merge window:
> 
> - Fix for DPLL rate rounding
> 
> - Fix for omap3 ES3.1.2 suspend
> 
> - Few coding style fixes
> 
> Note that these are based on earlier omap-for-v3.17/soc.
> No strict dependency to it though, but I already merged in
> the pull request from Paul for the first fix into it and
> these are all SoC related.

Merged to fixes, thanks.

-Olof
