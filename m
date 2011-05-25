From: khilman@ti.com (Kevin Hilman)
Date: Wed, 25 May 2011 14:43:43 -0700
Subject: [PATCH 06/15] OMAP4: GPIO: Save/restore context
In-Reply-To: <1306247094-25372-7-git-send-email-tarun.kanti@ti.com> (Tarun
	Kanti DebBarma's message of "Tue, 24 May 2011 19:54:45 +0530")
References: <1306247094-25372-1-git-send-email-tarun.kanti@ti.com>
	<1306247094-25372-7-git-send-email-tarun.kanti@ti.com>
Message-ID: <8739k2sbg0.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tarun Kanti DebBarma <tarun.kanti@ti.com> writes:

> From: Charulatha V <charu@ti.com>
>
> Modify the omap_gpio_save/restore_context to support OMAP4
> architecture so that the OMAP GPIO driver need not be modified
> when OMAP4 off mode support is available.
>
> Signed-off-by: Charulatha V <charu@ti.com>

I don't think this patch is needed.

PATCH 11/15 removes everything added in this patch when it moves to
using the register offsets.

Kevin
