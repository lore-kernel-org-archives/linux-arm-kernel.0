From: boojin.kim@samsung.com (Boojin Kim)
Date: Fri,  2 Sep 2011 09:44:28 +0900
Subject: [PATCH v8 00/16] To use DMA generic APIs for Samsung DMA
Message-ID: <1314924284-25554-1-git-send-email-boojin.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset adds support DMA generic APIs for samsung DMA.

The changes from V7 is following:
- Divides patch file.
  : The 03 patch on V7 patchset is divided into the 03 and 04 patch on V8 patchset.
    The O3 patch is only for DMA_SLAVE_CONFIG command.
    The 04 patch is only for DMA_TERMINATE_ALL command.
- Code clean-up
  : Remove unnecessary code on 05 patch.

[PATCH v8 01/16] DMA: PL330: Add support runtime PM for PL330 DMAC
[PATCH v8 02/16] DMA: PL330: Update PL330 DMA API driver
[PATCH v8 03/16] DMA: PL330: Support DMA_SLAVE_CONFIG command
[PATCH v8 04/16] DMA: PL330: Remove the start operation for handling DMA_TERMINATE_ALL command
[PATCH v8 05/16] DMA: PL330: Add DMA_CYCLIC capability
[PATCH v8 06/16] ARM: SAMSUNG: Update to use PL330-DMA driver
[PATCH v8 07/16] ARM: SAMSUNG: Add common DMA operations
[PATCH v8 08/16] ARM: EXYNOS4: Use generic DMA PL330 driver
[PATCH v8 09/16] ARM: S5PV210: Use generic DMA PL330 driver
[PATCH v8 10/16] ARM: S5PC100: Use generic DMA PL330 driver
[PATCH v8 11/16] ARM: S5P64X0: Use generic DMA PL330 driver
[PATCH v8 12/16] ARM: SAMSUNG: Remove S3C-PL330-DMA driver
[PATCH v8 13/16] spi/s3c64xx: Add support DMA engine API
[PATCH v8 14/16] spi/s3c64xx: Merge dma control code
[PATCH v8 15/16] ASoC: Samsung: Update DMA interface
[PATCH v8 16/16] ARM: SAMSUNG: Remove Samsung specific enum type for dma direction
