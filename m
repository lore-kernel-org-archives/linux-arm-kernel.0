From: agross@codeaurora.org (Andy Gross)
Date: Tue, 17 Mar 2015 16:51:07 -0500
Subject: [PATCH 0/4] Add Qualcomm ADM DMA support
Message-ID: <1426629071-3541-1-git-send-email-agross@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch set adds support for the Qualcomm ADM DMA controller that is present
in the APQ8064, IPQ8064, MSM8660, and MSM8960.

Andy Gross (4):
  ARM: DT: ipq8064: Add ADM device node
  ARM: DT: apq8064: Add ADM device node
  ARM: DT: msm8660: Add ADM device nodes
  ARM: DT: msm8960: Add ADM device node

 arch/arm/boot/dts/qcom-apq8064.dtsi      |   21 +++++++++++++++
 arch/arm/boot/dts/qcom-ipq8064-ap148.dts |    4 +++
 arch/arm/boot/dts/qcom-ipq8064.dtsi      |   23 ++++++++++++++++
 arch/arm/boot/dts/qcom-msm8660.dtsi      |   42 ++++++++++++++++++++++++++++++
 arch/arm/boot/dts/qcom-msm8960.dtsi      |   21 +++++++++++++++
 5 files changed, 111 insertions(+)

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
