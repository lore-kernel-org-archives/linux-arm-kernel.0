From: hayashi.kunihiko@socionext.com (Kunihiko Hayashi)
Date: Thu, 25 May 2017 11:19:13 +0900
Subject: [PATCH 0/2] add support for LD20/11 Global boards
Message-ID: <1495678755-13218-1-git-send-email-hayashi.kunihiko@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Initial version of device tree for LD20/11 Global boards.

Kunihiko Hayashi (2):
  arm64: dts: uniphier: add support for LD11 Global board
  arm64: dts: uniphier: add support for LD20 Global board

 arch/arm64/boot/dts/socionext/Makefile             |   2 +
 .../boot/dts/socionext/uniphier-ld11-global.dts    | 105 +++++++++++++++++++++
 .../boot/dts/socionext/uniphier-ld20-global.dts    |  87 +++++++++++++++++
 3 files changed, 194 insertions(+)
 create mode 100644 arch/arm64/boot/dts/socionext/uniphier-ld11-global.dts
 create mode 100644 arch/arm64/boot/dts/socionext/uniphier-ld20-global.dts

-- 
2.7.4
