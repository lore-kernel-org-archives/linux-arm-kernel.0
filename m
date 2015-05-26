From: galak@codeaurora.org (Kumar Gala)
Date: Tue, 26 May 2015 14:49:51 -0500 (CDT)
Subject: [GIT PULL] qcom SoC changes for 4.2
Message-ID: <alpine.DEB.2.02.1505261449220.26936@galak-ubuntu.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit b787f68c36d49bb1d9236f403813641efa74a031:

   Linux 4.1-rc1 (2015-04-26 17:59:10 -0700)

are available in the git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/galak/linux-qcom.git tags/qcom-soc-for-4.2

for you to fetch changes up to b6a1dfbc7d57409accf213e78db7b059c206be9e:

   firmware: qcom: scm: Split out 32-bit specific SCM code (2015-04-28 14:20:40 -0500)

----------------------------------------------------------------
Qualcomm ARM Based SoC Updates for v4.2

* Added Subsystem Power Manager (SPM) driver
* Split out 32-bit specific SCM code

----------------------------------------------------------------
Kumar Gala (1):
       firmware: qcom: scm: Split out 32-bit specific SCM code

Lina Iyer (1):
       ARM: qcom: Add Subsystem Power Manager (SPM) driver

  drivers/firmware/Makefile      |   3 +-
  drivers/firmware/qcom_scm-32.c | 480 +++++++++++++++++++++++++++++++++++++++++
  drivers/firmware/qcom_scm.c    | 442 +------------------------------------
  drivers/firmware/qcom_scm.h    |  38 ++++
  drivers/soc/qcom/Kconfig       |   7 +
  drivers/soc/qcom/Makefile      |   1 +
  drivers/soc/qcom/spm.c         | 385 +++++++++++++++++++++++++++++++++
  7 files changed, 920 insertions(+), 436 deletions(-)
  create mode 100644 drivers/firmware/qcom_scm-32.c
  create mode 100644 drivers/firmware/qcom_scm.h
  create mode 100644 drivers/soc/qcom/spm.c

--
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
