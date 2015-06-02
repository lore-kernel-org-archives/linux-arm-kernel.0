From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue,  2 Jun 2015 10:34:35 +0900
Subject: [PATCH 0/2] ARM: Enable r8a7793/gose in defconfigs
Message-ID: <1433208877-3284-1-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

this small series enables the r8a7793/gose in both
multi_v7_defconfig and shmobile_defconfig.

Based on the defconfig-for-v4.3 branch of my renesas tree,
which is in turn based on v4.1-rc1.

Simon Horman (2):
  ARM: shmobile: Enable gose board in multiplatform defconfig
  ARM: multi_v7_defconfig: Enable shmobile r8a7793/gose platform

 arch/arm/configs/multi_v7_defconfig | 1 +
 arch/arm/configs/shmobile_defconfig | 1 +
 2 files changed, 2 insertions(+)

-- 
2.1.4
