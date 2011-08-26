From: santosh.shilimkar@ti.com (Santosh)
Date: Fri, 26 Aug 2011 20:51:33 +0530
Subject: [PATCH v14 REPOST 02/12] OMAP4: hwmod data: add dmtimer version
	information
In-Reply-To: <1310731501-13078-3-git-send-email-tarun.kanti@ti.com>
References: <1310731501-13078-1-git-send-email-tarun.kanti@ti.com>
	<1310731501-13078-3-git-send-email-tarun.kanti@ti.com>
Message-ID: <4E57B9FD.7010301@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 15 July 2011 05:34 PM, Tarun Kanti DebBarma wrote:
> OMAP4 has two groups of timers: version 1 timers are 1, 2, 10,
> while the rest of the timers, 3-9, 11 are version 2 timers.
> The version information is required by the driver so that they
> could be handled correctly by it.
>
> Signed-off-by: Tarun Kanti DebBarma<tarun.kanti@ti.com>
> Acked-by: Cousson, Benoit<b-cousson@ti.com>
> Cc: Cousson, Benoit<b-cousson@ti.com>
> ---
Since Benoit has already acked it, you can remove the CC.

Reviewed-by: Santosh Shilimkar <santosh.shilimkar@ti.com>

Regards
Santosh
