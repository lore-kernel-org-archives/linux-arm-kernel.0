From: tony@atomide.com (Tony Lindgren)
Date: Mon, 20 Feb 2012 09:20:41 -0800
Subject: [RFC 01/11] ARM: OMAP: mcbsp: Convert core driver to proper
 platform driver
In-Reply-To: <1329320280-1621-2-git-send-email-peter.ujfalusi@ti.com>
References: <1329320280-1621-1-git-send-email-peter.ujfalusi@ti.com>
 <1329320280-1621-2-git-send-email-peter.ujfalusi@ti.com>
Message-ID: <20120220172040.GJ18185@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Peter Ujfalusi <peter.ujfalusi@ti.com> [120215 07:06]:
> Convert the plat-omap/mcbsp.c driver to be proper platform driver.
> Remove the omap_mcbsp_init function call which was called from
> mach-omap1/2/mcbsp.c to register the platform driver for the just
> created platform device in the same function.
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>

Acked-by: Tony Lindgren <tony@atomide.com>
