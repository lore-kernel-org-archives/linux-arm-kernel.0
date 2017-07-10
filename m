From: narmstrong@baylibre.com (Neil Armstrong)
Date: Mon, 10 Jul 2017 09:56:19 +0200
Subject: [PATCH 0/2] ARM64: dts: meson-gx: Enable CEC
Message-ID: <1499673381-21039-1-git-send-email-narmstrong@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset enables :
 - Support for the AO domain CEC 32k clock
 - AO CEC Controller linked with the HDMI controller all HDMI supported boards

Neil Armstrong (2):
  ARM64: dts: meson-gx: Add PWR and CRT/RTC nodes and adresses
  ARM64: dts: meson-gx: Add AO CEC nodes

 arch/arm64/boot/dts/amlogic/meson-gx-p23x-q20x.dtsi     |  7 +++++++
 arch/arm64/boot/dts/amlogic/meson-gx.dtsi               | 17 ++++++++++++++++-
 arch/arm64/boot/dts/amlogic/meson-gxbb-nexbox-a95x.dts  |  7 +++++++
 arch/arm64/boot/dts/amlogic/meson-gxbb-p20x.dtsi        |  7 +++++++
 arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi             |  6 ++++++
 arch/arm64/boot/dts/amlogic/meson-gxl-s905d-p230.dts    |  8 +++++++-
 .../boot/dts/amlogic/meson-gxl-s905x-nexbox-a95x.dts    |  7 +++++++
 arch/arm64/boot/dts/amlogic/meson-gxl-s905x-p212.dts    |  7 +++++++
 arch/arm64/boot/dts/amlogic/meson-gxl.dtsi              |  6 ++++++
 arch/arm64/boot/dts/amlogic/meson-gxm-nexbox-a1.dts     |  7 +++++++
 10 files changed, 77 insertions(+), 2 deletions(-)

-- 
1.9.1
