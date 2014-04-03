From: stefan@agner.ch (stefan at agner.ch)
Date: Thu,  3 Apr 2014 17:47:08 +0200
Subject: [PATCH v2 0/2] ARM: dts: add initial Colibri VF61 board support
Message-ID: <cover.1396539657.git.stefan@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stefan Agner <stefan@agner.ch>

This patches adds initial support for Toradex Colibri VF61
computer-on-module.

Changes since v1:
- Reorder DTS for better readability
- Dumped my broken version of the alphabet and reorderd vendor prefixes

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
