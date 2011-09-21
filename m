From: tony@atomide.com (Tony Lindgren)
Date: Wed, 21 Sep 2011 08:03:46 -0700
Subject: [PATCH v7 13/26] gpio/omap: use pinctrl offset instead of macro
In-Reply-To: <1315918979-26173-14-git-send-email-tarun.kanti@ti.com>
References: <1315918979-26173-1-git-send-email-tarun.kanti@ti.com>
	<1315918979-26173-14-git-send-email-tarun.kanti@ti.com>
Message-ID: <20110921150346.GZ2937@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Tarun Kanti DebBarma <tarun.kanti@ti.com> [110913 05:29]:
> From: Charulatha V <charu@ti.com>
> 
> Use regs->pinctrl field instead of using the macro OMAP1510_GPIO_PIN_CONTROL
> 
> Signed-off-by: Charulatha V <charu@ti.com>
> Reviewed-by: Santosh Shilimkar <santosh.shilimkar@ti.com>

Acked-by: Tony Lindgren <tony@atomide.com>
