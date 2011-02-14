From: tony@atomide.com (Tony Lindgren)
Date: Mon, 14 Feb 2011 13:09:33 -0800
Subject: [PATCH 5/5] omap4: Remove 'FIXME: omap44xx_sram_init not
	implemented'
In-Reply-To: <1297510187-31547-6-git-send-email-santosh.shilimkar@ti.com>
References: <1297510187-31547-1-git-send-email-santosh.shilimkar@ti.com>
	<1297510187-31547-6-git-send-email-santosh.shilimkar@ti.com>
Message-ID: <20110214210933.GK20795@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Santosh Shilimkar <santosh.shilimkar@ti.com> [110212 03:28]:
> The omap44xx_sram_init() implements functionality to push some
> code on SRAM whenever the code can't be executed from external
> memory. The low power and DVFS code can be executed from
> external DDR itself thanks to OMAP4  memory controller hardware
> support. So on OMAP4, sram_push kind of functionality isn't needed.
> 
> Hence remove the FIXME warning added for implementing sram push
> feature on OMAP4.

Will take this one too.

Tony
