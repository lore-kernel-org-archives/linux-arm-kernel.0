From: boojin.kim@samsung.com (Boojin Kim)
Date: Fri, 19 Aug 2011 17:54:42 +0900
Subject: [PATCH V6 00/15] To use DMA generic APIs for Samsung DMA
Message-ID: <1313744097-27289-1-git-send-email-boojin.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset adds support DMA generic APIs for Samsung DMA.

V6 is to fix the build error that is occurred during merging V5 and the latest
mainline stream.
This changes from V5 is followings.
-  [PATCH v6 02/15]: Include 'linux/scatterlist.h'
-  [PATCH v6 06/15]: Include 'linux/scatterlist.h'

[PATCH v6 01/15] DMA: PL330: Add support runtime PM for PL330 DMAC
[PATCH v6 02/15] DMA: PL330: Update PL330 DMA API driver
[PATCH v6 03/15] DMA: PL330: Support DMA_SLAVE_CONFIG command
[PATCH v6 04/15] DMA: PL330: Add DMA_CYCLIC capability
[PATCH v6 05/15] ARM: SAMSUNG: Update to use PL330-DMA driver
[PATCH v6 06/15] ARM: SAMSUNG: Add common DMA operations
[PATCH v6 07/15] ARM: EXYNOS4: Use generic DMA PL330 driver
[PATCH v6 08/15] ARM: S5PV210: Use generic DMA PL330 driver
[PATCH v6 09/15] ARM: S5PC100: Use generic DMA PL330 driver
[PATCH v6 10/15] ARM: S5P64X0: Use generic DMA PL330 driver
[PATCH v6 11/15] ARM: SAMSUNG: Remove S3C-PL330-DMA driver
[PATCH v6 12/15] spi/s3c64xx: Add support DMA engine API
[PATCH v6 13/15] spi/s3c64xx: Merge dma control code
[PATCH v6 14/15] ASoC: Samsung: Update DMA interface
[PATCH v6 15/15] ARM: SAMSUNG: Remove Samsung specific enum type for dma direction
