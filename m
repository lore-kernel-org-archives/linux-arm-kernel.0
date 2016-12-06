From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue,  6 Dec 2016 14:32:51 +0100
Subject: [PATCH renesas/devel 0/2]  ARM: Enable r8a774[35] SoCs in defconfigs
Message-ID: <1481031173-18600-1-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

this short series enables recently added r8a7743 (RZ/G1M) and r8a7745
(RZ/G1E) SoCs in relevant defconfigs.

Based on renesas-devel-20161206-v4.9-rc8

Simon Horman (2):
  ARM: shmobile: defconfig: Enable r8a774[35] SoCs
  ARM: multi_v7_defconfig: Enable r8a774[35] SoCs

 arch/arm/configs/multi_v7_defconfig | 2 ++
 arch/arm/configs/shmobile_defconfig | 2 ++
 2 files changed, 4 insertions(+)

-- 
2.7.0.rc3.207.g0ac5344
