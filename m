From: tony@atomide.com (Tony Lindgren)
Date: Tue, 24 May 2011 11:55:03 +0300
Subject: [GIT PULL] OMAP PM cleanups for 2.6.40
In-Reply-To: <87liy15r8b.fsf@ti.com>
References: <87liy15r8b.fsf@ti.com>
Message-ID: <20110524085502.GF30799@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Kevin Hilman <khilman@ti.com> [110520 18:21]:
> Tony,
> 
> Please pull the following OMAP PM related cleanups for 2.6.40.

Pulled into for-next for this merge window.
 
>  arch/arm/mach-omap2/board-3430sdp.c |   19 --
>  arch/arm/mach-omap2/board-rx51.c    |   18 +-
>  arch/arm/mach-omap2/cpuidle34xx.c   |  436 ++++++++++++-----------------------
>  arch/arm/mach-omap2/pm.h            |   17 +-
>  arch/arm/mach-omap2/pm34xx.c        |   14 --
>  5 files changed, 166 insertions(+), 338 deletions(-)

Nice, more negative diffstat :)

Regards,

Tony
