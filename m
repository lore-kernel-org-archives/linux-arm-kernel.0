From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 19 Apr 2013 15:45:30 +0100
Subject: [PATCH 1/2] clocksource: arm_arch_timer: unify sched_clock init
In-Reply-To: <1366313410-16692-1-git-send-email-robherring2@gmail.com>
References: <1366313410-16692-1-git-send-email-robherring2@gmail.com>
Message-ID: <20130419144529.GB4855@localhost.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 18, 2013 at 08:30:09PM +0100, Rob Herring wrote:
> From: Rob Herring <rob.herring@calxeda.com>
> 
> In preparation to fix initial time and suspend/resume handling, unify
> the sched_clock init and implementation for arch timer on arm and arm64.
> 
> Signed-off-by: Rob Herring <rob.herring@calxeda.com>
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: John Stultz <john.stultz@linaro.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Stephen Boyd <sboyd@codeaurora.org>

For arm64:

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
