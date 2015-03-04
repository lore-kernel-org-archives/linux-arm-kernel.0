From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 04 Mar 2015 21:15:25 +0100
Subject: [GIT PULL] at91: fixes for 4.0 #1
In-Reply-To: <1425466305-25150-1-git-send-email-nicolas.ferre@atmel.com>
References: <1425466305-25150-1-git-send-email-nicolas.ferre@atmel.com>
Message-ID: <5791968.WNZjnOPoKI@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 04 March 2015 11:51:45 Nicolas Ferre wrote:
> Arnd, Olof, Kevin,
> 
> Here is the first batch of fixes for 4.0. Several topics covered like PM, DT or
> defconfig. The watchdog option removal is the most important one.
> 
> Thanks, best regards,
> 
> The following changes since commit c517d838eb7d07bbe9507871fab3931deccff539:
> 
>   Linux 4.0-rc1 (2015-02-22 18:21:14 -0800)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/nferre/linux-at91.git tags/at91-fixes
> 
> for you to fetch changes up to 2141102e045e622cac176891cb66c5bf08e439f5:
> 
>   ARM: at91/dt: keep watchdog running in idle mode (2015-03-04 11:20:52 +0100)
> 
> ----------------------------------------------------------------
> First fixes batch for AT91 on 4.0:
> - PM slowclock fixes for DDR and timeouts
> - fix some DT entries
> - little defconfig updates
> - the removal of a harmful watchdog option + its detailed documentation

Pulled into fixes, thanks!

	Arnd
