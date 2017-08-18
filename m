From: martyn.welch@collabora.co.uk (Martyn Welch)
Date: Fri, 18 Aug 2017 16:53:46 +0100
Subject: [PATCH v6 0/2] Add device tree and associated documentation for GE
 Healthcare PPD
Message-ID: <1503071628-11899-1-git-send-email-martyn.welch@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series adds the device tree for the GE Healthcare PPD and binding
documentation for the ge-achc, as used by the PPD device tree.

Fabien Lahoudere (1):
  ARM: dts: imx53: Add GE Healthcare PPD

Martyn Welch (1):
  dt-bindings: misc: achc: Add device tree binding for GE ACHC

 Documentation/devicetree/bindings/misc/ge-achc.txt |   26 +
 arch/arm/boot/dts/Makefile                         |    1 +
 arch/arm/boot/dts/imx53-ppd.dts                    | 1042 ++++++++++++++++++++
 3 files changed, 1069 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/misc/ge-achc.txt
 create mode 100644 arch/arm/boot/dts/imx53-ppd.dts

-- 
1.8.3.1
