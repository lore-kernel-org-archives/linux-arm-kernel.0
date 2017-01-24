From: andy.gross@linaro.org (Andy Gross)
Date: Tue, 24 Jan 2017 00:52:32 -0600
Subject: [GIT PULL] Qualcomm SoC Updates for v4.11
Message-ID: <1485240752-8339-1-git-send-email-andy.gross@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 7ce7d89f48834cefece7804d38fc5d85382edf77:

  Linux 4.10-rc1 (2016-12-25 16:13:08 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/agross/linux.git tags/qcom-soc-for-4.11

for you to fetch changes up to aabde95fc543a9ca68df06b9c7ea8e699702d7ad:

  firmware: qcom: scm: Fix interrupted SCM calls (2017-01-23 10:01:49 -0600)

----------------------------------------------------------------
Qualcomm ARM Based SoC Updates for v4.11

* Add SMCC quirk support
* Add Qualcomm SCM quirk to fix interrupted calls

----------------------------------------------------------------
Andy Gross (2):
      arm: kernel: Add SMC structure parameter
      firmware: qcom: scm: Fix interrupted SCM calls

 arch/arm/kernel/armksyms.c      |  2 +-
 arch/arm/kernel/smccc-call.S    |  7 ++++---
 arch/arm64/kernel/arm64ksyms.c  |  2 +-
 arch/arm64/kernel/asm-offsets.c |  7 +++++--
 arch/arm64/kernel/smccc-call.S  | 16 ++++++++++++----
 drivers/firmware/qcom_scm-64.c  | 13 ++++++++++---
 include/linux/arm-smccc.h       | 38 +++++++++++++++++++++++++++++++-------
 7 files changed, 64 insertions(+), 21 deletions(-)
