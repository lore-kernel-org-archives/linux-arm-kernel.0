From: andy.gross@linaro.org (Andy Gross)
Date: Fri, 25 May 2018 17:34:53 -0500
Subject: [GIT PULL] Qualcomm ARM64 Defconfig updates for 4.18
Message-ID: <1527287693-26646-1-git-send-email-andy.gross@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 60cc43fc888428bb2f18f08997432d426a243338:

  Linux 4.17-rc1 (2018-04-15 18:24:20 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/agross/linux.git tags/qcom-arm64-defconfig-for-4.18

for you to fetch changes up to b741377f1ff72a17e3b06e4b506b13f5c6158b1c:

  arm64: defconfig: Enable PCIe on msm8996 and db820c (2018-05-25 15:49:12 -0500)

----------------------------------------------------------------
Qualcomm ARM64 Based defconfig Updates for v4.18

* Enable UFS and PCIe for Qualcomm msm8996/db820c

----------------------------------------------------------------
Bjorn Andersson (2):
      arm64: defconfig: Enable UFS on msm8996
      arm64: defconfig: Enable PCIe on msm8996 and db820c

 arch/arm64/configs/defconfig | 10 ++++++++++
 1 file changed, 10 insertions(+)
