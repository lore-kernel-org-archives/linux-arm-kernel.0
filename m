From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 11 Mar 2015 15:34:30 +0100
Subject: [GIT PULL] at91: fixes for 4.0 #2
In-Reply-To: <1425553155-30407-1-git-send-email-nicolas.ferre@atmel.com>
References: <1425553155-30407-1-git-send-email-nicolas.ferre@atmel.com>
Message-ID: <3359075.L2gzEY5Xgg@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 05 March 2015 11:59:15 Nicolas Ferre wrote:
> Another batch of fixes that I have now, so it doesn't make sense to hold them
> more.
> 
> Thanks, best regards,
> 
> The following changes since commit 2141102e045e622cac176891cb66c5bf08e439f5:
> 
>   ARM: at91/dt: keep watchdog running in idle mode (2015-03-04 11:20:52 +0100)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/nferre/linux-at91.git tags/at91-fixes2
> 
> for you to fetch changes up to 5957457a2d96e4c9b2fecd40f29cdb3bb841d75e:
> 
>   ARM: at91/pm: MOR register KEY was missing (2015-03-05 11:43:02 +0100)
> 
> ----------------------------------------------------------------
> Second fixes batch for AT91 on 4.0:
> - little fix for !MMU debug: may also help for randconfig
> - fix of 2 errors in LCD clock definitions
> - in PM code, not writing the key leads to not execute the action
> 
> 

Pulled into fixes, thanks!

	Arnd
