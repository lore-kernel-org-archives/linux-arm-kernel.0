From: narmstrong@baylibre.com (Neil Armstrong)
Date: Wed,  7 Nov 2018 11:45:46 +0100
Subject: [PATCH 0/4] arm64: dts: meson-gx: fix GPIO lines names
Message-ID: <1541587550-17842-1-git-send-email-narmstrong@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The gpio line names were set in the pinctrl node instead of the gpio node,
at the time it was merged, it worked, but was obviously wrong.
This patches moves the properties to the gpio nodes for the board DT having
the GPIO lines names.

Neil Armstrong (4):
  arm64: dts: meson-gxl-libretech-cc: fix GPIO lines names
  arm64: dts: meson-gxbb-nanopi-k2: fix GPIO lines names
  arm64: dts: meson-gxbb-odroidc2: fix GPIO lines names
  arm64: dts: meson-gxl-khadas-vim: fix GPIO lines names

 arch/arm64/boot/dts/amlogic/meson-gxbb-nanopi-k2.dts         | 4 ++--
 arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts          | 4 ++--
 arch/arm64/boot/dts/amlogic/meson-gxl-s905x-khadas-vim.dts   | 4 ++--
 arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc.dts | 4 ++--
 4 files changed, 8 insertions(+), 8 deletions(-)

-- 
2.7.4
