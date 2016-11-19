From: andy.gross@linaro.org (Andy Gross)
Date: Fri, 18 Nov 2016 23:57:11 -0600
Subject: [GIT PULL v2] Qualcomm Device Tree Changes for v4.10
Message-ID: <1479535031-14817-1-git-send-email-andy.gross@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 1001354ca34179f3db924eb66672442a173147dc:

  Linux 4.9-rc1 (2016-10-15 12:17:50 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/agross/linux.git tags/qcom-dts-for-4.10-1

for you to fetch changes up to 4c52ffc708c90b2985f941db5490145530e4df69:

  ARM: dts: add SMSC ethernet on the APQ8060 Dragonboard (2016-11-18 23:30:32 -0600)

----------------------------------------------------------------
Qualcomm Device Tree Changes for v4.10 - v2

* Add EBI2 support to MSM8660
* Add SMSC ethernet support to APQ8060
* Add support for display, pstore, iommu, and hdmi to APQ8064
* Add SDHCI node to MSM8974 Hammerhead
* Add WP8548 MangOH board support (MDM9615)

----------------------------------------------------------------
Archit Taneja (2):
      arm: dts: qcom: apq8064: Add display DT nodes
      arm: dts: qcom: apq8064-ifc6410: Add HDMI support

Bhushan Shah (1):
      ARM: dts: qcom: msm8974-hammerhead: Add sdhci1 node

John Stultz (3):
      arm: dts: qcom: apq8064: Add dsi, gpu and iommu nodes
      arm: dts: qcom: apq8064-nexus7: Add DSI and panel nodes
      arm: dts: qcom: apq8064-nexus7: Add pstore support to nexus7

Linus Walleij (2):
      ARM: dts: add EBI2 to the Qualcomm MSM8660 DTSI
      ARM: dts: add SMSC ethernet on the APQ8060 Dragonboard

Neil Armstrong (5):
      ARM: dts: Add MDM9615 dtsi
      dt-bindings: qcom: Add MDM9615 bindings
      ARM: dts: Add Sierra Wireless WP8548 dtsi
      ARM: dts: Add WP8548 based MangOH Green board DTS
      dt-bindings: arm: Add Sierra Wireless modules bindings

 Documentation/devicetree/bindings/arm/qcom.txt     |   1 +
 Documentation/devicetree/bindings/arm/swir.txt     |  12 +
 arch/arm/boot/dts/Makefile                         |   3 +-
 arch/arm/boot/dts/qcom-apq8060-dragonboard.dts     | 119 +++++
 arch/arm/boot/dts/qcom-apq8064-asus-nexus7-flo.dts |  77 ++-
 arch/arm/boot/dts/qcom-apq8064-ifc6410.dts         |  74 +++
 arch/arm/boot/dts/qcom-apq8064.dtsi                | 321 ++++++++++++
 .../boot/dts/qcom-mdm9615-wp8548-mangoh-green.dts  | 281 +++++++++++
 arch/arm/boot/dts/qcom-mdm9615-wp8548.dtsi         | 170 +++++++
 arch/arm/boot/dts/qcom-mdm9615.dtsi                | 557 +++++++++++++++++++++
 arch/arm/boot/dts/qcom-msm8660.dtsi                |  17 +
 .../dts/qcom-msm8974-lge-nexus5-hammerhead.dts     |  29 ++
 12 files changed, 1658 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/swir.txt
 create mode 100644 arch/arm/boot/dts/qcom-mdm9615-wp8548-mangoh-green.dts
 create mode 100644 arch/arm/boot/dts/qcom-mdm9615-wp8548.dtsi
 create mode 100644 arch/arm/boot/dts/qcom-mdm9615.dtsi
