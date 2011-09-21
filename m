From: tony@atomide.com (Tony Lindgren)
Date: Wed, 21 Sep 2011 07:49:53 -0700
Subject: [PATCH v7 08/26] gpio/omap: further cleanup using wkup_en register
In-Reply-To: <1315918979-26173-9-git-send-email-tarun.kanti@ti.com>
References: <1315918979-26173-1-git-send-email-tarun.kanti@ti.com>
	<1315918979-26173-9-git-send-email-tarun.kanti@ti.com>
Message-ID: <20110921144953.GT2937@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Tarun Kanti DebBarma <tarun.kanti@ti.com> [110913 05:29]:
> Wakeup enable register offset initialized according to OMAP versions
> during device registration. Use this to avoid version checks.
> Starting with OMAP4, legacy registers should not be used in combination
> with the updated regsiters. Use wkup_en register consistently for
> all SoCs wherever applicable.
> 
> Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
> Signed-off-by: Charulatha V <charu@ti.com>
> Reviewed-by: Santosh Shilimkar <santosh.shilimkar@ti.com>

Acked-by: Tony Lindgren <tony@atomide.com>
