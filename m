From: narmstrong@baylibre.com (Neil Armstrong)
Date: Fri,  4 Aug 2017 15:12:11 +0200
Subject: [PATCH v2 0/2] ARM64: dts: meson-gx: Enable CEC
Message-ID: <1501852333-3560-1-git-send-email-narmstrong@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset enables :
 - Update the AO domain clkc to new bindings
 - AO CEC Controller linked with the HDMI controller all HDMI supported boards

This patchset depends on the clock bindings posted in [1].

Changes since v1 at [2]:
 - Update to new bindings introduces in [3]
 - Added cec to wetek-play2, khadas-vim and libretech-cc

[1] https://lkml.kernel.org/r/1501588619-10991-4-git-send-email-narmstrong at baylibre.com
[2] https://lkml.kernel.org/r/1499673381-21039-1-git-send-email-narmstrong at baylibre.com
[3] https://lkml.kernel.org/r/1501588619-10991-2-git-send-email-narmstrong at baylibre.com

Neil Armstrong (2):
  ARM64: dts: meson-gx: update AO clkc to new bindings
  ARM64: dts: meson-gx: Add AO CEC nodes

 arch/arm64/boot/dts/amlogic/meson-gx-p23x-q20x.dtsi  |  7 +++++++
 arch/arm64/boot/dts/amlogic/meson-gx.dtsi            | 20 +++++++++++++++-----
 .../boot/dts/amlogic/meson-gxbb-nexbox-a95x.dts      |  7 +++++++
 arch/arm64/boot/dts/amlogic/meson-gxbb-p20x.dtsi     |  7 +++++++
 .../boot/dts/amlogic/meson-gxbb-wetek-play2.dts      |  6 ++++++
 arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi          |  9 +++++++++
 arch/arm64/boot/dts/amlogic/meson-gxl-s905d-p230.dts |  8 +++++++-
 .../boot/dts/amlogic/meson-gxl-s905x-khadas-vim.dts  |  7 +++++++
 .../dts/amlogic/meson-gxl-s905x-libretech-cc.dts     |  7 +++++++
 .../boot/dts/amlogic/meson-gxl-s905x-nexbox-a95x.dts |  7 +++++++
 arch/arm64/boot/dts/amlogic/meson-gxl-s905x-p212.dts |  7 +++++++
 arch/arm64/boot/dts/amlogic/meson-gxl.dtsi           | 10 ++++++++++
 arch/arm64/boot/dts/amlogic/meson-gxm-nexbox-a1.dts  |  7 +++++++
 arch/arm64/boot/dts/amlogic/meson-gxm.dtsi           |  4 ++++
 14 files changed, 107 insertions(+), 6 deletions(-)

-- 
1.9.1
