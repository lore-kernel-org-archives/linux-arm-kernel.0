From: tony@atomide.com (Tony Lindgren)
Date: Mon, 8 Oct 2012 14:51:02 -0700
Subject: [PATCH] ARM: OMAP2+: gpmc: annotate exit sections properly
In-Reply-To: <1349339517-17882-1-git-send-email-afzal@ti.com>
References: <1349339517-17882-1-git-send-email-afzal@ti.com>
Message-ID: <20121008215102.GU13011@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Afzal Mohammed <afzal@ti.com> [121004 01:33]:
> compiler complained,
> `gpmc_remove' referenced in section `.data' of arch/arm/mach-omap2/built-in.o: defined in discarded section `.exit.text' of arch/arm/mach-omap2/built-in.o
> 
> Annotate gpmc_remove function and dependents with __devexit.

Thanks applying into omap fixes.

Tony
