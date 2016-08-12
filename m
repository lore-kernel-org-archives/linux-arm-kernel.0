From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 12 Aug 2016 18:06:00 +0100
Subject: [PATCH RESEND] MAINTAINERS: add ARM ARCHITECTED TIMER entry
In-Reply-To: <1470737036-2082-1-git-send-email-mark.rutland@arm.com>
References: <1470737036-2082-1-git-send-email-mark.rutland@arm.com>
Message-ID: <20160812170600.GJ12939@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 09, 2016 at 11:03:56AM +0100, Mark Rutland wrote:
> The ARM architected timer driver falls under the drivers/clocksource/
> catch-all in MAINTAINERS, and get_maintainers.pl doesn't suggest a
> number of people who should be Cc'd.
> 
> The ARM architected timer is a core component of ARMv7+VE and ARMv8, and
> is critical to the correct operation of both architecture ports (and
> their respective KVM code), and patches to it should have review by
> knowledgeable interested parties.
> 
> This patch adds a MAINTAINERS entry for the driver and its low-level
> arch components, such that get_maintainer.pl will always include
> relevant interested parties for modifications to the driver. For the
> timebeing, this means myself and Marc Zyngier.
> 
> Acked-by: Marc Zyngier <marc.zyngier@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: linux-kernel at vger.kernel.org
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>

I guess this could go in via arm-soc?

-- 
Catalin
