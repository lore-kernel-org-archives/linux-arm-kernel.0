From: narmstrong@baylibre.com (Neil Armstrong)
Date: Tue, 23 May 2017 16:21:48 +0200
Subject: [PATCH 0/3] ARM64: dts: meson: GXBB and GXL pinctrl fixes
Message-ID: <1495549311-23660-1-git-send-email-narmstrong@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset fixes the following :
 - bad gpio-ranges for GXL
 - bad pull-enable register base for GXBB & GXL

Neil Armstrong (3):
  ARM64: dts: meson-gxl: Fix pinctrl periphs gpio-ranges
  ARM64: dts: Fix GXL periphs pinctrl pull-enable register base
  ARM64: dts: Fix GXBB periphs pinctrl pull-enable register base

 arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi | 2 +-
 arch/arm64/boot/dts/amlogic/meson-gxl.dtsi  | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

-- 
1.9.1
