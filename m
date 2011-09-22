From: tony@atomide.com (Tony Lindgren)
Date: Thu, 22 Sep 2011 14:53:54 -0700
Subject: [PATCH 01/10] cpufreq: OMAP: cleanup for multi-SoC support,
	move into drivers/cpufreq
In-Reply-To: <1316725648-26710-2-git-send-email-khilman@ti.com>
References: <1316725648-26710-1-git-send-email-khilman@ti.com>
	<1316725648-26710-2-git-send-email-khilman@ti.com>
Message-ID: <20110922215354.GV2937@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Kevin Hilman <khilman@ti.com> [110922 13:35]:
> From: Santosh Shilimkar <santosh.shilimkar@ti.com>
> 
> Move OMAP cpufreq driver from arch/arm/mach-omap2 into
> drivers/cpufreq, along with a few cleanups:
> 
> - generalize support for better handling of different SoCs in the OMAP
> - use OPP layer instead of OMAP clock internals for frequency table init
> 
> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> [khilman at ti.com: move to drivers]
> Signed-off-by: Kevin Hilman <khilman@ti.com>

Nice to see this happening:

Acked-by: Tony Lindgren <tony@atomide.com>
