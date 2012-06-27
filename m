From: tony@atomide.com (Tony Lindgren)
Date: Wed, 27 Jun 2012 05:33:55 -0700
Subject: [GIT PULL] OMAP PM: misc. cleanup for v3.6
In-Reply-To: <87d34mdysc.fsf@ti.com>
References: <87d34mdysc.fsf@ti.com>
Message-ID: <20120627123354.GF3483@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Kevin Hilman <khilman@ti.com> [120626 05:53]:
> Tony,
> 
> Please pull the following misc. PM cleanups for v3.6.
> 
> Kevin
> 
> The following changes since commit f8f5701bdaf9134b1f90e5044a82c66324d2073f:
> 
>   Linux 3.5-rc1 (2012-06-02 18:29:26 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-omap-pm.git for_3.6/cleanup/pm
> 
> for you to fetch changes up to b110547e586eb5825bc1d04aa9147bff83b57672:
> 
>   ARM: OMAP2+: OPP: Fix to ensure check of right oppdef after bad one (2012-06-19 15:23:29 -0700)
> 
> ----------------------------------------------------------------
> Daniel Lezcano (1):
>       ARM: OMAP3/4: consolidate cpuidle Makefile
> 
> Mark A. Greer (1):
>       ARM: OMAP3: PM: Only access IVA if one exists
> 
> Nishanth Menon (1):
>       ARM: OMAP2+: OPP: Fix to ensure check of right oppdef after bad one

Thanks I'll pull these into fixes-non-critical as all three patches seem
to fix something.

Regards,

Tony
