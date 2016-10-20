From: spjoshi@codeaurora.org (Sarangdhar Joshi)
Date: Thu, 20 Oct 2016 16:12:15 -0700
Subject: [PATCH v2 0/4] MSM8996 DT Support for ADSP PIL
Message-ID: <1477005139-15564-1-git-send-email-spjoshi@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add various device tree nodes to lay the groundwork for
Qualcomm ADSP Peripheral Image Loader.

Sorry, I didn't send any cover letter for v1.

Changes since v1:
- Move hwlock DT node under root (/) (Bjorn and Andy)
- Rename smp2p-adsp to adsp-smp2p (Bjorn)
- Remove interrupt-parent property from node (Bjorn)

Bjorn Andersson (1):
  arm64: dts: msm8996: Add SMEM DT nodes

Sarangdhar Joshi (3):
  arm64: dts: msm8996: Add SMEM reserve-memory node
  arm64: dts: msm8996: Add reserve-memory nodes
  arm64: dts: msm8996: Add SMP2P and APCS nodes

 arch/arm64/boot/dts/qcom/msm8996.dtsi | 84 +++++++++++++++++++++++++++++++++++
 1 file changed, 84 insertions(+)

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
