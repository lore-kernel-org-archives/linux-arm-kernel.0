From: khilman@ti.com (Kevin Hilman)
Date: Wed, 25 May 2011 16:00:02 -0700
Subject: [PATCH 10/15] OMAP: GPIO: cleanup prepare/resume idle functions
In-Reply-To: <1306247094-25372-11-git-send-email-tarun.kanti@ti.com> (Tarun
	Kanti DebBarma's message of "Tue, 24 May 2011 19:54:49 +0530")
References: <1306247094-25372-1-git-send-email-tarun.kanti@ti.com>
	<1306247094-25372-11-git-send-email-tarun.kanti@ti.com>
Message-ID: <878vtuo07h.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tarun Kanti DebBarma <tarun.kanti@ti.com> writes:

> By adding level and edge detection register offsets and then initializing them
> correctly according to OMAP versions during device registrations we can now remove
> lot of revision checks in these functions.
>
> Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
> Signed-off-by: Charulatha V <charu@ti.com>

Looks good.

Kevin
