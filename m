From: andy.gross@linaro.org (Andy Gross)
Date: Fri,  2 Sep 2016 22:57:06 -0500
Subject: [GIT PULL] Qualcomm SoC Updates for v4.9
Message-ID: <1472875026-17912-1-git-send-email-andy.gross@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 29b4817d4018df78086157ea3a55c1d9424a7cfc:

  Linux 4.8-rc1 (2016-08-07 18:18:00 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/agross/linux.git tags/qcom-soc-for-4.9

for you to fetch changes up to 80483c3abf8423e6ec4fb63647a8e2e1f5976801:

  ARM: qcom: Cleanup/Remove unnecessary board file (2016-08-23 15:46:05 -0500)

----------------------------------------------------------------
Qualcomm ARM Based SoC Updates for v4.9

* Remove unnecessary QCOM board file

----------------------------------------------------------------
Andy Gross (1):
      ARM: qcom: Cleanup/Remove unnecessary board file

 arch/arm/mach-qcom/Makefile |  1 -
 arch/arm/mach-qcom/board.c  | 31 -------------------------------
 2 files changed, 32 deletions(-)
 delete mode 100644 arch/arm/mach-qcom/board.c
