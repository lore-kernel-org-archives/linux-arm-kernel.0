From: hayashi.kunihiko@socionext.com (Kunihiko Hayashi)
Date: Mon, 12 Jun 2017 15:07:37 +0900
Subject: [PATCH v2 0/2] add support for LD20/11 Global boards
Message-ID: <1497247659-1610-1-git-send-email-hayashi.kunihiko@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Initial version of device tree for LD20/11 Global boards.

---

Changes in v2:
- use SPDX-License-Identifier for the license description
- add the atmel manufacturer to the compatible string for I2C EEPROM

Kunihiko Hayashi (2):
  arm64: dts: uniphier: add support for LD11 Global board
  arm64: dts: uniphier: add support for LD20 Global board

 arch/arm64/boot/dts/socionext/Makefile             |  2 +
 .../boot/dts/socionext/uniphier-ld11-global.dts    | 70 ++++++++++++++++++++++
 .../boot/dts/socionext/uniphier-ld20-global.dts    | 52 ++++++++++++++++
 3 files changed, 124 insertions(+)
 create mode 100644 arch/arm64/boot/dts/socionext/uniphier-ld11-global.dts
 create mode 100644 arch/arm64/boot/dts/socionext/uniphier-ld20-global.dts

-- 
2.7.4
