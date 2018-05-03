From: yixun.lan@amlogic.com (Yixun Lan)
Date: Thu, 3 May 2018 21:36:41 +0000
Subject: [PATCH 0/3] spi: meson-axg: add few enhanced features
Message-ID: <20180503213645.20694-1-yixun.lan@amlogic.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

  Add a few enhanced features for the SPICC controller of Meson-AXG SoC.

  These patches are actually quite independent from each other, I send them
together in case to avoid the file conflicts.

Sunny Luo (3):
  spi: meson-axg: support MAX 80M clock
  spi: meson-axg: enhance output enable feature
  spi: meson-axg: add a linear clock divider support

 drivers/spi/spi-meson-spicc.c | 270 ++++++++++++++++++++++++++++------
 1 file changed, 222 insertions(+), 48 deletions(-)

-- 
2.17.0
