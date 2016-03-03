From: andy.gross@linaro.org (Andy Gross)
Date: Wed,  2 Mar 2016 22:40:45 -0600
Subject: [GIT PULL] Qualcomm Driver Updates for v4.6
Message-ID: <1456980045-4177-1-git-send-email-andy.gross@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 92e963f50fc74041b5e9e744c330dca48e04f08d:

  Linux 4.5-rc1 (2016-01-24 13:06:47 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/agross/linux.git tags/qcom-drivers-for-4.6

for you to fetch changes up to b07fe90b6cce233af1aed675427b52a42b35e9cf:

  ARM: qcom: Drop ARCH_MSM* configs (2016-03-02 21:47:38 -0600)

----------------------------------------------------------------
Qualcomm ARM Based Driver Updates for v4.6

* Drop ARCH_MSM* configs and fixup clocksource support

----------------------------------------------------------------
Stephen Boyd (2):
      ARM: qcom: Make an option for qcom 'a-family' platforms
      ARM: qcom: Drop ARCH_MSM* configs

 arch/arm/Makefile          |  3 +--
 arch/arm/mach-qcom/Kconfig | 17 +++++++++--------
 2 files changed, 10 insertions(+), 10 deletions(-)
