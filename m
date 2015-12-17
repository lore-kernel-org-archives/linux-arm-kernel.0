From: andy.gross@linaro.org (Andy Gross)
Date: Thu, 17 Dec 2015 14:34:12 -0600
Subject: [GIT PULL] Qualcomm defconfig Updates for v4.5
Message-ID: <1450384452-4379-1-git-send-email-andy.gross@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 8005c49d9aea74d382f474ce11afbbc7d7130bec:

  Linux 4.4-rc1 (2015-11-15 17:00:27 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/agross/linux.git tags/qcom-defconfig-for-4.5

for you to fetch changes up to 439481026554df8c8909962e956810c6fa93eb23:

  ARM: defconfig: qcom: Enable SSBI drivers (2015-12-16 15:11:31 -0600)

----------------------------------------------------------------
Qualcomm ARM Based defconfig Updates for v4.5

* Enable newly supported devices on Qualcomm platforms
* Enable HAVE_ARM_ARCH_TIMER

----------------------------------------------------------------
Bjorn Andersson (1):
      ARM: defconfig: Update qcom_defconfig

Stephen Boyd (2):
      ARM: qcom_defconfig: Enable HAVE_ARM_ARCH_TIMER
      ARM: defconfig: qcom: Enable SSBI drivers

 arch/arm/configs/qcom_defconfig | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)
