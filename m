From: bjorn.andersson@linaro.org (Bjorn Andersson)
Date: Wed,  2 Aug 2017 21:35:14 -0700
Subject: [PATCH v2 0/4] DB820c DTS dump
Message-ID: <20170803043518.21408-1-bjorn.andersson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A dump of DTS patches for MSM8996 and DB820c, found in the Linaro landing team
tree.

Changes since v1:
- Dropped the QFPROM patch, as it was only partial

Bjorn Andersson (3):
  arm64: dts: qcom: Add RPM glink nodes to msm8996
  arm64: dts: msm8996: Add modem smp2p nodes
  arm64: dts: qcom: msm8996: Specify smd-edge for ADSP

Rajendra Nayak (1):
  arm64: dts: qcom: db820c: Add pm8994 regulator node

 arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi | 148 +++++++++++++++++++++++++++
 arch/arm64/boot/dts/qcom/msm8996.dtsi        | 111 ++++++++++++++++++++
 2 files changed, 259 insertions(+)

-- 
2.12.0
