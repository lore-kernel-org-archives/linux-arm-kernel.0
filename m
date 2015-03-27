From: galak@codeaurora.org (Kumar Gala)
Date: Fri, 27 Mar 2015 11:38:49 -0500 (CDT)
Subject: [GIT PULL] qcom defconfig changes for 4.1-1
Message-ID: <alpine.DEB.2.02.1503271137360.17255@galak-ubuntu.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit c517d838eb7d07bbe9507871fab3931deccff539:

   Linux 4.0-rc1 (2015-02-22 18:21:14 -0800)

are available in the git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/galak/linux-qcom.git tags/qcom-defconfig-for-4.1-1

for you to fetch changes up to dc344b62121c4e2ba5bd9d5bf7a2b4ce5f0487ce:

   ARM: qcom: Increase MMC_BLOCK_MINORS in defconfig (2015-03-25 16:16:59 -0500)

----------------------------------------------------------------
Qualcomm ARM Based defconfig Updates for v4.1-1

* Increase MMC_BLOCK_MINORS to 32 since qcom platforms have more than
   16 partitions

----------------------------------------------------------------
Georgi Djakov (1):
       ARM: qcom: Increase MMC_BLOCK_MINORS in defconfig

Rajendra Nayak (1):
       arm: qcom: Enable lpass clock driver in defconfig

Stephen Boyd (1):
       arm: qcom: Update defconfig

  arch/arm/configs/qcom_defconfig | 9 +++++----
  1 file changed, 5 insertions(+), 4 deletions(-)

--
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
