From: andy.gross@linaro.org (Andy Gross)
Date: Sat, 21 Jul 2018 23:10:18 -0500
Subject: [GIT PULL] Qualcomm ARM64 Defconfig updates for 4.19
Message-ID: <1532232622-18275-1-git-send-email-andy.gross@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit ce397d215ccd07b8ae3f71db689aedb85d56ab40:

  Linux 4.18-rc1 (2018-06-17 08:04:49 +0900)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/agross/linux.git tags/qcom-arm64-defconfig-for-4.19

for you to fetch changes up to f8120d61ceb7c016e5a450a98b8d08ae69d82e22:

  arm64: defconfig: Enable CONFIG_MTD_NAND_QCOM for IPQ8074 (2018-07-21 15:19:09 -0500)

----------------------------------------------------------------
Qualcomm ARM64 Based defconfig Updates for v4.19

* Enable Qualcomm NAND driver

----------------------------------------------------------------
Abhishek Sahu (1):
      arm64: defconfig: Enable CONFIG_MTD_NAND_QCOM for IPQ8074

 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)
