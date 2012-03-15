From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 15 Mar 2012 13:47:11 +0000
Subject: [PATCH -next] ARM: ux500: fix compilation after local timer rework
In-Reply-To: <1331812046-21062-1-git-send-email-marc.zyngier@arm.com>
References: <1331812046-21062-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <201203151347.11511.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 15 March 2012, Marc Zyngier wrote:
> mach-ux500/timer.c lacked the inclusion of mach/irqs.h, and thus
> failed to compile. Fix it and also remove an unused variable.
> 
> Test compiled only.
> 
> Reported-by: Lee Jones <lee.jones@linaro.org>
> Cc: Arnd Bergman <arnd@arndb.de>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> ---
> Arnd,
> 
> I've pushed this patch to my local_timers-for-arm-soc. If you can pull
> it one more time, that would be great.

Thanks for the quick update, pulled into next/timers now.

	Arnd
