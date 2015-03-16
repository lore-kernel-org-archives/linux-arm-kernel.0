From: galak@codeaurora.org (Kumar Gala)
Date: Mon, 16 Mar 2015 16:16:08 -0500 (CDT)
Subject: [GIT PULL] qcom defconfig changes for 4.1
Message-ID: <alpine.DEB.2.02.1503161614570.1345@galak-ubuntu.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit c517d838eb7d07bbe9507871fab3931deccff539:

   Linux 4.0-rc1 (2015-02-22 18:21:14 -0800)

are available in the git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/galak/linux-qcom.git tags/qcom-defconfig-for-4.1

for you to fetch changes up to 9e0388c3188c602fafdbfff46ca976de32a8008f:

   arm: qcom: Update defconfig (2015-03-16 16:10:58 -0500)

----------------------------------------------------------------
Qualcomm ARM Based defconfig Updates for v4.1

* Enable LPASS clock support for IPQ806x in defconfig
* Update qcom_defconfig to select GPIOLIB

----------------------------------------------------------------
Rajendra Nayak (1):
       arm: qcom: Enable lpass clock driver in defconfig

Stephen Boyd (1):
       arm: qcom: Update defconfig

  arch/arm/configs/qcom_defconfig | 7 ++++---
  1 file changed, 4 insertions(+), 3 deletions(-)

--
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
