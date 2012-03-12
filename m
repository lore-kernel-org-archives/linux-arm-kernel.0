From: khilman@ti.com (Kevin Hilman)
Date: Mon, 12 Mar 2012 11:54:32 -0700
Subject: [PATCH v3 00/13] gpio/omap: Some more driver cleanup and fixes
In-Reply-To: <1331118963-26364-1-git-send-email-tarun.kanti@ti.com> (Tarun
 Kanti DebBarma's message of "Wed, 7 Mar 2012 16:45:50 +0530")
References: <1331118963-26364-1-git-send-email-tarun.kanti@ti.com>
Message-ID: <878vj5y7iv.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tarun Kanti DebBarma <tarun.kanti@ti.com> writes:

> The cleanup is mostly getting rid of redundant fields in struct gpio_bank{}
> as we already have them as part of bank->context now. Also, remove un-used
> variable from gpio_irq_handler.
>
> The fixes include correction of _set_gpio_irqenable() implementation,
> missing wakeup_en register update in set_gpio_wakeup(), type mismatch
> of gpio trigger parameter in set_gpio_trigger(), incorrect dataout
> register update in set_gpio_dataout_() and few corrections in context
> save logic.
>
> It is baselined on top of Kevin's following series:
> gpio/omap: cleanup and runtime PM conversion for v3.4
> git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-omap-pm.git for_3.4/gpio/runtime-pm-cleanup
>
> Series is available here for reference:
> git://gitorious.org/~tarunkanti/omap-sw-develoment/tarunkantis-linux-omap-dev for_3.4/gpio_further_cleanup_fixes

This branch doesn't exist.

Kevin
