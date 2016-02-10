From: anup.patel@broadcom.com (Anup Patel)
Date: Wed, 10 Feb 2016 11:40:45 +0530
Subject: [PATCH 0/6] More updates for NS2 DT
Message-ID: <1455084651-29325-1-git-send-email-anup.patel@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset primarily adds more DT nodes for NS2 SVK. It also does
minor update to arch/arm64/Kconfig.platforms and adds missing DT
bindings document for sp805 driver.

The patchset is based on v4.5-rc3 tag and is available in ns2_dt2_v1
branch of https://github.com/Broadcom/arm64-linux.git

All patches have been tested on Broadcom NS2 SVK.

Anup Patel (5):
  arm64: Select COMMON_CLK_IPROC, PINCTRL and GPIOLIB for iProc SoCs
  arm64: dts: Add SDHCI DT node for NS2
  arm64: dts: Add ARM SP804 timer DT nodes for NS2
  dt-bindings: watchdog: Add ARM SP805 DT bindings
  arm64: dts: Add ARM SP805 watchdog DT node for NS2

Ray Jui (1):
  arm64: dts: Add PCIe0 and PCIe4 DT nodes for NS2

 .../devicetree/bindings/watchdog/arm,sp805.txt     |  17 +++
 arch/arm64/Kconfig.platforms                       |   3 +
 arch/arm64/boot/dts/broadcom/ns2-svk.dts           |  12 ++
 arch/arm64/boot/dts/broadcom/ns2.dtsi              | 140 +++++++++++++++++++++
 4 files changed, 172 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/watchdog/arm,sp805.txt

-- 
1.9.1
