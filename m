From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 16 Jun 2016 14:23:56 +0900
Subject: [PATCH 0/2] ARM: defconfig: Enable r8a7792
Message-ID: <1466054638-11326-1-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable r8a7792 SoC in shmobile and multi_v7 defconfigs.

Based on renesas-devel-20160616-v4.7-rc3

Simon Horman (2):
  ARM: shmobile: defconfig: Enable r8a7792 SoC
  ARM: multi_v7_defconfig: defconfig: Enable r8a7792 SoC

 arch/arm/configs/multi_v7_defconfig | 1 +
 arch/arm/configs/shmobile_defconfig | 1 +
 2 files changed, 2 insertions(+)

-- 
2.1.4
