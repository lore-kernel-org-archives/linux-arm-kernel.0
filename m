From: zhiyong.tao@mediatek.com (Zhiyong Tao)
Date: Mon, 26 Jun 2017 14:11:39 +0800
Subject: [PATCH v2 0/3] ADC: Mediatek auxadc driver for mt7622 
Message-ID: <1498457502-3669-1-git-send-email-zhiyong.tao@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series includes three patches:
1.Add mt7622 compatible node in binding document.
2.Add support for suspend/resume.
3.Add mt7622 compatible node in auxadc driver.

Changes in patch v2:
1).Change compatible node as numeric order perhaps.
2).Add "CONFIG_PM_SLEEP" and "__maybe_unused" for suspend/resume.
3).Change "dev_pm_ops" to "SIMPLE_DEV_PM_OPS".

Zhiyong Tao (3):
  dt-bindings: adc: mt7622: add binding document
  iio: adc: mt7622: add support for suspend/resume.
  iio: adc: mt7622: Add compatible node for mt7622.

 .../devicetree/bindings/iio/adc/mt6577_auxadc.txt  |    1 +
 drivers/iio/adc/mt6577_auxadc.c                    |   39 ++++++++++++++++++++
 2 files changed, 40 insertions(+)

--
1.7.9.5
