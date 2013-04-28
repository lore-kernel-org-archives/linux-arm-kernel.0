From: shawn.guo@linaro.org (Shawn Guo)
Date: Sun, 28 Apr 2013 16:52:49 +0800
Subject: [PATCH 1/2] ARM: dts: i.MX6: configure L2 cache data and tag
 latency
In-Reply-To: <1366964036-17275-1-git-send-email-dirk.behme@de.bosch.com>
References: <1366964036-17275-1-git-send-email-dirk.behme@de.bosch.com>
Message-ID: <20130428085248.GC1943@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 26, 2013 at 10:13:55AM +0200, Dirk Behme wrote:
> Configure the data and tag latency for the L2 cache. This improves the
> system performance.
> 
> This configuration is taken from Freescale's kernel patch
> 
> "ENGR00153601 [MX6]Adjust L2 cache parameter" [1]
> 
> which does
> 
> writel(0x132, IO_ADDRESS(L2_BASE_ADDR + L2X0_TAG_LATENCY_CTRL));
> writel(0x132, IO_ADDRESS(L2_BASE_ADDR + L2X0_DATA_LATENCY_CTRL));
> 
> In this patch we are doing the same via the device tree.
> 
> Signed-off-by: Dirk Behme <dirk.behme@de.bosch.com>

Both applied, thanks.
