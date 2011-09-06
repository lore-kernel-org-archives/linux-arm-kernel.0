From: khilman@ti.com (Kevin Hilman)
Date: Tue, 06 Sep 2011 16:57:37 -0700
Subject: [PATCH v6 21/25] gpio/omap: remove omap_gpio_save_context overhead
In-Reply-To: <1314798161-19523-22-git-send-email-tarun.kanti@ti.com> (Tarun
	Kanti DebBarma's message of "Wed, 31 Aug 2011 19:12:37 +0530")
References: <1314798161-19523-1-git-send-email-tarun.kanti@ti.com>
	<1314798161-19523-22-git-send-email-tarun.kanti@ti.com>
Message-ID: <87obyxw7f2.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tarun Kanti DebBarma <tarun.kanti@ti.com> writes:

> Context is now saved dynamically in respective functions whenever and
> whichever registers are modified. This avoid overhead of saving all
> registers context in the runtime callback.

Nice!

s/runtime callback/runtime suspend callback/

> Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
> Reviewed-by: Santosh Shilimkar <santosh.shilimkar@ti.com>

Kevin
