From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Mon, 06 Sep 2010 05:50:40 +0200
Subject: [PATCH] Platform fixes for s5p-fimc
Message-ID: <1283745044-15514-1-git-send-email-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This patch series fixes a bunch of bugs in s5p-fimc platform support.
Mainly it adds missing clocks, dma coherent masks and clock setup code
required on Aquila and Goni targets.

This is a pure bugfix series to get fimc driver working. I hope to get
it merged for 2.6.36-rc4.

The complete list of patches:

[PATCH 1/4] ARM: S5PC110: add fimc clocks.
[PATCH 2/4] ARM: Samsung: s5p-fimc: fix dma coherent mask
[PATCH 3/4] ARM: S5PC110: add common FIMC setup code
[PATCH 4/4] ARM: S5PC110: use common FIMC clock setup code

Best regards
-- 
Marek Szyprowski
Samsung Poland R&D Center
