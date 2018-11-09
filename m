From: andy.gross@linaro.org (Andy Gross)
Date: Fri,  9 Nov 2018 17:51:31 -0600
Subject: [GIT PULL] Qualcomm ARM64 DT Fixes for 4.20-rc1
Message-ID: <1541807491-13259-1-git-send-email-andy.gross@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 651022382c7f8da46cb4872a545ee1da6d097d2a:

  Linux 4.20-rc1 (2018-11-04 15:37:52 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/agross/linux.git tags/qcom-fixes-for-4.20-rc1

for you to fetch changes up to 9134586715e389fe90d9d28cb37a668f374d686a:

  arm64: dts: qcom: msm8998: Reserve gpio ranges on MTP (2018-11-09 17:17:53 -0600)

----------------------------------------------------------------
Qualcomm ARM64 DT Fixes for 4.20-rc1

* Fix reserved gpio ranges for SDM845 and MSM8998

----------------------------------------------------------------
Bjorn Andersson (2):
      arm64: dts: sdm845-mtp: Reserve reserved gpios
      arm64: dts: qcom: msm8998: Reserve gpio ranges on MTP

 arch/arm64/boot/dts/qcom/msm8998-mtp.dtsi | 4 ++++
 arch/arm64/boot/dts/qcom/sdm845-mtp.dts   | 4 ++++
 2 files changed, 8 insertions(+)
