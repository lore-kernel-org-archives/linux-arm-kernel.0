From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 11 Jan 2016 12:59:58 +0900
Subject: [PATCH 0/2] ARM: shmobile, multi_v7_defconfig,
 Enable XHCI_RCAR in defconfig
Message-ID: <1452484800-7470-1-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

this short series enables XHCI_RCAR, which is used by Renesas R-Car SoCs,
in the relevant defconfigs.

Simon Horman (2):
  ARM: shmobile: enable XHCI_RCAR in defconfig
  ARM: multi_v7_defconfig: Enable XHCI_RCAR

 arch/arm/configs/multi_v7_defconfig | 1 +
 arch/arm/configs/shmobile_defconfig | 2 ++
 2 files changed, 3 insertions(+)

-- 
2.7.0.rc3.207.g0ac5344
