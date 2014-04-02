From: stefan@agner.ch (stefan at agner.ch)
Date: Wed,  2 Apr 2014 18:47:25 +0200
Subject: [PATCH 0/2] ARM: dts: add initial Colibri VF61 board support
Message-ID: <cover.1396456704.git.stefan@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stefan Agner <stefan@agner.ch>

This patches add initial support for Toradex Colibri VF61
computer-on-module.

Stefan Agner (2):
  of: add vendor prefix for Toradex AG
  ARM: dts: add initial Colibri VF61 board support

 .../devicetree/bindings/vendor-prefixes.txt        |   1 +
 arch/arm/boot/dts/Makefile                         |   1 +
 arch/arm/boot/dts/vf610-colibri.dts                | 123 +++++++++++++++++++++
 3 files changed, 125 insertions(+)
 create mode 100644 arch/arm/boot/dts/vf610-colibri.dts

-- 
1.9.1
