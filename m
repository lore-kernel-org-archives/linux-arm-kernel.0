From: narmstrong@baylibre.com (Neil Armstrong)
Date: Tue, 23 May 2017 16:09:17 +0200
Subject: [PATCH 0/2] pinctrl: meson: Add missing GPIODV_18 pin for GXBB and GXL
Message-ID: <1495548559-22261-1-git-send-email-narmstrong@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For unknown reasons, GPIODV_18 pin was missing in the GXBB driver and then
was copied into the GXL driver.
This patchset fixes the pin list for GXBB and GXL.

Neil Armstrong (2):
  pinctrl: meson-gxl: Add missing GPIODV_18 pin entry
  pinctrl: meson-gxbb: Add missing GPIODV_18 pin entry

 drivers/pinctrl/meson/pinctrl-meson-gxbb.c | 1 +
 drivers/pinctrl/meson/pinctrl-meson-gxl.c  | 1 +
 2 files changed, 2 insertions(+)

-- 
1.9.1
