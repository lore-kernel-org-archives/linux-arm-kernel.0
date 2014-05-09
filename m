From: prabhakar.csengg@gmail.com (Lad, Prabhakar)
Date: Fri,  9 May 2014 12:27:46 +0530
Subject: [PATCH v3 0/3] ARM: defconfig: drop CONFIG_COMMON_CLK_DEBUG option
Message-ID: <1399618669-6830-1-git-send-email-prabhakar.csengg@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>

Hi All,

This patch series drops the CONFIG_COMMON_CLK_DEBUG option
from rest of the defconfig files.

Changes for v3:
a> Splitted up the patch so that individual owners can pick it up.

Lad, Prabhakar (3):
  ARM: integrator: drop CONFIG_COMMON_CLK_DEBUG
  ARM: sunxi: drop CONFIG_COMMON_CLK_DEBUG
  ARM: vt8500: drop CONFIG_COMMON_CLK_DEBUG

 arch/arm/configs/integrator_defconfig   |    1 -
 arch/arm/configs/sunxi_defconfig        |    1 -
 arch/arm/configs/vt8500_v6_v7_defconfig |    1 -
 3 files changed, 3 deletions(-)

-- 
1.7.9.5
