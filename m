From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 30 Oct 2014 14:58:53 +0900
Subject: [PATCH 0/3] ARM: shmobile: r8a7794: Add VIN, SGX,
 MMP and VSP1 to device tree
Message-ID: <1414648736-31412-1-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

this short series adds VIN, SGX, MMP and VSP1 clocks to device
tree for the r8a7794 SoC

Based on the renesas-devel-20141030-v3.18-rc2 branch of my renesas tree

Compile tested only


Koji Matsuoka (1):
  ARM: shmobile: r8a7794: Add VIN clock to device tree

Kouei Abe (1):
  ARM: shmobile: r8a7794: Add SGX clock to device tree

Yoshifumi Hosoya (1):
  ARM: shmobile: r8a7794: Add MMP and VSP1 clocks to device tree

 arch/arm/boot/dts/r8a7794.dtsi            | 21 ++++++++++++---------
 include/dt-bindings/clock/r8a7794-clock.h |  9 +++++++++
 2 files changed, 21 insertions(+), 9 deletions(-)

-- 
2.1.1
