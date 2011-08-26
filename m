From: santosh.shilimkar@ti.com (Santosh)
Date: Fri, 26 Aug 2011 21:14:21 +0530
Subject: [PATCH v14 REPOST 10/12] OMAP: dmtimer: mark clocksource and
	clockevent timers reserved
In-Reply-To: <1310731501-13078-11-git-send-email-tarun.kanti@ti.com>
References: <1310731501-13078-1-git-send-email-tarun.kanti@ti.com>
	<1310731501-13078-11-git-send-email-tarun.kanti@ti.com>
Message-ID: <4E57BF55.7020503@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 15 July 2011 05:34 PM, Tarun Kanti DebBarma wrote:
> In driver probe use sys_timer_reserved to identify which all timers
> have already been used for clocksource and clockevent. Mark all those
> timers as reserved so that no one else can use them.
>
> Signed-off-by: Tarun Kanti DebBarma<tarun.kanti@ti.com>
> ---
Looks fine.
Reviewed-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Regards
Santosh
