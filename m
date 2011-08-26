From: santosh.shilimkar@ti.com (Santosh)
Date: Fri, 26 Aug 2011 19:45:22 +0530
Subject: [PATCH v14 REPOST 01/12] OMAP2+: dmtimer: add device names to
	flck nodes
In-Reply-To: <1310731501-13078-2-git-send-email-tarun.kanti@ti.com>
References: <1310731501-13078-1-git-send-email-tarun.kanti@ti.com>
	<1310731501-13078-2-git-send-email-tarun.kanti@ti.com>
Message-ID: <4E57AA7A.6060106@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 15 July 2011 05:34 PM, Tarun Kanti DebBarma wrote:
> Add device name to OMAP2 dmtimer fclk nodes so that the fclk nodes can be
> retrieved by doing a clk_get with the corresponding device pointers or
> device names.
>
> Signed-off-by: Tarun Kanti DebBarma<tarun.kanti@ti.com
> Signed-off-by: Thara Gopinath<thara@ti.com>
> Acked-by: Cousson, Benoit<b-cousson@ti.com>
> ---

Looks good to me.
Reviewed-by: Santosh Shilimkar <santosh.shilimkar@ti.com>

Regards
Santosh
