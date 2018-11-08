From: christianshewitt@gmail.com (Christian Hewitt)
Date: Thu,  8 Nov 2018 21:01:06 +0400
Subject: [PATCH v2 0/3] ARM64: dts: meson-gxl: Add dts and bindings for
 Smartlabs SML-5442TW
In-Reply-To: <1541691207-24768-1-git-send-email-christianshewitt@gmail.com>
References: <1541691207-24768-1-git-send-email-christianshewitt@gmail.com>
Message-ID: <1541696475-27454-1-git-send-email-christianshewitt@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series adds new bindings and a device-tree file for the Smartlabs
SML-5442TW set-top box.

v2 - removed audio nodes
   - changes soundcard name to "meson-gx-audio"
   - added missing uart-has-rtscts;

Christian Hewitt (3):
  dt-bindings: Add vendor prefix for Smartlabs
  dt-bindings: arm: amlogic: Add support for the Smartlabs SML-5442TW
  ARM64: dts: meson-gxl: Add support for the Smartlabs SML-5442TW

 Documentation/devicetree/bindings/arm/amlogic.txt  |   1 +
 .../devicetree/bindings/vendor-prefixes.txt        |   1 +
 arch/arm64/boot/dts/amlogic/Makefile               |   1 +
 .../boot/dts/amlogic/meson-gxl-s905d-sml5442tw.dts | 316 +++++++++++++++++++++
 4 files changed, 319 insertions(+)
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-gxl-s905d-sml5442tw.dts

-- 
2.7.4
