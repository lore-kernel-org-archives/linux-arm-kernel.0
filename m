From: narmstrong@baylibre.com (Neil Armstrong)
Date: Thu,  8 Sep 2016 09:53:24 +0200
Subject: [PATCH 0/2] spi: meson: Add Amlogic GXBB compatible
Message-ID: <1473321206-32284-1-git-send-email-narmstrong@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset adds a specific compatible string in the Meson SPIFC driver for
the Amlogic Meson GXBB SoC.

This patchset is SPI-only respin from Jerome Brunet patchset at [1].

[1] http://lkml.kernel.org/r/1473261223-15412-1-git-send-email-jbrunet at baylibre.com

Neil Armstrong (2):
  dt-bindings: spi-meson: Add GXBB Compatible string
  spi: meson: Add GXBB compatible

 Documentation/devicetree/bindings/spi/spi-meson.txt | 2 +-
 drivers/spi/spi-meson-spifc.c                       | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

-- 
1.9.1
