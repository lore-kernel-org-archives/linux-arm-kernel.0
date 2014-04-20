From: rahul.sharma@samsung.com (Rahul Sharma)
Date: Sun, 20 Apr 2014 15:38:13 +0530
Subject: [PATCH 0/2] phy: samsung: add exynos5 SoCs for as simple phy providers
Message-ID: <1397988495-29376-1-git-send-email-rahul.sharma@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rahul Sharma <Rahul.Sharma@samsung.com>

Add Exynos5250 and 5420 as Simple phy providers to
the proposed simple phy driver by Tomasz Stanislawski
at https://lkml.org/lkml/2014/4/8/226.

Rahul Sharma (2):
  phy: samsung: add simple phys for exynos5250 SoC
  phy: samsung: add simple phys for exynos5420 SoC

 .../devicetree/bindings/phy/samsung-phy.txt        |   28 ++++++++++++++++++++
 drivers/phy/exynos-simple-phy.c                    |   17 ++++++++++++
 2 files changed, 45 insertions(+)
 mode change 100644 => 100755 drivers/phy/exynos-simple-phy.c

-- 
1.7.9.5
