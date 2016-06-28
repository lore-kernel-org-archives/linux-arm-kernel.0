From: andy.gross@linaro.org (Andy Gross)
Date: Mon, 27 Jun 2016 21:51:35 -0500
Subject: [GIT PULL] Qualcomm ARM64 DT Updates for v4.8
Message-ID: <1467082295-22917-1-git-send-email-andy.gross@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 1a695a905c18548062509178b98bc91e67510864:

  Linux 4.7-rc1 (2016-05-29 09:29:24 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/agross/linux.git tags/qcom-arm64-for-4.8

for you to fetch changes up to a6702798980812c666a5c32e6b12c24f72ef7245:

  arm64: dts: msm8996: add sdc2 support (2016-06-24 22:30:17 -0500)

----------------------------------------------------------------
Qualcomm ARM64 Updates for v4.8

* Enable assorted peripherals on APQ8016 SBC
* Update reserved memory on MSM8916
* Add MSM8996 peripheral support
* Add SCM firmware node on MSM8916
* Add PMU node on MSM8916
* Add PSCI cpuidle support on MSM8916

----------------------------------------------------------------
Andy Gross (1):
      arm64: dts: msm8916: Add SCM firmware node

Bjorn Andersson (1):
      ARM: dts: msm8916: Update reserved-memory

Georgi Djakov (1):
      arm64: dts: apq8016-sbc: Add DT node for the uSD SDHC interface

Lina Iyer (1):
      ARM64: dts: Add PSCI cpuidle support for MSM8916

Srinivas Kandagatla (17):
      arm64: dts: qcom: apq8016-sbc: enable bam dma node.
      arm64: dts: msm8996: add msmgpio label
      arm64: dts: msm8996: add blsp2_uart1 pinctrl
      arm64: dts: msm8996: add blsp2_uart2 pinctrl nodes.
      arm64: dts: msm8996: add support blsp2_uart2
      arm64: dts: msm8996: add blsp1_i2c2 pinctrl nodes.
      arm64: dts: msm8996: add support to blsp1_i2c2 device
      arm64: dts: msm8996: add blsp2_i2c1 pinctrl
      arm64: dts: msm8996: add support to blsp2_i2c1
      arm64: dts: msm8996: add support to blsp2_i2c0 pinctrl
      arm64: dts: msm8996: add support to blsp2_i2c0
      arm64: dts: msm8996: add support to blsp1_spi0 pinctrl
      arm64: dts: msm8996: add support to blsp1_spi0
      arm64: dts: msm8996: add support to blsp2_spi5 pinctrl
      arm64: dts: msm8996: add support to blsp2_spi5
      arm64: dts: msm8996: add sdc2 pinctrl
      arm64: dts: msm8996: add sdc2 support

Stephen Boyd (1):
      arm64: dts: qcom: Add msm8916 PMU node

 arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi  |  16 ++
 arch/arm64/boot/dts/qcom/msm8916.dtsi      |  78 +++++++-
 arch/arm64/boot/dts/qcom/msm8996-pins.dtsi | 303 +++++++++++++++++++++++++++++
 arch/arm64/boot/dts/qcom/msm8996.dtsi      | 103 +++++++++-
 4 files changed, 496 insertions(+), 4 deletions(-)
 create mode 100644 arch/arm64/boot/dts/qcom/msm8996-pins.dtsi
