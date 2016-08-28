From: martin.blumenstingl@googlemail.com (Martin Blumenstingl)
Date: Sun, 28 Aug 2016 18:47:23 +0200
Subject: [PATCH 0/2] add support for the SDIO pins on GXBB
Message-ID: <20160828164725.19429-1-martin.blumenstingl@googlemail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series adds the pins for the SDIO controller (sd_emmc_a) found on
Meson GXBB SoCs.


Martin Blumenstingl (2):
  pinctrl: meson-gxbb: add the pins for the SDIO/sd_emmc_a controller
  ARM64: dts: meson-gxbb: add the SDIO pins

 arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi | 12 ++++++++++++
 drivers/pinctrl/meson/pinctrl-meson-gxbb.c  | 19 +++++++++++++++++++
 2 files changed, 31 insertions(+)

-- 
2.9.3
