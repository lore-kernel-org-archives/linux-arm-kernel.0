From: khilman@ti.com (Kevin Hilman)
Date: Mon, 23 Apr 2012 10:48:44 -0700
Subject: [PATCH v2 3/4] ARM: OMAP2+: dmtimer: cleanup iclk usage
In-Reply-To: <1334925563-20768-4-git-send-email-tarun.kanti@ti.com> (Tarun
 Kanti DebBarma's message of "Fri, 20 Apr 2012 18:09:22 +0530")
References: <1334925563-20768-1-git-send-email-tarun.kanti@ti.com>
 <1334925563-20768-4-git-send-email-tarun.kanti@ti.com>
Message-ID: <87obqijq4j.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tarun Kanti DebBarma <tarun.kanti@ti.com> writes:

> We do not use iclk anywhere in the dmtimer driver and so removing it.
> Hence removing the timer iclk entries from OMAP4 clkdev table as well.

What about the OMAP2/3 clkdev tables?  Can't those be removed as well?

Comment applies to PATCH 4/4 also.

Kevin
