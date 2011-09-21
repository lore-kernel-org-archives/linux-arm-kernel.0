From: tony@atomide.com (Tony Lindgren)
Date: Wed, 21 Sep 2011 07:55:51 -0700
Subject: [PATCH v7 11/26] gpio/omap: cleanup set_gpio_triggering function
In-Reply-To: <1315918979-26173-12-git-send-email-tarun.kanti@ti.com>
References: <1315918979-26173-1-git-send-email-tarun.kanti@ti.com>
	<1315918979-26173-12-git-send-email-tarun.kanti@ti.com>
Message-ID: <20110921145551.GW2937@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Tarun Kanti DebBarma <tarun.kanti@ti.com> [110913 05:29]:
> Getting rid of ifdefs within the function by adding register offset intctrl
> and associating OMAPXXXX_GPIO_INT_CONTROL in respective SoC specific files.
> Also, use wkup_status register consistently instead of referring to wakeup
> clear and wakeup set register offsets.
> 
> Signed-off-by: Charulatha V <charu@ti.com>
> Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
> Reviewed-by: Santosh Shilimkar <santosh.shilimkar@ti.com>

Acked-by: Tony Lindgren <tony@atomide.com>
