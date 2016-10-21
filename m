From: spjoshi@codeaurora.org (Sarangdhar Joshi)
Date: Fri, 21 Oct 2016 16:19:15 -0700
Subject: [PATCH v3 0/4] MSM8996 DT Support for ADSP PIL
Message-ID: <1477091959-19580-1-git-send-email-spjoshi@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add various device tree nodes to lay the groundwork for
Qualcomm ADSP Peripheral Image Loader.

Sorry, I didn't send any cover letter for v1.

Changes since v2:
- Remove empty lines from smem DT node (Stephen)

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

 arch/arm64/boot/dts/qcom/msm8996.dtsi | 82 +++++++++++++++++++++++++++++++++++
 1 file changed, 82 insertions(+)

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
