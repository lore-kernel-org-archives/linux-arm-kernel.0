From: lauraa@codeaurora.org (Laura Abbott)
Date: Tue, 10 Dec 2013 13:43:34 -0800
Subject: [PATCHv3 0/2] CMA for arm64
Message-ID: <1386711816-20270-1-git-send-email-lauraa@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This adds support for CMA in arm64

v3: Fix a missed line to actually set the dma_handle correctly

v2: Move the dma contiguous functions from swiotlb to arm64 directly

 arch/arm64/Kconfig                      |    1 +
 arch/arm64/include/asm/dma-contiguous.h |   29 +++++++++++++++++++++++++++++
 arch/arm64/mm/dma-mapping.c             |   27 ++++++++++++++++++++++++---
 arch/arm64/mm/init.c                    |    3 +++
 4 files changed, 57 insertions(+), 3 deletions(-)

Thanks,
Laura
