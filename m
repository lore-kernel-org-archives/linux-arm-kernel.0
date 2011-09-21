From: tony@atomide.com (Tony Lindgren)
Date: Wed, 21 Sep 2011 07:49:00 -0700
Subject: [PATCH v7 06/26] gpio/omap: make non-wakeup GPIO part of pdata
In-Reply-To: <1315918979-26173-7-git-send-email-tarun.kanti@ti.com>
References: <1315918979-26173-1-git-send-email-tarun.kanti@ti.com>
	<1315918979-26173-7-git-send-email-tarun.kanti@ti.com>
Message-ID: <20110921144900.GR2937@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Tarun Kanti DebBarma <tarun.kanti@ti.com> [110913 05:30]:
> From: Charulatha V <charu@ti.com>
> 
> Non-wakeup GPIOs are available only in OMAP2. Avoid cpu_is checks by making
> non_wakeup_gpios as part of pdata.
> 
> Signed-off-by: Charulatha V <charu@ti.com>
> Reviewed-by: Santosh Shilimkar <santosh.shilimkar@ti.com>

Acked-by: Tony Lindgren <tony@atomide.com>
