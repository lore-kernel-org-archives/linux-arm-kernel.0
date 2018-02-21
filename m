From: suzuki.katsuhiro@socionext.com (Katsuhiro Suzuki)
Date: Wed, 21 Feb 2018 13:33:09 +0900
Subject: [PATCH 0/2] ASoC: add support for ROHM BD28623 codec
Message-ID: <20180221043311.25840-1-suzuki.katsuhiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds support for ROHM BD28623MUV class D speaker
amplifier codec driver.

This driver only refers information of HW specification document
that can be derivered at website of ROHM.

http://www.rohm.com/web/global/products/-/product/BD28623MUV

Katsuhiro Suzuki (2):
  ASoC: add DT bindings documentation for ROHM BD28623 codec
  ASoC: support ROHM BD28623 codec

 .../devicetree/bindings/sound/rohm,bd28623.txt     |  26 +++
 sound/soc/codecs/Kconfig                           |   8 +
 sound/soc/codecs/Makefile                          |   2 +
 sound/soc/codecs/bd28623.c                         | 258 +++++++++++++++++++++
 4 files changed, 294 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/rohm,bd28623.txt
 create mode 100644 sound/soc/codecs/bd28623.c

-- 
2.16.1
