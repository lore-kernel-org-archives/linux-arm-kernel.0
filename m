From: kgene.kim@samsung.com (Kukjin Kim)
Date: Mon, 25 Apr 2011 16:11:32 +0900
Subject: [patch 16/16] arm: Remove sched_clock code
In-Reply-To: <20110423205133.187841399@linutronix.de>
References: <20110423205036.795894921@linutronix.de>
	<20110423205133.187841399@linutronix.de>
Message-ID: <043f01cc0318$06ee4a00$14cade00$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thomas Gleixner wrote:
> 
> All users converted to use the clocksource based sched_clock.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Tested on Samsung stuff...

Tested-by: Kukjin Kim <kgene.kim@samsung.com>

> ---
>  arch/arm/Kconfig                   |   15 ----
>  arch/arm/include/asm/sched_clock.h |  120
----------------------------------
> ---
>  arch/arm/kernel/Makefile           |    1
>  arch/arm/kernel/sched_clock.c      |   74 ----------------------
>  arch/arm/kernel/time.c             |    4 -
>  5 files changed, 214 deletions(-)
> 

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
