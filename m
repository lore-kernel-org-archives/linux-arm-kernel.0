From: tony@atomide.com (Tony Lindgren)
Date: Wed, 21 Sep 2011 07:41:24 -0700
Subject: [PATCH v7 01/26] gpio/omap: remove dependency on gpio_bank_count
In-Reply-To: <1315918979-26173-2-git-send-email-tarun.kanti@ti.com>
References: <1315918979-26173-1-git-send-email-tarun.kanti@ti.com>
	<1315918979-26173-2-git-send-email-tarun.kanti@ti.com>
Message-ID: <20110921144124.GO2937@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Tarun Kanti DebBarma <tarun.kanti@ti.com> [110913 05:29]:
> From: Charulatha V <charu@ti.com>
> 
> The gpio_bank_count is the count of number of GPIO devices in a SoC. Remove this
> dependency from the driver by using list. Also remove the dependency on array of
> pointers to gpio_bank struct of all GPIO devices.
> 
> Signed-off-by: Charulatha V <charu@ti.com>
> Reviewed-by: Santosh Shilimkar <santosh.shilimkar@ti.com>

Acked-by: Tony Lindgren <tony@atomide.com>
