From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 08 Oct 2015 17:27:37 +0200
Subject: [GIT PULL] at91: cleanup for 4.4 #1
In-Reply-To: <20151006152841.GA17947@piout.net>
References: <20151006152841.GA17947@piout.net>
Message-ID: <30261297.PResHp2kVS@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 06 October 2015 17:28:41 Alexandre Belloni wrote:
> A few cross subsystem cleanups to soon be able to get rid of a nasty
> hack in the clock driver. To ease synchronisation, I'm planning to send
> the hack removal to for 4.5.
> 
> The following changes since commit 6ff33f3902c3b1c5d0db6b1e2c70b6d76fba357f:
> 
>   Linux 4.3-rc1 (2015-09-12 16:35:56 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/abelloni/linux.git tags/at91-cleanup-4.4
> 
> for you to fetch changes up to 7d8d05d11473a169ab4d53bc7fc23d1fe3f1959f:
> 
>   misc: atmel_tclib: get and use slow clock (2015-10-06 12:33:14 +0200)
> 
> ----------------------------------------------------------------
> First batch of cleanups for 4.4:
>  - properly get the slow clock from timer-atmel-st, tcb_clksrc and pwm-atmel-tcb
>  - small fix in an error path for tcb_clksrc
> 
> 

Merged into next/drivers, which seems more appropriate than next/cleanup here.

Thanks,

	Arnd
