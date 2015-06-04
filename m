From: ivan.ivanov@linaro.org (Ivan T. Ivanov)
Date: Thu,  4 Jun 2015 12:18:59 +0300
Subject: [PATCH 0/7] arm64: dts: qcom: msm8916 fixes and updates
Message-ID: <1433409546-23995-1-git-send-email-ivan.ivanov@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Following patches add configuration nodes for SPI, I2C, USB and SDHC devices
found in msm8916 and related pinctrl definitions. Also several GPIO have been
incorrectly assigned and are fixed now. LED control devices for apq 8016-sbc
board are added.

Regards,
Ivan

Ivan T. Ivanov (6):
  arm64: dts: qcom: Extend msm8916 pinctrl device coverage
  arm64: dts: qcom: Add msm8916 BLSP device nodes
  arm64: dts: qcom: Add msm8916 USB configuration nodes
  arm64: dts: qcom: apq8016-sbc: Don't hog client driver pins
  arm64: dts: qcom: Fix apq8016-sbc board USB related pin definitions
  arm64: dts: qcom: Add apq8016-sbc board LED's related device nodes

Srinivas Kandagatla (1):
  arm64: dts: qcom: Add msm8916 sdhci configuration nodes

 .../arm64/boot/dts/qcom/apq8016-sbc-pmic-pins.dtsi |  34 +-
 arch/arm64/boot/dts/qcom/apq8016-sbc-soc-pins.dtsi |  14 +-
 arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi          |  51 +++
 arch/arm64/boot/dts/qcom/msm8916-pins.dtsi         | 430 +++++++++++++++++++++
 arch/arm64/boot/dts/qcom/msm8916.dtsi              | 227 +++++++++--
 5 files changed, 708 insertions(+), 48 deletions(-)
 create mode 100644 arch/arm64/boot/dts/qcom/msm8916-pins.dtsi

--
1.9.1
