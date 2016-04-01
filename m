From: andy.gross@linaro.org (Andy Gross)
Date: Fri,  1 Apr 2016 14:59:36 -0500
Subject: [GIT PULL] Qualcomm Driver Updates for v4.7
Message-ID: <1459540776-7056-1-git-send-email-andy.gross@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit f55532a0c0b8bb6148f4e07853b876ef73bc69ca:

  Linux 4.6-rc1 (2016-03-26 16:03:24 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/agross/linux.git tags/qcom-drivers-for-4.7

for you to fetch changes up to d24a7dab5b8fa6717d7a3917a634b561dcee312f:

  ARM: qcom: Drop ARCH_MSM* configs (2016-03-31 17:37:31 -0500)

----------------------------------------------------------------
Qualcomm ARM Based Driver Updates for v4.7

* Drop ARCH_MSM* configs and fixup clocksource support

----------------------------------------------------------------
Stephen Boyd (2):
      ARM: qcom: Make an option for qcom 'a-family' platforms
      ARM: qcom: Drop ARCH_MSM* configs

 arch/arm/Makefile          |  3 +--
 arch/arm/mach-qcom/Kconfig | 17 +++++++++--------
 2 files changed, 10 insertions(+), 10 deletions(-)
