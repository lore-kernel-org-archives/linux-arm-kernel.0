From: andy.gross@linaro.org (Andy Gross)
Date: Tue, 13 Jun 2017 15:48:24 -0400
Subject: [GIT PULL] Qualcomm ARM64 Defconfig updates for 4.13
Message-ID: <1497383309-14226-1-git-send-email-andy.gross@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 2ea659a9ef488125eb46da6eb571de5eae5c43f6:

  Linux 4.12-rc1 (2017-05-13 13:19:49 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/agross/linux.git tags/qcom-arm64-defconfig-for-4.13

for you to fetch changes up to 28fc880f3e0087ca84acf5217a226fe9b4bc57d8:

  arm64: defconfig: Switch to the correct Qualcomm SMD driver (2017-06-05 21:56:20 -0500)

----------------------------------------------------------------
Qualcomm ARM64 Based defconfig Updates for v4.13

* Switch to use the SMD RPMSG driver

----------------------------------------------------------------
Georgi Djakov (1):
      arm64: defconfig: Switch to the correct Qualcomm SMD driver

 arch/arm64/configs/defconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
