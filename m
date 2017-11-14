From: afaerber@suse.de (=?UTF-8?q?Andreas=20F=C3=A4rber?=)
Date: Tue, 14 Nov 2017 19:01:11 +0100
Subject: [PATCH 0/3] arm: owl: Add initial Allo Sparky support
Message-ID: <20171114180114.26408-1-afaerber@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This series adds a Device Tree for the Allo.com Sparky SBC.

Cf. https://en.opensuse.org/HCL:Sparky

Work branch:
https://github.com/afaerber/linux/commits/bg96-next

Have a lot of fun!

Cheers,
Andreas

Cc: Andre M. Strul <andre@allo.com>
Cc: Ioan B. <ioan@allo.com>
Cc: Sudeep Kumar <sudeepkumar@cem-solutions.net>
Cc: Jeff Chen <jeff.chen@actions-semi.com>

Cc: devicetree at vger.kernel.org

Andreas F?rber (3):
  dt-bindings: Add vendor prefix for Allo.com
  dt-bindings: arm: actions: Add Sparky
  arm: dts: owl-s500: Add Sparky

 Documentation/devicetree/bindings/arm/actions.txt  |  1 +
 .../devicetree/bindings/vendor-prefixes.txt        |  1 +
 arch/arm/boot/dts/Makefile                         |  3 +-
 arch/arm/boot/dts/owl-s500-sparky.dts              | 44 ++++++++++++++++++++++
 4 files changed, 48 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/boot/dts/owl-s500-sparky.dts

-- 
2.13.6
