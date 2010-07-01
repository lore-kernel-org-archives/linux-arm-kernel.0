From: tony@atomide.com (Tony Lindgren)
Date: Thu, 1 Jul 2010 13:33:59 +0300
Subject: [PATCH 13/16] omap: mux: Mux Apollon LCD power in board-apollon.c
In-Reply-To: <004d01cb18f5$ff27be80$fd773b80$%park@samsung.com>
References: <20100630120226.2637.31198.stgit@baageli.muru.com>
	<20100630120719.2637.65586.stgit@baageli.muru.com>
	<1277967954.2474.269.camel@tubuntu.research.nokia.com>
	<004d01cb18f5$ff27be80$fd773b80$%park@samsung.com>
Message-ID: <20100701103359.GI2822@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Kyungmin Park <kyungmin.park@samsung.com> [100701 11:12]:
> Hi,
> 
> This value is set from bootloader, and kernel side only change the mode.
> Right it runs by luck.

So should we just drop the omap_cfg_reg for now, then add it back
later with proper gpio_request etc?

Tony
