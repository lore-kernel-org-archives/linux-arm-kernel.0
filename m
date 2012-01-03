From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 03 Jan 2012 10:02:10 +0000
Subject: [PATCH] clocksource/ux500-prcmu: fix sched_clock breakage
In-Reply-To: <1325510583-4487-1-git-send-email-linus.walleij@stericsson.com>
References: <1325510583-4487-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <4F02D222.4010405@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/01/12 13:23, Linus Walleij wrote:
> commit 2f0778afac79bd8d226225556858a636931eeabc adding
> runtime-selectable sched_clock() forgot to patch this
> driver down in drivers/clocksource, this patch fixes
> the problem.
> 
> Reported-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Signed-off-by: Linus Walleij <linus.walleij@stericsson.com>

Acked-by: Marc Zyngier <marc.zyngier@arm.com>

	M.
-- 
Jazz is not dead. It just smells funny...
