From: lauraa@codeaurora.org (Laura Abbott)
Date: Mon,  9 Dec 2013 16:12:11 -0800
Subject: [PATCH 0/3] CMA support for arm64
Message-ID: <1386634334-31139-1-git-send-email-lauraa@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This series adds support for CMA on arm64 based targets. Currently this ties
in at the lib/swiotlb.c layer for allocation instead of
arch/arm64/mm/dma-mapping.c

 arch/arm64/Kconfig                      |    1 +
 arch/arm64/include/asm/dma-contiguous.h |   29 ++++++++++
 arch/arm64/mm/dma-mapping.c             |    2 +-
 arch/arm64/mm/init.c                    |    3 +
 lib/swiotlb.c                           |   92 +++++++++++++++++++++++++++++--
 5 files changed, 120 insertions(+), 7 deletions(-)

Thanks,
Laura
