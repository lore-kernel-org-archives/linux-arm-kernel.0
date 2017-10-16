From: afaerber@suse.de (=?UTF-8?q?Andreas=20F=C3=A4rber?=)
Date: Mon, 16 Oct 2017 05:01:50 +0200
Subject: [PATCH 0/3] arm64: dts: Initial MeLE V9 support
Message-ID: <20171016030153.11078-1-afaerber@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This mini-series adds a Device Tree for the MeLE V9 Android Media Player.

Same as with PROBOX2 AVA, serial (loady) was the only working way to boot a new
kernel from the vendor's U-Boot on this TV box.

More details at:
https://en.opensuse.org/HCL:Mele_V9

@MeLE: Please review the following three patches and either signal your
acknowledgement of my naming proposals with an "Acked-by: name <email>"
response or point out any changes you would like to see applied. Thanks!

Latest experimental patches at:
https://github.com/afaerber/linux/commits/rtd1295-next

Have a lot of fun!

Cheers,
Andreas

Cc: meleservice at mele.cn
Cc: devicetree at vger.kernel.org

Andreas F?rber (3):
  dt-bindings: Add vendor prefix for MeLE
  dt-bindings: arm: realtek: Document MeLE V9
  arm64: dts: realtek: Add MeLE V9

 Documentation/devicetree/bindings/arm/realtek.txt  |  1 +
 .../devicetree/bindings/vendor-prefixes.txt        |  1 +
 arch/arm64/boot/dts/realtek/Makefile               |  1 +
 arch/arm64/boot/dts/realtek/rtd1295-mele-v9.dts    | 31 ++++++++++++++++++++++
 4 files changed, 34 insertions(+)
 create mode 100644 arch/arm64/boot/dts/realtek/rtd1295-mele-v9.dts

-- 
2.13.6
