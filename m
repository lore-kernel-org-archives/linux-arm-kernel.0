From: tony@atomide.com (Tony Lindgren)
Date: Wed, 21 Sep 2011 08:05:33 -0700
Subject: [PATCH v7 15/26] gpio/omap: remove bank->method & METHOD_* macros
In-Reply-To: <1315918979-26173-16-git-send-email-tarun.kanti@ti.com>
References: <1315918979-26173-1-git-send-email-tarun.kanti@ti.com>
	<1315918979-26173-16-git-send-email-tarun.kanti@ti.com>
Message-ID: <20110921150533.GA2937@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Tarun Kanti DebBarma <tarun.kanti@ti.com> [110913 05:30]:
> From: Charulatha V <charu@ti.com>
> 
> The only bank->type (method) used in the OMAP GPIO driver is MPUIO type as they
> need to be handled separately. Identify the same using a flag and remove all
> METHOD_* macros.
> 
> mpuio_init() function is defined under #ifdefs. It is required only in case
> of MPUIO bank type and only when PM operations are supported by it.
> This is applicable only in case of OMAP16xx SoC's MPUIO GPIO bank type.
> For all the other cases it is a dummy function. Hence clean up the same
> and remove all the OMAP SoC specific #ifdefs.
> 
> Signed-off-by: Charulatha V <charu@ti.com>
> Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
> Reviewed-by: Santosh Shilimkar <santosh.shilimkar@ti.com>

Acked-by: Tony Lindgren <tony@atomide.com>
