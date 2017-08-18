From: andy.gross@linaro.org (Andy Gross)
Date: Fri, 18 Aug 2017 16:02:04 -0500
Subject: [GIT PULL] Qualcomm ARM64 DT updates for 4.14 Part 2
Message-ID: <1503090124-1658-1-git-send-email-andy.gross@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 6a6729f384365db9443a867bf8cf22255b3da582:

  arm64: dts: qcom: msm8916: Add IOMMU support (2017-08-16 10:09:03 -0500)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/agross/linux.git tags/qcom-arm64-for-4.14-2

for you to fetch changes up to 41dac73e243d42b89fd10dfd331824d4a39099ac:

  arm64: dts: Add ipq8074 SoC and HK01 board support (2017-08-18 14:47:25 -0500)

----------------------------------------------------------------
Qualcomm ARM64 Updates for v4.14 Part 2

* Add IPQ8074 SoC and HK01 board support

----------------------------------------------------------------
Varadarajan Narayanan (1):
      arm64: dts: Add ipq8074 SoC and HK01 board support

 arch/arm64/boot/dts/qcom/Makefile         |   1 +
 arch/arm64/boot/dts/qcom/ipq8074-hk01.dts |  52 ++++++++
 arch/arm64/boot/dts/qcom/ipq8074.dtsi     | 194 ++++++++++++++++++++++++++++++
 3 files changed, 247 insertions(+)
 create mode 100644 arch/arm64/boot/dts/qcom/ipq8074-hk01.dts
 create mode 100644 arch/arm64/boot/dts/qcom/ipq8074.dtsi
