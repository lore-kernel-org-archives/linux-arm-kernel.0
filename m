From: galak@codeaurora.org (Kumar Gala)
Date: Mon, 19 Jan 2015 12:25:51 -0600 (CST)
Subject: [GIT PULL] qcom DT changes for v3.20
Message-ID: <alpine.DEB.2.02.1501191224310.2973@galak-ubuntu.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 97bf6af1f928216fd6c5a66e8a57bfa95a659672:

   Linux 3.19-rc1 (2014-12-20 17:08:50 -0800)

are available in the git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/galak/linux-qcom.git tags/qcom-dt-for-3.20

for you to fetch changes up to bb901bd6596e93fc2e0fc6da2f367a651bd8d16e:

   ARM: dts: qcom: Correct IPQ8064 tlmm interrupt (2015-01-19 12:11:41 -0600)

----------------------------------------------------------------
Qualcomm ARM Based Device Tree Updates for v3.20

* Correct IPQ8064 tlmm interrupt
* Add Support for SD Card Detect for ifc6410 board

----------------------------------------------------------------
Pramod Gurav (1):
       ARM: dts: qcom: Add Support for SD Card Detect for ifc6410 board

Stephen Boyd (1):
       ARM: dts: qcom: Correct IPQ8064 tlmm interrupt

  arch/arm/boot/dts/qcom-apq8064-ifc6410.dts | 12 ++++++++++++
  arch/arm/boot/dts/qcom-ipq8064.dtsi        |  2 +-
  2 files changed, 13 insertions(+), 1 deletion(-)

--
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
