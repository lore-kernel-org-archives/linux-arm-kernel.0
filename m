From: jason@lakedaemon.net (Jason Cooper)
Date: Sat, 24 Nov 2012 00:17:33 -0500
Subject: [GIT PULL 1/5] ARM: orion: fixes for *v3.7*
In-Reply-To: <pull-1353733874-990435>
References: <pull-1353733874-990435>
Message-ID: <20121124051733.GP15800@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd, Olof,

Sorry, automation got the best of me.  These fixes are for v3.7, if
possible.  Only error was in the subject line.  All else is correct.

thx,

Jason.

On Sat, Nov 24, 2012 at 05:11:04AM +0000, Jason Cooper wrote:
> The following changes since commit f4a75d2eb7b1e2206094b901be09adb31ba63681:
> 
>   Linux 3.7-rc6 (2012-11-16 17:42:40 -0800)
> 
> are available in the git repository at:
> 
>   git://git.infradead.org/users/jcooper/linux.git tags/orion_fixes_for_3.7
> 
> for you to fetch changes up to 1dc831bf53fddcc6443f74a39e72db5bcea4f15d:
> 
>   ARM: Kirkwood: Update PCI-E fixup (2012-11-21 18:30:08 +0000)
> 
> ----------------------------------------------------------------
> orion fixes for v3.7
> 
>  - dove irq fix
>  - kirkwood pcie fix
> 
> ----------------------------------------------------------------
> Jason Gunthorpe (1):
>       ARM: Kirkwood: Update PCI-E fixup
> 
> Russell King - ARM Linux (2):
>       Dove: Attempt to fix PMU/RTC interrupts
>       Dove: Fix irq_to_pmu()
> 
>  arch/arm/Kconfig                     |  1 +
>  arch/arm/mach-dove/include/mach/pm.h |  2 +-
>  arch/arm/mach-dove/irq.c             | 14 +++++++++++++-
>  arch/arm/mach-kirkwood/pcie.c        | 11 ++++++++---
>  4 files changed, 23 insertions(+), 5 deletions(-)
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
