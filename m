From: khilman@ti.com (Kevin Hilman)
Date: Tue, 21 Feb 2012 11:10:30 -0800
Subject: [PATCH 0/2] Two trivial omap/serial patches
In-Reply-To: <20120219022841.8254.86264.stgit@notabene.brown> (NeilBrown's
 message of "Sun, 19 Feb 2012 13:29:31 +1100")
References: <20120219022841.8254.86264.stgit@notabene.brown>
Message-ID: <87boos57fd.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

NeilBrown <neilb@suse.de> writes:

> Just a couple of small clean-ups following the recent major changes.

Thanks Neil.

I'll queue these as cleanups for v3.4 since I dont' think they're v3.3
material at this point of the cycle.

I'll also update the changelogs to follow the practice of adding the
shortlog in parens after the commit ID.

Kevin


>
> Thanks,
> NeilBrown
>
> ---
>
> NeilBrown (2):
>       ARM: OMAP2: remove some orphan function declarations.
>       ARM: OMAP2+: UART: remove unused fields in omap_uart_state.
>
>
>  arch/arm/mach-omap2/pm.h                 |    1 -
>  arch/arm/mach-omap2/serial.c             |    4 ----
>  arch/arm/plat-omap/include/plat/serial.h |    1 -
>  3 files changed, 0 insertions(+), 6 deletions(-)
