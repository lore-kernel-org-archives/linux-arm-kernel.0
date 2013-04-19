From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 19 Apr 2013 15:46:01 +0100
Subject: [PATCH 2/2] clocksource: arm_arch_timer: add boot and suspend
 sched_clock offset
In-Reply-To: <1366313410-16692-2-git-send-email-robherring2@gmail.com>
References: <1366313410-16692-1-git-send-email-robherring2@gmail.com>
 <1366313410-16692-2-git-send-email-robherring2@gmail.com>
Message-ID: <20130419144601.GC4855@localhost.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 18, 2013 at 08:30:10PM +0100, Rob Herring wrote:
> From: Rob Herring <rob.herring@calxeda.com>
> 
> Commit 023796b (ARM: arch_timer: use full 64-bit counter for sched_clock)
> fails to ensure sched_clock always starts at time 0 and counting is
> suspended during suspend. arm64 sched_clock support also has the same
> issues. This fixes all architected timer users by maintaining an initial
> offset which is updated on resume.
> 
> Signed-off-by: Rob Herring <rob.herring@calxeda.com>
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: John Stultz <john.stultz@linaro.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Stephen Boyd <sboyd@codeaurora.org>

For arm64:

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
