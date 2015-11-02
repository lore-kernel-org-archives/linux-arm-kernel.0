From: jonmason@broadcom.com (Jon Mason)
Date: Mon, 2 Nov 2015 13:34:51 -0500
Subject: [PATCH RESEND v4 0/2] ARM: dts: bcm5301x: Add SVK DT files and docs 
Message-ID: <1446489293-25088-1-git-send-email-jonmason@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Resending due to lack of any response to the original v4 series

Changes in v4:
* Changed bootargs to stdout-path, per Sudeep Holla

Changes in v3:
* Updated the DT documentation compat strings
* Modified the include files and compat strings for the SVK DT files,
  per Hauke Mehrtens

Changes in v2:
* Reorder the patches to add the DT binding documentation prior to the
  new DT files
* Removed the DT documentation compat strings to only the SoCs, not the
  individual boards
* Fixed the compat strings in the individual device tree files
* Added the memory node and removed the "mem=" from the bootargs


Add device tree files and update the documentation for Broadcom
Northstar based SVKs.  Since the bcm5301x.dtsi already exists, all that
is necessary is the dts files to enable the UARTs.  With these files,
the SVKs are able to boot to shell

Jon Mason (2):
  dt-bindings: Add new SoCs to bcm4708 DT bindings
  ARM: dts: bcm5301x: Add BCM SVK DT files

 .../devicetree/bindings/arm/bcm/brcm,bcm4708.txt   |  7 +++
 arch/arm/boot/dts/Makefile                         |  5 +-
 arch/arm/boot/dts/bcm94708.dts                     | 56 +++++++++++++++++++
 arch/arm/boot/dts/bcm94709.dts                     | 56 +++++++++++++++++++
 arch/arm/boot/dts/bcm953012k.dts                   | 63 ++++++++++++++++++++++
 5 files changed, 186 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/boot/dts/bcm94708.dts
 create mode 100644 arch/arm/boot/dts/bcm94709.dts
 create mode 100644 arch/arm/boot/dts/bcm953012k.dts

-- 
1.9.1
