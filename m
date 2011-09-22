From: tony@atomide.com (Tony Lindgren)
Date: Wed, 21 Sep 2011 18:00:32 -0700
Subject: [PATCH v16 01/12] OMAP2+: dmtimer: add device names to flck nodes
In-Reply-To: <1316518227-28116-2-git-send-email-tarun.kanti@ti.com>
References: <1316518227-28116-1-git-send-email-tarun.kanti@ti.com>
	<1316518227-28116-2-git-send-email-tarun.kanti@ti.com>
Message-ID: <20110922010031.GR2937@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Tarun Kanti DebBarma <tarun.kanti@ti.com> [110920 03:57]:
> Add device name to OMAP2 dmtimer fclk nodes so that the fclk nodes can be
> retrieved by doing a clk_get with the corresponding device pointers or
> device names.
> 
> Reviewed-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com

I've fixed the missing bracket in the email address     ^^^

Tony
