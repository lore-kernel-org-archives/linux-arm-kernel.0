From: khilman@ti.com (Kevin Hilman)
Date: Wed, 02 May 2012 13:09:58 -0700
Subject: [PATCH-V6 2/3] ARM: OMAP2+: Replace space=>underscore in the name
 field of system timers
In-Reply-To: <1335967014-11937-3-git-send-email-hvaibhav@ti.com> (Vaibhav
 Hiremath's message of "Wed, 2 May 2012 19:26:53 +0530")
References: <1335967014-11937-1-git-send-email-hvaibhav@ti.com>
 <1335967014-11937-3-git-send-email-hvaibhav@ti.com>
Message-ID: <87r4v2fip5.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Vaibhav Hiremath <hvaibhav@ti.com> writes:

> Depending on the bootloader, passing command-line arguments
> with spaces may have issues. Some bootloaders doesn't seem
> to pass along the quotes, passing only 'gp' part of the string,
> which leads to wrong clocksource override configuration.

For clarity, it would help to specify which command-line options this
affects

> So this patch changes "gp timer" => "gp_timer", for clockevent,
> clocksource and timer irq_handler.
>
> Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
> Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Cc: Benoit Cousson <b-cousson@ti.com>
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Paul Walmsley <paul@pwsan.com>
> Cc: Kevin Hilman <khilman@ti.com>

With the change above,

Acked-by: Kevin Hilman <khilman@ti.com>
