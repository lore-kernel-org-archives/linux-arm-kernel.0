From: afaerber@suse.de (=?UTF-8?q?Andreas=20F=C3=A4rber?=)
Date: Sat, 13 May 2017 17:23:09 +0200
Subject: [PATCH v2 0/3] arm64: meson-gxm: R-Box Pro enablement
Message-ID: <20170513152312.19912-1-afaerber@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This mini-series adds initial support for the Amlogic S912 based
R-Box Pro TV boxes.

v2 depends on my Meson cleanup series (amlogic.txt, Makefile) and
squashes the addition of a board compatible string.

@Kingnovel: Your Acked-by would be appreciated.

Regards,
Andreas

v1 -> v2:
* Dropped Bluetooth patch, awaiting serdev drivers (Kevin)
* Rebased onto my cleanup series
* Added vendor prefix
* Added board compatible string

Cc: devicetree at vger.kernel.org
Cc: ada at kingnoval.com

Andreas F?rber (3):
  dt-bindings: Add Kingnovel vendor prefix
  dt-bindings: arm: amlogic: Add R-Box Pro
  arm64: dts: meson-gxm: Add R-Box Pro

 Documentation/devicetree/bindings/arm/amlogic.txt  |   1 +
 .../devicetree/bindings/vendor-prefixes.txt        |   1 +
 arch/arm64/boot/dts/amlogic/Makefile               |   1 +
 arch/arm64/boot/dts/amlogic/meson-gxm-rbox-pro.dts | 240 +++++++++++++++++++++
 4 files changed, 243 insertions(+)
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-gxm-rbox-pro.dts

-- 
2.12.0
