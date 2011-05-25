From: khilman@ti.com (Kevin Hilman)
Date: Wed, 25 May 2011 14:41:41 -0700
Subject: [PATCH 05/15] OMAP: GPIO: Make gpio_context part of gpio_bank
	structure
In-Reply-To: <1306247094-25372-6-git-send-email-tarun.kanti@ti.com> (Tarun
	Kanti DebBarma's message of "Tue, 24 May 2011 19:54:44 +0530")
References: <1306247094-25372-1-git-send-email-tarun.kanti@ti.com>
	<1306247094-25372-6-git-send-email-tarun.kanti@ti.com>
Message-ID: <87aaeasbje.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tarun Kanti DebBarma <tarun.kanti@ti.com> writes:

> From: Charulatha V <charu@ti.com>
>
> gpio_context array, which is used to save gpio bank's context,
> is used only for OMAP3 architecture.
>
> Move gpio_context as part of gpio_bank structure so that
> it can be specific to each gpio bank and can be used for
> any OMAP architecture
>
> TODO: extend the gpio save/restore context function for OMAP4
> architecture. This is done in one of the next patches in this
> series
>
> Signed-off-by: Charulatha V <charu@ti.com>

Looks good.

Kevin
