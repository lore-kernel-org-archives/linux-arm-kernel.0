From: khilman@ti.com (Kevin Hilman)
Date: Tue, 06 Sep 2011 17:08:36 -0700
Subject: [PATCH v6 23/25] gpio/omap: enable irq at the end of all
	configuration in restore
In-Reply-To: <1314798161-19523-24-git-send-email-tarun.kanti@ti.com> (Tarun
	Kanti DebBarma's message of "Wed, 31 Aug 2011 19:12:39 +0530")
References: <1314798161-19523-1-git-send-email-tarun.kanti@ti.com>
	<1314798161-19523-24-git-send-email-tarun.kanti@ti.com>
Message-ID: <87hb4puscb.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tarun Kanti DebBarma <tarun.kanti@ti.com> writes:

> From: Nishanth Menon <nm@ti.com>
>
> Setup the interrupt enable registers only after we have configured the
> required edge and required configurations, not before, to prevent
> spurious events as part of restore routine.
>
> Signed-off-by: Nishanth Menon <nm@ti.com>
> Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
> Reviewed-by: Santosh Shilimkar <santosh.shilimkar@ti.com>

Good catch Nishanth.

Kevin
