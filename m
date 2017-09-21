From: zhiyong.tao@mediatek.com (Zhiyong Tao)
Date: Thu, 21 Sep 2017 09:26:49 +0800
Subject: [PATCH 0/3] AUXADC: Mediatek auxadc driver for mt2712 
Message-ID: <1505957212-13402-1-git-send-email-zhiyong.tao@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series includes three patches:
1.Add mt2712 auxadc compatible node in binding document.
2.Add mt2712 auxadc compatible node in "mt6577_auxadc.c".
2.Add mt2712 auxadc device node.

Zhiyong Tao (3):
  dt-bindings: adc: mt2712: add binding document
  iio: adc: mt2712: Add compatible node for mt2712.
  arm64: dts: mt2712: Add auxadc device node.

 .../devicetree/bindings/iio/adc/mt6577_auxadc.txt  |    1 +
 arch/arm64/boot/dts/mediatek/mt2712-evb.dts        |    4 ++++
 arch/arm64/boot/dts/mediatek/mt2712e.dtsi          |    9 +++++++++
 drivers/iio/adc/mt6577_auxadc.c                    |    1 +
 4 files changed, 15 insertions(+)

--
1.7.9.5
