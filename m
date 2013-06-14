From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 14 Jun 2013 16:24:36 +0200
Subject: [PATCH v4] irqchip: Add support for ARMv7-M's NVIC
In-Reply-To: <1371073835-10639-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1371073835-10639-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <201306141624.36978.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 12 June 2013, Uwe Kleine-K?nig wrote:
> This interrupt controller is found on Cortex-M3 and Cortex-M4 machines.
> 
> Support for this controller appeared in Catalin's Cortex tree based on
> 2.6.33 but was nearly completely rewritten.
> 
> Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
> Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>

Wow, I hadn't followed the details of the generic irqchip patches, but
this looks great, almost no code left at all!

Acked-by: Arnd Bergmann <arnd@arndb.de>
