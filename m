From: andy.gross@linaro.org (Andy Gross)
Date: Thu,  6 Apr 2017 21:47:33 -0500
Subject: [GIT PULL] Qualcomm ARM64 DT Updates for v4.12
Message-ID: <1491533253-13389-1-git-send-email-andy.gross@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit c1ae3cfa0e89fa1a7ecc4c99031f5e9ae99d9201:

  Linux 4.11-rc1 (2017-03-05 12:59:56 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/agross/linux.git tags/qcom-arm64-for-4.12

for you to fetch changes up to 6c8583d6feeb45a4c812114f6087e9911b93ea48:

  arm64: dts: msm8996: Add ADSP PIL node (2017-03-29 13:43:52 -0500)

----------------------------------------------------------------
Qualcomm ARM64 Updates for v4.12

* Fixup MSM8996 SMP2P and add ADSP PIL / SLPI SMP2P node
* Replace PMU compatible w/ A53 specific one
* Add APQ8016 ramoops
* Update MSM8916 hexagon node
* Add PM8994 RTC

----------------------------------------------------------------
Bjorn Andersson (4):
      arm64: dts: qcom: msm8996: Fixup smp2p node
      arm64: dts: qcom: msm8916: Update hexagon node
      arm64: dts: apq8016-sbc: Add ramoops
      arm64: dts: qcom: pm8994: Add rtc node

Sarangdhar Joshi (1):
      arm64: dts: msm8996: Add ADSP PIL node

Stephen Boyd (1):
      arm64: dts: qcom: Replace PMU compatible with a53 specific one

avaneesh dwivedi (1):
      arm64: dts: msm8996: Add SLPI SMP2P dt node.

 arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi | 11 ++++++++
 arch/arm64/boot/dts/qcom/msm8916.dtsi     | 26 +++++++++--------
 arch/arm64/boot/dts/qcom/msm8996.dtsi     | 46 ++++++++++++++++++++++++++++++-
 arch/arm64/boot/dts/qcom/pm8994.dtsi      |  7 +++++
 4 files changed, 78 insertions(+), 12 deletions(-)
