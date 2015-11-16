From: bhupesh.sharma@freescale.com (Bhupesh Sharma)
Date: Mon, 16 Nov 2015 19:54:41 +0530
Subject: [PATCH 0/2] ARM64: Enable SP805 WDT support for FSL LS2080A
Message-ID: <1447683883-6600-1-git-send-email-bhupesh.sharma@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset adds the support for SP805 WDT on FSL LS2080A and
also adds the missing documentation of SP805 WDT device-tree bindings.

Rebased against arm-soc/next/dt

Bhupesh Sharma (2):
  Documentation: DT: Add entry for ARM SP805-WDT
  dts/ls2080a: Update DTSI to add support of SP805 WDT

 .../devicetree/bindings/watchdog/sp805-wdt.txt     |   33 ++++++++++
 arch/arm64/boot/dts/freescale/fsl-ls2080a.dtsi     |   64 ++++++++++++++++++++
 2 files changed, 97 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/watchdog/sp805-wdt.txt

-- 
1.7.9.5
