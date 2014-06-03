From: yoshihiro.shimoda.uh@renesas.com (Yoshihiro Shimoda)
Date: Tue, 3 Jun 2014 15:56:55 +0900
Subject: [PATCH v2 0/2] arm: shmobile: add USB 3.0 DT for r8a7791
Message-ID: <538D71B7.603@renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series is based on the renesas-devel-v3.15-rc7-20140530
in renesas.git.

Changes from v1:
 - Change node name to "usb at ee000000" in patch 2.
 - Add comment in the change log of patch 2 about a generic phy.

Yoshihiro Shimoda (2):
  arm: shmobile: r8a7791: add USB3.0 clocks to device tree
  arm: shmobile: r8a7791: add USB3.0 node to r8a7791.dtsi

 arch/arm/boot/dts/r8a7791.dtsi |   16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

-- 
1.7.9.5
