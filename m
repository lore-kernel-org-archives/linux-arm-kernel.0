From: andy.gross@linaro.org (Andy Gross)
Date: Mon, 27 Jun 2016 21:48:34 -0500
Subject: [GIT PULL] Qualcomm Defconfig Updates for v4.8
Message-ID: <1467082114-22716-1-git-send-email-andy.gross@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 1a695a905c18548062509178b98bc91e67510864:

  Linux 4.7-rc1 (2016-05-29 09:29:24 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/agross/linux.git tags/qcom-defconfig-for-4.8

for you to fetch changes up to 8aa788d3e59a14845c95446ac25a267e75711374:

  ARM: configs: qualcomm: Add MDM9615 missing defconfigs (2016-06-27 16:51:06 -0500)

----------------------------------------------------------------
Qualcomm ARM Based defconfig Updates for v4.8

* Enable MSM9615 board support
* Enable MSM8660 pinctrl support

----------------------------------------------------------------
Linus Walleij (1):
      ARM: defconfig: enable the MSM8660 pin controller

Neil Armstrong (1):
      ARM: configs: qualcomm: Add MDM9615 missing defconfigs

 arch/arm/configs/qcom_defconfig | 8 ++++++++
 1 file changed, 8 insertions(+)
