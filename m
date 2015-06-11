From: khilman@kernel.org (Kevin Hilman)
Date: Wed, 10 Jun 2015 17:04:20 -0700
Subject: [GIT PULL] at91: dt for 4.2 #4
In-Reply-To: <1433509218-21690-1-git-send-email-nicolas.ferre@atmel.com>
 (Nicolas Ferre's message of "Fri, 5 Jun 2015 15:00:18 +0200")
References: <1433509218-21690-1-git-send-email-nicolas.ferre@atmel.com>
Message-ID: <7h7frbhzzv.fsf@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Nicolas Ferre <nicolas.ferre@atmel.com> writes:

> Arnd, Olof, Kevin,
>
> Another batch of DT changes for 4.2. The bulk of it is the move to stdout-path
> for our cosonle.
> As usual, the material is based on previous at91-dt3 that you already have.
>
> Thanks, best regards,
>
> The following changes since commit f80737082c210fae8ce15ad5d615da381889d5e9:
>
>   ARM: at91/dt: remove useless usb clock (2015-05-22 11:11:33 +0200)
>
> are available in the git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/nferre/linux-at91.git tags/at91-dt4
>
> for you to fetch changes up to ea25525ce0d195724fead07fe6562fe478a3bf6f:
>
>   ARM: at91/dt: sama5d4ek: mci0 uses slot 0 (2015-06-04 11:49:12 +0200)
>
> ----------------------------------------------------------------
> Fourth batch of DT changes for 4.2:
> - rtc node for at91sam9rl/at91sam9rlek
> - move to stdout-path for console on kizbox and all Atmel's boards
> - Addition of the Acme Systems' Arietta G25
> - two little fixes for Kizbox and sama5d4ek
>
> ----------------------------------------------------------------

Applied to next/dt,

Thanks,

Kevin
