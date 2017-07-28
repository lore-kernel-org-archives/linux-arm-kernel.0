From: narmstrong@baylibre.com (Neil Armstrong)
Date: Fri, 28 Jul 2017 15:54:42 +0200
Subject: [PATCH 0/2] ARM64: dts: meson-gx: Add GPIO names for SBCs
Message-ID: <1501250084-19967-1-git-send-email-narmstrong@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset adds the GPIO line names like the Odroid-C2 previous patch,
for the Khadas VIM and Nanopi K2 boards.

Neil Armstrong (2):
  ARM64: dts: meson-gxl-khadas-vim: Add GPIO lines names
  ARM64: dts: meson-gxbb-nanopi-k2: Add GPIO lines names

 .../boot/dts/amlogic/meson-gxbb-nanopi-k2.dts      | 58 ++++++++++++++++++++++
 .../dts/amlogic/meson-gxl-s905x-khadas-vim.dts     | 56 +++++++++++++++++++++
 2 files changed, 114 insertions(+)

-- 
1.9.1
