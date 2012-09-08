From: santosh.shilimkar@ti.com (Shilimkar, Santosh)
Date: Sat, 8 Sep 2012 13:58:49 +0530
Subject: [PATCH v3 28/31] arm64: Generic timers support
In-Reply-To: <1347035226-18649-29-git-send-email-catalin.marinas@arm.com>
References: <1347035226-18649-1-git-send-email-catalin.marinas@arm.com>
 <1347035226-18649-29-git-send-email-catalin.marinas@arm.com>
Message-ID: <CAMQu2gyLihPnujff6Nq3wzRaX3n+je+4fVfUE_OPVsb_dO14FQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 7, 2012 at 9:57 PM, Catalin Marinas <catalin.marinas@arm.com> wrote:
> From: Marc Zyngier <marc.zyngier@arm.com>
>
> This patch adds support for the ARM generic timers with A64 instructions
> for accessing the timer registers. It uses the physical counter as the
> clock source and the virtual counter as sched_clock.
>
> The timer frequency can be specified via DT or read from the CNTFRQ_EL0
> register. The physical counter is also accessible from user space
> allowing fast gettimeofday() implementation.
>
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> Signed-off-by: Will Deacon <will.deacon@arm.com>
> Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
> Acked-by: Tony Lindgren <tony@atomide.com>
> ---
Thanks for C3STOP update.
Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
