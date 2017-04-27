From: jon.mason@broadcom.com (Jon Mason)
Date: Thu, 27 Apr 2017 17:23:11 -0400
Subject: [PATCH v2 0/3] thermal: broadcom: Add NSP Thermal Support
Message-ID: <1493328194-1766-1-git-send-email-jon.mason@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Changes in v2:
* Split SoC enablement into a separate patch (per Eduardo Valentin)
* Added Eduardo Valentin's Acked-by to the DTS patch


This adds support for NSP to the existing Northstar thermal driver.
This code is based on patches currently in the Linux SoC Thermal git
tree.  Specfically,
https://git.kernel.org/pub/scm/linux/kernel/git/evalenti/linux-soc-thermal.git/commit/?h=linus&id=a94cb7eeecc4104a6874339f90c5d0647359c102

Jon Mason (3):
  ARM: BCM: Enable thermal support for iProc SoCs
  thermal: broadcom: ns-thermal: default on iProc SoCs
  ARM: dts: NSP: Add Thermal Support

 arch/arm/boot/dts/bcm-nsp.dtsi   | 26 ++++++++++++++++++++++++++
 arch/arm/mach-bcm/Kconfig        |  2 ++
 drivers/thermal/broadcom/Kconfig |  9 +++++----
 3 files changed, 33 insertions(+), 4 deletions(-)

-- 
2.7.4
