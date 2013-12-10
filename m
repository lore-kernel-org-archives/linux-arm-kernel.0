From: lauraa@codeaurora.org (Laura Abbott)
Date: Tue, 10 Dec 2013 11:52:10 -0800
Subject: [PATCHv2 0/2] CMA for arm64
Message-ID: <1386705132-7127-1-git-send-email-lauraa@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This is v2 of adding CMA for arm64. I dropped integration into swiotlb
and put the calls directly into mm/dma-mapping.c

 arch/arm64/Kconfig                      |    1 +
 arch/arm64/include/asm/dma-contiguous.h |   29 +++++++++++++++++++++++++++++
 arch/arm64/mm/dma-mapping.c             |   26 +++++++++++++++++++++++---
 arch/arm64/mm/init.c                    |    3 +++
 4 files changed, 56 insertions(+), 3 deletions(-)


Thanks,
Laura
