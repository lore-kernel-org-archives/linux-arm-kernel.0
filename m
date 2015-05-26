From: galak@codeaurora.org (Kumar Gala)
Date: Tue, 26 May 2015 14:35:22 -0500 (CDT)
Subject: [GIT PULL] qcom defconfig changes for 4.2
Message-ID: <alpine.DEB.2.02.1505261426120.25082@galak-ubuntu.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit b787f68c36d49bb1d9236f403813641efa74a031:

   Linux 4.1-rc1 (2015-04-26 17:59:10 -0700)

are available in the git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/galak/linux-qcom.git tags/qcom-defconfig-for-4.2

for you to fetch changes up to e3db12b94ed4e70b7f8703a0c7396d6b9028b58a:

   ARM: config: multi_v7: Update to enable cpuidle for QCOM SoCs (2015-04-28 14:29:09 -0500)

----------------------------------------------------------------
Qualcomm ARM Based defconfig Updates for v4.2

* Enable cpuidle for QCOM SoCs in qcom & multi_v7_defconfig

----------------------------------------------------------------
Lina Iyer (2):
       ARM: config: Update qcom_defconfig to enable cpuidle
       ARM: config: multi_v7: Update to enable cpuidle for QCOM SoCs

  arch/arm/configs/multi_v7_defconfig | 2 ++
  arch/arm/configs/qcom_defconfig     | 2 ++
  2 files changed, 4 insertions(+)

--
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
