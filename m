From: smoch@web.de (Soeren Moch)
Date: Mon, 27 Oct 2014 20:10:49 +0100
Subject: [PATCH v4 0/2] add initial support for TBS2910 Matrix ARM mini PC
Message-ID: <1414437051-3666-1-git-send-email-smoch@web.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

- add tbs device tree vendor prefix
- add dts for TBS2910

Soeren Moch (2):
  devicetree: bindings: Add vendor prefix for TBS Technologies
  ARM: dts: add initial support for TBS2910 Matrix ARM mini PC

 .../devicetree/bindings/vendor-prefixes.txt        |   1 +
 arch/arm/boot/dts/Makefile                         |   1 +
 arch/arm/boot/dts/imx6q-tbs2910.dts                | 429 +++++++++++++++++++++
 3 files changed, 431 insertions(+)
 create mode 100644 arch/arm/boot/dts/imx6q-tbs2910.dts

-- 
1.9.1
