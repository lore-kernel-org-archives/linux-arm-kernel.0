From: agross@codeaurora.org (Andy Gross)
Date: Thu, 30 Jul 2015 16:16:18 -0500
Subject: [GIT PULL] qcom SoC changes for 4.3
Message-ID: <1438290978-17470-1-git-send-email-agross@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit d770e558e21961ad6cfdf0ff7df0eb5d7d4f0754:

  Linux 4.2-rc1 (2015-07-05 11:01:52 -0700)

are available in the git repository at:

  git://codeaurora.org/quic/kernel/agross-msm.git tags/qcom-soc-for-4.3

for you to fetch changes up to 23b38ceb814ca8a2bd92613687f82b70041b9238:

  drivers: qcom: Select QCOM_SCM unconditionally for QCOM_PM (2015-07-28 15:50:17 -0500)

----------------------------------------------------------------
* Add SMEM driver
* Select QCOM_SCM by default

----------------------------------------------------------------
Bjorn Andersson (1):
      soc: qcom: Add Shared Memory Manager driver

Lina Iyer (1):
      drivers: qcom: Select QCOM_SCM unconditionally for QCOM_PM

 drivers/soc/qcom/Kconfig      |    9 +
 drivers/soc/qcom/Makefile     |    1 +
 drivers/soc/qcom/smem.c       |  775 +++++++++++++++++++++++++++++++++++++++++
 include/linux/soc/qcom/smem.h |   11 +
 4 files changed, 796 insertions(+)
 create mode 100644 drivers/soc/qcom/smem.c
 create mode 100644 include/linux/soc/qcom/smem.h
