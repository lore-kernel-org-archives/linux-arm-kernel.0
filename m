From: pullip.cho@samsung.com (KyongHo Cho)
Date: Mon,  7 Mar 2011 10:19:26 +0900
Subject: [PATCH 0/2] ARM: EXYNOS4: Enhancement of System MMU
Message-ID: <1299460768-4077-1-git-send-email-pullip.cho@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch includes the following enhancements for System MMU:
- Enhanced readability
- Removal of unused data structures or their members
- Simplified function definitions
- Corrections of some logical errors
- Full compliance with Linux coding style
- Simpler way of registering callback functions of System MMU faults
- Add clock gating for System MMU

[PATCH 1/2] ARM: EXYNOS4: Enhancement of System MMU driver
[PATCH 2/2] ARM: EXYNOS4: Implement Clock gating for System MMU
