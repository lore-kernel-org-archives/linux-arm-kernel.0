From: andy.gross@linaro.org (Andy Gross)
Date: Thu, 17 Dec 2015 14:34:24 -0600
Subject: [GIT PULL] Qualcomm ARM64 Updates for v4.5
Message-ID: <1450384464-4421-1-git-send-email-andy.gross@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 8005c49d9aea74d382f474ce11afbbc7d7130bec:

  Linux 4.4-rc1 (2015-11-15 17:00:27 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/agross/linux.git tags/qcom-arm64-for-4.5

for you to fetch changes up to 9e1dfb858de43bb3dfbbb32cec57433e9b250dee:

  arm64: dts: Add PM8916 support on MSM8916 (2015-12-16 23:01:44 -0600)

----------------------------------------------------------------
Qualcomm ARM64 Updates for v4.5

* Add fixed rate oscillators to dts
* Fixup PMIC alias and properties
* Change 8916-MTP compatible to be compliant with new scheme
* Fix 8x16 UART pinctrl configuration
* Add SMEM, RPM/SMD, and PM8916 support on MSM8916

----------------------------------------------------------------
Andy Gross (3):
      arm64: dts: qcom: Add MSM8916 SMEM nodes
      arm64: dts: qcom: Add RPM/SMD support on MSM8916
      arm64: dts: Add PM8916 support on MSM8916

Georgi Djakov (1):
      arm64: dts: qcom: msm8916: Add fixed rate on-board oscillators

Ivan T. Ivanov (2):
      arm64: dts: qcom: 8x16: UART1 add CTS_N, RTS_N pin configurations
      arm64: dts: qcom: 8x16: UART1 and UART2 use DMA for RX and TX

Srinivas Kandagatla (2):
      arm64: dts: fix the i2c aliasing to match to schematics.
      arm64: dts: set the default i2c pin drive strength to 16mA

Stephen Boyd (2):
      arm64: dts: qcom: Make msm8916-mtp compatible string compliant
      arm64: dts: qcom: Alias pm8916 on msm8916 devices

 arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi  |   4 ++
 arch/arm64/boot/dts/qcom/msm8916-mtp.dts   |   2 +-
 arch/arm64/boot/dts/qcom/msm8916-mtp.dtsi  |   1 +
 arch/arm64/boot/dts/qcom/msm8916-pins.dtsi |  19 +++--
 arch/arm64/boot/dts/qcom/msm8916.dtsi      | 107 +++++++++++++++++++++++++++++
 arch/arm64/boot/dts/qcom/pm8916.dtsi       |   6 +-
 6 files changed, 128 insertions(+), 11 deletions(-)
