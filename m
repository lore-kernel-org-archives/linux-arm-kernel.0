From: tony@atomide.com (Tony Lindgren)
Date: Wed, 21 Sep 2011 08:05:47 -0700
Subject: [PATCH v7 16/26] gpio/omap: fix bankwidth for OMAP7xx MPUIO
In-Reply-To: <1315918979-26173-17-git-send-email-tarun.kanti@ti.com>
References: <1315918979-26173-1-git-send-email-tarun.kanti@ti.com>
	<1315918979-26173-17-git-send-email-tarun.kanti@ti.com>
Message-ID: <20110921150547.GB2937@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Tarun Kanti DebBarma <tarun.kanti@ti.com> [110913 05:30]:
> From: Charulatha V <charu@ti.com>
> 
> In all OMAP1 SoCs, the MPUIO bank width is 16 bits. But, in OMAP7xx,
> it is wrongly initialised to 32. Fix this.
> 
> Signed-off-by: Charulatha V <charu@ti.com>
> Reviewed-by: Santosh Shilimkar <santosh.shilimkar@ti.com>

Acked-by: Tony Lindgren <tony@atomide.com>
