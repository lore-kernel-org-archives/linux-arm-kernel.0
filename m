From: khilman@ti.com (Kevin Hilman)
Date: Wed, 25 May 2011 16:01:10 -0700
Subject: [PATCH 11/15] OMAP: GPIO: Remove hardcoded offsets in ctxt
	save/restore
In-Reply-To: <1306247094-25372-12-git-send-email-tarun.kanti@ti.com> (Tarun
	Kanti DebBarma's message of "Tue, 24 May 2011 19:54:50 +0530")
References: <1306247094-25372-1-git-send-email-tarun.kanti@ti.com>
	<1306247094-25372-12-git-send-email-tarun.kanti@ti.com>
Message-ID: <871uzmo05l.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tarun Kanti DebBarma <tarun.kanti@ti.com> writes:

> It is not required to use hard-coded offsets any more in context
> save and restore functions and instead use the generic offsets
> which have been correctly initialized during device registration.
>
> Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
> Signed-off-by: Charulatha V <charu@ti.com>

Looks good.

I suggest you move this and all the other patches that just change to using
regsister offsets earlier in the series.

Kevin
