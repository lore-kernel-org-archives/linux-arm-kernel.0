From: yixun.lan@amlogic.com (Yixun Lan)
Date: Mon, 26 Mar 2018 16:46:26 +0800
Subject: [PATCH 0/3] iio: adc: meson-axg: add saradc driver support
Message-ID: <20180326084629.100070-1-yixun.lan@amlogic.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

 The patch 1 is a general small improvement, no function changed!
 The last two patches try to add saradc support for Amlogic'S Meson-AXG
SoC platfrom.
 I will send the DTS part patch in another thread, since it depend on
the clock AO driver[0].


[0] https://lkml.kernel.org/r/20180323143816.200573-1-yixun.lan at amlogic.com

Xingyu Chen (2):
  dt-bindings: iio: adc: document the Meson AXG support
  iio: adc: meson-axg: add saradc driver

Yixun Lan (1):
  iio: adc: meson-saradc: squash and share the common adc platform data

 .../bindings/iio/adc/amlogic,meson-saradc.txt      |  1 +
 drivers/iio/adc/meson_saradc.c                     | 83 +++++++++++++---------
 2 files changed, 51 insertions(+), 33 deletions(-)

-- 
2.15.1
