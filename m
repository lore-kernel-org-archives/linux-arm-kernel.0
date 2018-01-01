From: andy.gross@linaro.org (Andy Gross)
Date: Mon,  1 Jan 2018 00:53:27 -0600
Subject: [GIT PULL] Qualcomm Defconfig updates for 4.16
In-Reply-To: <1514789609-4133-1-git-send-email-andy.gross@linaro.org>
References: <1514789609-4133-1-git-send-email-andy.gross@linaro.org>
Message-ID: <1514789609-4133-3-git-send-email-andy.gross@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 4fbd8d194f06c8a3fd2af1ce560ddb31f7ec8323:

  Linux 4.15-rc1 (2017-11-26 16:01:47 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/agross/linux.git tags/qcom-defconfig-for-4.16

for you to fetch changes up to b756f49a339aeca053ab71dd089a1868c3932f81:

  ARM: qcom_defconfig: Enable Frambuffer console support (2017-12-21 13:28:31 -0600)

----------------------------------------------------------------
Qualcomm ARM Based defconfig Updates for v4.16

* Enable framebuffer, IOMMU, and DRM options

----------------------------------------------------------------
Srinivas Kandagatla (3):
      ARM: qcom_defconfig: Enable DRM for 8064 display
      ARM: qcom_defconfig: enable MSM IOMMU for display
      ARM: qcom_defconfig: Enable Frambuffer console support

 arch/arm/configs/qcom_defconfig | 3 +++
 1 file changed, 3 insertions(+)
