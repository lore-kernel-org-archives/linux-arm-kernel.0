From: lauri.hintsala@bluegiga.com (Lauri Hintsala)
Date: Tue, 10 Jul 2012 10:08:06 +0300
Subject: [PATCH 0/6] Improve apx4devkit DT support
Message-ID: <1341904092-13777-1-git-send-email-lauri.hintsala@bluegiga.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add NAND, display and SSP2 support for apx4devkit.

Patches are based on Shawn's mxs/dt/others-v2 branch.

Lauri

---
Lauri Hintsala (6):
  ARM: apx4devkit: add NAND support
  ARM: apx4devkit: add display support
  ARM: apx4devkit: fix the bus-width of SSP0 to 4 bits
  ARM: apx4devkit: add SSP2 support
  ARM: apx4devkit: remove AUART3
  ARM: apx4devkit: add pin muxing for GPIOs

 arch/arm/boot/dts/apx4devkit.dts |   75 +++++++++++++++++++++++++++++++++-----
 arch/arm/mach-mxs/mach-mxs.c     |   24 ++++++++++++
 2 files changed, 89 insertions(+), 10 deletions(-)

-- 
1.7.9.5
