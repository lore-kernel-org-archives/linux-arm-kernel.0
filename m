From: andy.gross@linaro.org (Andy Gross)
Date: Fri, 25 May 2018 17:41:05 -0500
Subject: [GIT PULL] Qualcomm ARM64 DT updates for 4.18 - Part 2
Message-ID: <1527288065-27438-1-git-send-email-andy.gross@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 57fc67ef0d35af11fbb1b928e359b370889994ae:

  arm64: dts: qcom: msm8996: Add ufs related nodes (2018-05-22 23:29:03 -0500)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/agross/linux.git tags/qcom-arm64-for-4.18-2

for you to fetch changes up to d8f8d467f53a192041193fc17176ceb013f4d041:

  arm64: dts: apq8096-db820c: Removed bt-en-1-8v regulator (2018-05-25 16:21:05 -0500)

----------------------------------------------------------------
Qualcomm ARM64 Updates for v4.18 Part 2

* Fix UFS GDSC on msm8996
* Remove unused BT node regulator
* Correct WLAN PCIe regulator endpoint name

----------------------------------------------------------------
Bjorn Andersson (1):
      arm64: dts: qcom: msm8996: Use UFS_GDSC for UFS

Niklas Cassel (1):
      arm64: dts: fix regulator property name for wlan pcie endpoint

Thierry Escande (1):
      arm64: dts: apq8096-db820c: Removed bt-en-1-8v regulator

 arch/arm64/boot/dts/qcom/apq8096-db820c-pmic-pins.dtsi |  2 +-
 arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi           | 16 +---------------
 arch/arm64/boot/dts/qcom/msm8996.dtsi                  |  4 ++--
 3 files changed, 4 insertions(+), 18 deletions(-)
