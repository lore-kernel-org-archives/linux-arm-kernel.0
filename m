From: andy.gross@linaro.org (Andy Gross)
Date: Mon, 16 Oct 2017 14:31:28 -0500
Subject: [GIT PULL] Qualcomm ARM64 Defconfig updates for 4.15
In-Reply-To: <1508182291-23352-1-git-send-email-andy.gross@linaro.org>
References: <1508182291-23352-1-git-send-email-andy.gross@linaro.org>
Message-ID: <1508182291-23352-2-git-send-email-andy.gross@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 2bd6bf03f4c1c59381d62c61d03f6cc3fe71f66e:

  Linux 4.14-rc1 (2017-09-16 15:47:51 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/agross/linux.git tags/qcom-arm64-defconfig-for-4.15

for you to fetch changes up to b8eb03a7cf1b767c339771201f9cb974cea1145a:

  arm64: defconfig: re-enable Qualcomm DB410c USB (2017-10-16 13:56:52 -0500)

----------------------------------------------------------------
Qualcomm ARM64 Based defconfig Updates for v4.15

* Enable QCOM IOMMU
* Enable Qualcomm USB options

----------------------------------------------------------------
Alex Elder (1):
      arm64: defconfig: re-enable Qualcomm DB410c USB

Nicolas Dechesne (1):
      arm64: defconfig: Enable QCOM_IOMMU

 arch/arm64/configs/defconfig | 4 ++++
 1 file changed, 4 insertions(+)
