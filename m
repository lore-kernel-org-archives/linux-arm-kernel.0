From: galak@codeaurora.org (Kumar Gala)
Date: Tue, 26 May 2015 14:23:24 -0500 (CDT)
Subject: [GIT PULL] qcom arm64 dt changes for 4.2
Message-ID: <alpine.DEB.2.02.1505261421580.24858@galak-ubuntu.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit b787f68c36d49bb1d9236f403813641efa74a031:

   Linux 4.1-rc1 (2015-04-26 17:59:10 -0700)

are available in the git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/galak/linux-qcom.git tags/qcom-arm64-for-4.2

for you to fetch changes up to a190a1ce9a51d3edd52de1b721276d780e0906bb:

   arm64: dts: qcom: Add initial set of PMIC and SoC pins for APQ8016 SBC board (2015-04-27 16:09:12 -0500)

----------------------------------------------------------------
Qualcomm ARM64 Updates for v4.2

* Added SPMI PMIC Arbiter device tree node for MSM8916
* Added 8x16 chipset SPMI PMIC's nodes
* Added MSM8916 restart device node
* Added initial set of PMIC and SoC pins for APQ8016 SBC board

----------------------------------------------------------------
Ivan T. Ivanov (4):
       arm64: dts: qcom: Add SPMI PMIC Arbiter node for MSM8916
       arm64: dts: qcom: Add 8x16 chipset SPMI PMIC's nodes
       arm64: dts: qcom: Add MSM8916 restart device node
       arm64: dts: qcom: Add initial set of PMIC and SoC pins for APQ8016 SBC board

  .../arm64/boot/dts/qcom/apq8016-sbc-pmic-pins.dtsi | 30 +++++++
  arch/arm64/boot/dts/qcom/apq8016-sbc-soc-pins.dtsi | 21 +++++
  arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi          |  3 +
  arch/arm64/boot/dts/qcom/msm8916-mtp.dtsi          |  1 +
  arch/arm64/boot/dts/qcom/msm8916.dtsi              | 25 +++++-
  arch/arm64/boot/dts/qcom/pm8916.dtsi               | 99 ++++++++++++++++++++++
  6 files changed, 178 insertions(+), 1 deletion(-)
  create mode 100644 arch/arm64/boot/dts/qcom/apq8016-sbc-pmic-pins.dtsi
  create mode 100644 arch/arm64/boot/dts/qcom/apq8016-sbc-soc-pins.dtsi
  create mode 100644 arch/arm64/boot/dts/qcom/pm8916.dtsi

--
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
