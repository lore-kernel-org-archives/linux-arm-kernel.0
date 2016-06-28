From: andy.gross@linaro.org (Andy Gross)
Date: Mon, 27 Jun 2016 21:53:16 -0500
Subject: [GIT PULL] Qualcomm SoC Updates for v4.8
Message-ID: <1467082396-23036-1-git-send-email-andy.gross@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 1a695a905c18548062509178b98bc91e67510864:

  Linux 4.7-rc1 (2016-05-29 09:29:24 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/agross/linux.git tags/qcom-soc-for-4.8

for you to fetch changes up to 78700c0a2102dbe0fb35b6c146a639dc4622036f:

  ARM: qcom: Add support for MDM9615 (2016-06-24 22:57:23 -0500)

----------------------------------------------------------------
Qualcomm ARM Based SoC Updates for v4.8

* Add MSM9615 support

----------------------------------------------------------------
Neil Armstrong (1):
      ARM: qcom: Add support for MDM9615

 arch/arm/mach-qcom/Kconfig | 4 ++++
 arch/arm/mach-qcom/board.c | 1 +
 2 files changed, 5 insertions(+)
