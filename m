From: tony@atomide.com (Tony Lindgren)
Date: Tue, 13 Nov 2012 14:12:32 -0800
Subject: [GIT PULL] ARM: OMAP: DMTIMER fixes
In-Reply-To: <50A28086.6050500@ti.com>
References: <50A28086.6050500@ti.com>
Message-ID: <20121113221231.GL6801@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Jon Hunter <jon-hunter@ti.com> [121113 09:18]:
> The following changes since commit d308ba50a1234b299a00e63a95e61fdeb2f1a2df:
> 
>   Merge branch 'omap-for-v3.8/cleanup-headers-prepare-multiplatform-v3' into omap-for-v3.8/dt (2012-11-09 14:58:34 -0800)
> 
> are available in the git repository at:
> 
> 
>   git at github.com:jonhunter/linux.git fixes-timer
> 
> for you to fetch changes up to b1538832191d59e29b1077e64cf416a7617b45bc:
> 
>   ARM: OMAP: Remove __omap_dm_timer_set_source function (2012-11-12 16:23:57 -0600)
> 
> ----------------------------------------------------------------
> Several fixes for the OMAP DMTIMER driver including ...
> 1. Adding workaround for OMAP3+ errata i103/i767
> 2. Fixing posted mode support
> 3. Spurious interrupts when using match interrupt
> 4. HWMOD fixes for timers
> 5. Unnecessary restoration of read-only registers
> 6. Adds function for disabling timer interrupts
> 7. Fixing timer1 reset for OMAP1

Thanks pulling into omap-for-v3.8/timer.

Regards,

Tony
Thanks pulled into omap-for-v3.8/timer.
