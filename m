From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 04 Jan 2012 10:36:45 +0000
Subject: [PATCH 1/2] mach-sa1100: fix sched_clock breakage
In-Reply-To: <1325672503-16690-1-git-send-email-linus.walleij@linaro.org>
References: <1325672503-16690-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <4F042BBD.4060206@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/01/12 10:21, Linus Walleij wrote:
> Fixed up a simple typo in the runtime sched_clock conversion
> so we compile again.
> 
> Cc: Kristoffer Ericson <kristoffer.ericson@gmail.com>
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Thanks Linus for fixing this.

Acked-by: Marc Zyngier <marc.zyngier@arm.com>

	M.
-- 
Jazz is not dead. It just smells funny...
