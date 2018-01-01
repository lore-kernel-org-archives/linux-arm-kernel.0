From: andy.gross@linaro.org (Andy Gross)
Date: Mon,  1 Jan 2018 00:53:25 -0600
Subject: [GIT PULL] Qualcomm ARM64 Defconfig updates for 4.16
Message-ID: <1514789609-4133-1-git-send-email-andy.gross@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 4fbd8d194f06c8a3fd2af1ce560ddb31f7ec8323:

  Linux 4.15-rc1 (2017-11-26 16:01:47 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/agross/linux.git tags/qcom-arm64-defconfig-for-4.16

for you to fetch changes up to d2fa1f37d21bf9729ae9ee79cb6bfc8de1f0a9a4:

  arm64: defconfig: remove CONFIG_USB_QCOM_8X16_PHY (2017-12-21 13:28:11 -0600)

----------------------------------------------------------------
Qualcomm ARM64 Based defconfig Updates for v4.16

* Remove legacy QCOM config options

----------------------------------------------------------------
Alex Elder (3):
      arm64: defconfig: remove CONFIG_USB_EHCI_MSM
      arm64: defconfig: remove CONFIG_USB_MSM_OTG
      arm64: defconfig: remove CONFIG_USB_QCOM_8X16_PHY

 arch/arm64/configs/defconfig | 3 ---
 1 file changed, 3 deletions(-)
