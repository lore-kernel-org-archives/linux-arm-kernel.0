From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 30 Sep 2011 21:56:22 +0200
Subject: [PATCH 0/4] ARM: CSR: cleanup some minor coding-style issues
In-Reply-To: <1316757091-14916-1-git-send-email-Baohua.Song@csr.com>
References: <1316757091-14916-1-git-send-email-Baohua.Song@csr.com>
Message-ID: <201109302156.22487.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 23 September 2011, Barry Song wrote:
> Barry Song (4):
>   ARM: CSR: timer: do not initialise statics to 0 or NULL
>   ARM: CSR: timer: space required before the open parenthesis '('
>   ARM: CSR: prima2: fix trailing whitespace
>   ARM: CSR: clock: Fix indentation
> 
>  arch/arm/mach-prima2/clock.c  |    4 ++--
>  arch/arm/mach-prima2/prima2.c |    2 +-
>  arch/arm/mach-prima2/timer.c  |    4 ++--
>  3 files changed, 5 insertions(+), 5 deletions(-)


Hi Barry,

Sorry for the late reply. This series and the one before all look good
to me, but I fear I'm losing track of the patches.

Can you send me pull requests for each set (fixes, cleanups, other
changes) so I can be sure I get everything? If you have trouble
with git.kernel.org still being down, I can apply the patches
manually and let you double-check them, but that would be more
work for both of us I think.

	Arnd
