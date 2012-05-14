From: magnus.damm@gmail.com (Magnus Damm)
Date: Tue, 15 May 2012 06:11:18 +0900
Subject: [PATCH] Removal of last remaining useless system.h includes
In-Reply-To: <20120514114503.GC10453@n2100.arm.linux.org.uk>
References: <20120514114503.GC10453@n2100.arm.linux.org.uk>
Message-ID: <CANqRtoTNuR+FreZd=wAZpK=_6K=+S0miknp1ZurPTgPU1-e5sA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 14, 2012 at 8:45 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> mach/system.h is no longer included by anything that matters. ?Most of
> the includes have already gone, and we're left with just four platforms
> which still have them (for various reasons.) ?Let's remove them as
> they're now unused.
>
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> ---
> This is more a reminder for those maintainers who still haven't responded
> to the work from about five months ago reworking the ARM restart support,
> and who need to do some work to get restart support working again for
> their platforms.

Yes, indeed. It's still on my TODO. Thanks for the reminder!

> ?arch/arm/mach-shmobile/include/mach/system.h | ? 11 -----------

Acked-by: Magnus Damm <damm@opensource.se>
