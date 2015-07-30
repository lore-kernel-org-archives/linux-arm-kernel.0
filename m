From: agross@codeaurora.org (Andy Gross)
Date: Thu, 30 Jul 2015 16:16:47 -0500
Subject: [GIT PULL] qcom defconfig changes for 4.3
Message-ID: <1438291007-17536-1-git-send-email-agross@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit d770e558e21961ad6cfdf0ff7df0eb5d7d4f0754:

  Linux 4.2-rc1 (2015-07-05 11:01:52 -0700)

are available in the git repository at:

  git://codeaurora.org/quic/kernel/agross-msm.git tags/qcom-defconfig-for-4.3

for you to fetch changes up to 142f2610d525c23afa5ba5e4e535504bea8b04b9:

  ARM: qcom_defconfig: Enable options for KS8851 ethernet (2015-07-24 14:51:32 -0500)

----------------------------------------------------------------
* Enable KS8851 for QCOM SoCs in qcom defconfig

----------------------------------------------------------------
Stephen Boyd (1):
      ARM: qcom_defconfig: Enable options for KS8851 ethernet

 arch/arm/configs/qcom_defconfig |    3 +++
 1 file changed, 3 insertions(+)
