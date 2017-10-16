From: andy.gross@linaro.org (Andy Gross)
Date: Mon, 16 Oct 2017 14:31:29 -0500
Subject: [GIT PULL] Qualcomm Defconfig updates for 4.15
In-Reply-To: <1508182291-23352-1-git-send-email-andy.gross@linaro.org>
References: <1508182291-23352-1-git-send-email-andy.gross@linaro.org>
Message-ID: <1508182291-23352-3-git-send-email-andy.gross@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 2bd6bf03f4c1c59381d62c61d03f6cc3fe71f66e:

  Linux 4.14-rc1 (2017-09-16 15:47:51 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/agross/linux.git tags/qcom-defconfig-for-4.15

for you to fetch changes up to 1dfd49957321ce11813af64f10ae70c44c345ea2:

  ARM: qcom_defconfig: Enable Z2 Tablet related options (2017-10-11 16:41:02 -0500)

----------------------------------------------------------------
Qualcomm ARM Based defconfig Updates for v4.15

* Enable Sony Z2 tablet options
* Enable USB on APQ8064/MSM8974
* Fixup/catchup config to support newer options

----------------------------------------------------------------
Bjorn Andersson (3):
      ARM: qcom_defconfig: Resync with new Kconfig options
      ARM: qcom_defconfig: Disable DEBUG_GPIO
      ARM: qcom_defconfig: Enable Z2 Tablet related options

Stephen Boyd (1):
      ARM: qcom_defconfig: Enable configs for USB on apq8064/msm8974

 arch/arm/configs/qcom_defconfig | 42 ++++++++++++++++++++++++++---------------
 1 file changed, 27 insertions(+), 15 deletions(-)
