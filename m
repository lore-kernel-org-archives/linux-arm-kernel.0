From: nsekhar@ti.com (Sekhar Nori)
Date: Fri, 8 Jul 2016 14:24:24 +0530
Subject: Applied "spi: omap2-mcspi: Select SPI_SPLIT" to the spi tree
In-Reply-To: <E1bLRTH-0004lu-Mz@finisterre>
References: <E1bLRTH-0004lu-Mz@finisterre>
Message-ID: <577F6A40.1030004@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mark,

On Friday 08 July 2016 02:19 PM, Mark Brown wrote:
> From 2b32e987c48c65a1a40b3b4294435f761e063b6b Mon Sep 17 00:00:00 2001
> From: Franklin S Cooper Jr <fcooper@ti.com>
> Date: Thu, 7 Jul 2016 12:17:49 -0500
> Subject: [PATCH] spi: omap2-mcspi: Select SPI_SPLIT

Looks like you fixed up the description locally but forgot to fix the
subject line. It still shows SPI_SPLIT.

> 
> The function sg_split will be used by spi-omap2-mcspi to handle a SoC
> workaround in the SPI driver. Therefore, select SG_SPLIT so this function
> is available to the driver.
> 
> Signed-off-by: Franklin S Cooper Jr <fcooper@ti.com>
> Signed-off-by: Mark Brown <broonie@kernel.org>

Thanks,
Sekhar
