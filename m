From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed, 12 Nov 2014 17:55:55 +0900
Subject: [PATCH v2 0/2] ARM: shmobile: r8a7794: Add SGX,
 MMP and VSP1 to device tree
Message-ID: <1415782557-29550-1-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

this short series adds SGX, MMP and VSP1 clocks to device
tree for the r8a7794 SoC

Based on the renesas-devel-20141112-v3.18-rc4 tag of my renesas tree

Changes between v1 and v2
* Drop VIN patch which has been queued up
* Address review by Geert Uytterhoeven as noted in per-patch changelogs

Kouei Abe (1):
  ARM: shmobile: r8a7794: Add SGX clock to device tree

Yoshifumi Hosoya (1):
  ARM: shmobile: r8a7794: Add MMP and VSP1 clocks to device tree

 arch/arm/boot/dts/r8a7794.dtsi            | 15 +++++++++------
 include/dt-bindings/clock/r8a7794-clock.h |  7 +++++++
 2 files changed, 16 insertions(+), 6 deletions(-)

-- 
2.1.1
