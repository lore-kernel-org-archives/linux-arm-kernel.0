From: narmstrong@baylibre.com (Neil Armstrong)
Date: Mon, 22 May 2017 14:59:24 +0200
Subject: [PATCH 0/2] pinctrl: meson: Add SPICC pins
Message-ID: <1495457966-2359-1-git-send-email-narmstrong@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This serie adds the SPICC controller pin for GXBB and GXL pinctrl drivers.

Neil Armstrong (2):
  pinctrl: meson-gxl: Add SPI pins for the SPICC controller
  pinctrl: meson-gxbb: Add SPI pins for SPICC controller

 drivers/pinctrl/meson/pinctrl-meson-gxbb.c | 14 ++++++++++++++
 drivers/pinctrl/meson/pinctrl-meson-gxl.c  | 14 ++++++++++++++
 2 files changed, 28 insertions(+)

-- 
1.9.1
