From: ravibabu@ti.com (Ravi Babu)
Date: Fri, 13 Jan 2017 18:10:32 +0530
Subject: [PATCH 0/2] dra7x: dts update for increase in QSPI SPL parttion size
Message-ID: <1484311234-21978-1-git-send-email-ravibabu@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch updates the SPL partition size for QSPI for
dra7xx platforms.

Ravi Babu (2):
  ARM: dts: dra7-evm: increase QSPI SPL partition size
  ARM: dts: dra72x-evm: increase QSPI SPL partition size

 arch/arm/boot/dts/dra7-evm.dts          | 24 ++++++------------------
 arch/arm/boot/dts/dra72-evm-common.dtsi | 24 ++++++------------------
 2 files changed, 12 insertions(+), 36 deletions(-)

-- 
1.9.1
