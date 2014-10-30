From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 30 Oct 2014 14:57:55 +0900
Subject: [PATCH 0/2] ARM: shmobile: r8a7790: Fix SD3CKCR address
Message-ID: <1414648677-31104-1-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This short series corrects the SD3CKCR address in both C and DT

Based on the renesas-devel-20141030-v3.18-rc2 branch of my renesas tree

Shinobu Uehara (2):
  ARM: shmobile: r8a7790: Fix SD3CKCR address
  ARM: shmobile: r8a7790: Fix SD3CKCR address to device tree

 arch/arm/boot/dts/r8a7790.dtsi         | 4 ++--
 arch/arm/mach-shmobile/clock-r8a7790.c | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

-- 
2.1.1
