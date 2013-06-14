From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 14 Jun 2013 10:40:12 +0100
Subject: [PATCH v4] irqchip: Add support for ARMv7-M's NVIC
In-Reply-To: <1371073835-10639-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1371073835-10639-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <20130614094011.GC8108@darko.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 12, 2013 at 10:50:35PM +0100, Uwe Kleine-K??nig wrote:
> This interrupt controller is found on Cortex-M3 and Cortex-M4 machines.
> 
> Support for this controller appeared in Catalin's Cortex tree based on
> 2.6.33 but was nearly completely rewritten.
> 
> Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
> Signed-off-by: Uwe Kleine-K??nig <u.kleine-koenig@pengutronix.de>

Since you pretty much re-wrote my original code, you can drop my
Signed-off-by. Feel free to replace with:

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
