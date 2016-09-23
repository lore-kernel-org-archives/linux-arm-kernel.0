From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 23 Sep 2016 15:41:09 +0100
Subject: [PATCH v6 4/4] arm/arm64: arch_timer: Use archdata to indicate
 vdso suitability
In-Reply-To: <1474533318-7796-4-git-send-email-oss@buserror.net>
References: <1474533318-7796-1-git-send-email-oss@buserror.net>
 <1474533318-7796-4-git-send-email-oss@buserror.net>
Message-ID: <57E53F05.9060806@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 22/09/16 09:35, Scott Wood wrote:
> Instead of comparing the name to a magic string, use archdata to
> explicitly communicate whether the arch timer is suitable for
> direct vdso access.
> 
> Signed-off-by: Scott Wood <oss@buserror.net>
> Acked-by: Will Deacon <will.deacon@arm.com>
> ---
>  arch/arm/Kconfig                     |  1 +
>  arch/arm/include/asm/clocksource.h   |  8 ++++++++
>  arch/arm/kernel/vdso.c               |  2 +-
>  arch/arm64/Kconfig                   |  1 +
>  arch/arm64/include/asm/clocksource.h |  8 ++++++++
>  arch/arm64/kernel/vdso.c             |  2 +-
>  drivers/clocksource/arm_arch_timer.c | 11 +++--------
>  7 files changed, 23 insertions(+), 10 deletions(-)
>  create mode 100644 arch/arm/include/asm/clocksource.h
>  create mode 100644 arch/arm64/include/asm/clocksource.h

Acked-by: Marc Zyngier <marc.zyngier@arm.com>

	M.
-- 
Jazz is not dead. It just smells funny...
