From: zhiyong.tao@mediatek.com (Zhiyong Tao)
Date: Thu, 22 Jun 2017 13:44:31 +0800
Subject: [PATCH 0/3] ADC: Mediatek auxadc driver for mt7622 
Message-ID: <1498110274-18678-1-git-send-email-zhiyong.tao@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These patches are first version of Mediatek auxadc driver for mt7622.
These patches include three patches.
The First patch adds mt7622 compatible node in binding document.
The second patch adds support for suspend/resume.
The last patch adds mt7622 compatible node in auxadc driver.

Zhiyong Tao (3):
  dt-bindings: adc: mt7622: add binding document
  iio: adc: mt7622: add support for suspend/resume.
  iio: adc: mt7622: Add compatible node for mt7622.

 .../devicetree/bindings/iio/adc/mt6577_auxadc.txt  |    1 +
 drivers/iio/adc/mt6577_auxadc.c                    |   38 ++++++++++++++++++++
 2 files changed, 39 insertions(+)

--
1.7.9.5
