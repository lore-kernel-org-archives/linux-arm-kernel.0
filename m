From: kgene.kim@samsung.com (Kukjin Kim)
Date: Mon,  4 Jul 2011 21:18:28 +0900
Subject: [PATCH 0/7] ARM: S5P: Use generic DMA APIs
Message-ID: <1309781915-31549-1-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch makes EXYNOS4210 SoC use generic DMA APIs instead of
Samsung specific DMA APIs. The DMA client drivers such as spi and
sound are requried to change the usage for it.

NOTE: We will also apply this on other S5P SoCs soon so we can
remove s3c-pl330 specific driver at the same time.

[PATCH 1/7] DMA: PL330: Add support runtime PM for PL330 DMAC
[PATCH 2/7] DMA: PL330: Update PL330 DMA API driver
[PATCH 3/7] DMA: PL330: Add DMA capabilities
[PATCH 4/7] ARM: SAMSUNG: Update to use PL330-DMA driver
[PATCH 5/7] ARM: EXYNOS4: Use generic DMA PL330 driver
[PATCH 6/7] spi/s3c64xx: Add support DMA engine API
[PATCH 7/7] ASoC: Samsung: Update DMA interface
