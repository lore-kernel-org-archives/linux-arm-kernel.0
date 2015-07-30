From: agross@codeaurora.org (Andy Gross)
Date: Thu, 30 Jul 2015 16:17:03 -0500
Subject: [GIT PULL] qcom arm64 dt changes for 4.3
Message-ID: <1438291023-17573-1-git-send-email-agross@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit d770e558e21961ad6cfdf0ff7df0eb5d7d4f0754:

  Linux 4.2-rc1 (2015-07-05 11:01:52 -0700)

are available in the git repository at:

  git://codeaurora.org/quic/kernel/agross-msm.git tags/qcom-arm64-for-4.3

for you to fetch changes up to 9943230c8860178a6f6409f0ba19167c0a46a71b:

  arm64: dts: qcom: Add apq8016-sbc board LED's related device nodes (2015-07-28 16:19:13 -0500)

----------------------------------------------------------------
* Add BLSP and required pinctrl info for MSM8916
* Add SDHC aliases and nodes for MSM8916
* Add USB nodes for MSM8916
* Add APQ8016 SBC specific USB configuration
* Add APQ8016 LED configuration

----------------------------------------------------------------
Ivan T. Ivanov (6):
      arm64: dts: qcom: Extend msm8916 pinctrl device coverage
      arm64: dts: qcom: Add msm8916 BLSP device nodes
      arm64: dts: qcom: Add msm8916 USB configuration nodes
      arm64: dts: qcom: apq8016-sbc: Don't hog client driver pins
      arm64: dts: qcom: Fix apq8016-sbc board USB related pin definitions
      arm64: dts: qcom: Add apq8016-sbc board LED's related device nodes

Srinivas Kandagatla (1):
      arm64: dts: qcom: Add msm8916 sdhci configuration nodes

 .../arm64/boot/dts/qcom/apq8016-sbc-pmic-pins.dtsi |   34 +-
 arch/arm64/boot/dts/qcom/apq8016-sbc-soc-pins.dtsi |   14 +-
 arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi          |   51 +++
 arch/arm64/boot/dts/qcom/msm8916-pins.dtsi         |  430 ++++++++++++++++++++
 arch/arm64/boot/dts/qcom/msm8916.dtsi              |  227 +++++++++--
 5 files changed, 708 insertions(+), 48 deletions(-)
 create mode 100644 arch/arm64/boot/dts/qcom/msm8916-pins.dtsi
