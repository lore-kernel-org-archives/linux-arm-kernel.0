From: w-kwok2@ti.com (WingMan Kwok)
Date: Mon, 9 Dec 2013 17:32:10 -0500
Subject: [PATCH v3 0/3] ARM: dts: Keystone II USB nodes
Message-ID: <1386628333-1849-1-git-send-email-w-kwok2@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Here is the separated dts series which addresses comments from
earlier version [1].

Series adds USB host dts nodes for Keystone SOCs. Keystone SOCs uses dwc3
hardware IP implementation. We use no-op phy driver.

Patchset are tested on Keystone II EVM with USB2.0 and USB3.0 flash drives.

Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>

WingMan Kwok (3):
  ARM: dts: keystone: Add usb phy devicetree bindings
  ARM: dts: keystone: Add usb devicetree bindings
  ARM: keystone: defconfig: enable USB support

 .../devicetree/bindings/usb/keystone-phy.txt       |   20 ++++++++++
 .../devicetree/bindings/usb/keystone-usb.txt       |   42 ++++++++++++++++++++
 arch/arm/boot/dts/k2hk-evm.dts                     |    8 ++++
 arch/arm/boot/dts/keystone.dtsi                    |   27 +++++++++++++
 arch/arm/configs/keystone_defconfig                |   20 +++++++++-
 5 files changed, 116 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/usb/keystone-phy.txt
 create mode 100644 Documentation/devicetree/bindings/usb/keystone-usb.txt

[1] http://www.spinics.net/lists/linux-usb/msg98861.html
-- 
1.7.9.5
