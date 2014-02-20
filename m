From: galak@codeaurora.org (Kumar Gala)
Date: Thu, 20 Feb 2014 11:05:32 -0600 (CST)
Subject: [GIT PULL] qcom DT changes for v3.15
Message-ID: <alpine.DEB.2.00.1402201104120.12882@galak-ubuntu.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit cf1e8f0cd665e2a9966d2bee4e11ecc0938ff166:

   ARM: qcom: Rename various msm prefixed functions to qcom (2014-02-06 16:20:41 -0600)

are available in the git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/galak/linux-qcom.git tags/qcom-dt-for-3.15

for you to fetch changes up to 5a229c2a59e5d42a7d670f4639aaedb272146ef1:

   ARM: dts: qcom-msm8960-cdp: Add RNG device tree node (2014-02-20 10:02:22 -0600)

----------------------------------------------------------------
Qualcomm ARM Based Device Tree Updates for v3.15

* Added device tree nodes to enable SMP on msm8660, msm8960, and msm8974
* Added Random Number Generator DT nodes for msm8974 and msm8960 SoCs

----------------------------------------------------------------
Rohit Vaswani (1):
       ARM: dts: qcom: Add nodes necessary for SMP boot

Stanimir Varbanov (2):
       ARM: dts: qcom: Add RNG device tree node
       ARM: dts: qcom-msm8960-cdp: Add RNG device tree node

  arch/arm/boot/dts/qcom-msm8660.dtsi | 24 ++++++++++++
  arch/arm/boot/dts/qcom-msm8960.dtsi | 59 ++++++++++++++++++++++++++++
  arch/arm/boot/dts/qcom-msm8974.dtsi | 76 +++++++++++++++++++++++++++++++++++++
  3 files changed, 159 insertions(+)

--
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
