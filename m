From: boojin.kim@samsung.com (Boojin Kim)
Date: Wed, 20 Jul 2011 19:46:09 +0900
Subject: [PATCH V4 00/13] To use DMA generic APIs for Samsung DMA
Message-ID: <1311158773-30314-1-git-send-email-boojin.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset adds support DMA generic APIs for Samsung DMA.
V4 doesn't has whole patch series and only has the patches differed from V3.

Changes from V3:
- Divided 03-patch into two patchs. 
	- First is 03-1-patch for DMA_SLAVE_CONFIG command.
	- Another is 03-2-patch for DMA_CYCLIC capability.
- Code clean-up 
	- Remove unnecessary variable referance.
	- Remove redunancy code

[PATCH V4 01/13] DMA: PL330: Add support runtime PM for PL330 DMAC
[PATCH V4 03-1/13] DMA: PL330: Support DMA_SLAVE_CONFIG command
[PATCH V4 03-2/13] DMA: PL330: Add DMA_CYCLIC capability
[PATCH V4 05/13] ARM: SAMSUNG: Add common DMA operations
