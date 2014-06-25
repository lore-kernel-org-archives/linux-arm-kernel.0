From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 25 Jun 2014 20:49:59 +0200
Subject: [GIT PULL] at91: fixes for 3.16 #1 (ter)
In-Reply-To: <1403713316-28253-1-git-send-email-nicolas.ferre@atmel.com>
References: <1403713316-28253-1-git-send-email-nicolas.ferre@atmel.com>
Message-ID: <4184712.OOQdXC98UK@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 25 June 2014 18:21:56 Nicolas Ferre wrote:
> Arnd, Olof, Kevin,
> 
> An AT91 fixes batch for 3.16 that collects mainly DT fixes in relation
> to the recent move to CCF on a couple of platforms.
> A Kconfig symbol fix in drivers/misc is also included.
> 
> As the previous "fixes" pull-requests will be re-spin for 3.17 and shall be
> ignored, I use the same tag name "at91-fixes".
> 
> Thanks, best regards,
> 
> The following changes since commit 7171511eaec5bf23fb06078f59784a3a0626b38f:
> 
>   Linux 3.16-rc1 (2014-06-15 17:45:28 -1000)
> 
> are available in the git repository at:
> 
>   git://github.com/at91linux/linux-at91.git tags/at91-fixes
> 
> for you to fetch changes up to 971dc9ce106110745f246337f229013589354536:
> 
>   ARM: at91/dt: sam9261: remove slow RC osc (2014-06-25 18:00:17 +0200)
> 
> ----------------------------------------------------------------
> First AT91 fixes batch for 3.16:
> - drivers/misc fix for Kconfig PWM symbol
> - correction of several values in DT after conversion to CCF
> - fix at91sam9261/at91sam9261ek mistake in slow crystal vs. slow RC osc

Pulled and sent out again now. Thanks for following up so quickly.

	Arnd
