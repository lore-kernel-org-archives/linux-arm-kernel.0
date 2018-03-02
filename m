From: jcrouse@codeaurora.org (Jordan Crouse)
Date: Fri,  2 Mar 2018 14:56:36 -0700
Subject: [PATCH 0/2] arm64: dts: Add sdm845 GPU/GMU and SMMU
Message-ID: <20180302215638.6145-1-jcrouse@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Building on the sdm845 changes from Rajendra and SMMU changes from Vivek this
is an initial stab at the DT nodes for the sdm845 GPU and GMU (graphics
management unit) which is responsible for the direct power control of the GPU
including the companion arm-smmu-v2 compatible SMMU.

Please refer to https://patchwork.freedesktop.org/series/37428/ for the driver
code.

Jordan Crouse (2):
  dt-bindings: Document qcom,adreno-gmu
  arm64: dts: sdm845: Support GPU/GMU

 .../devicetree/bindings/display/msm/gmu.txt        |  54 ++++++++++
 .../devicetree/bindings/display/msm/gpu.txt        |  10 +-
 arch/arm64/boot/dts/qcom/sdm845.dtsi               | 120 +++++++++++++++++++++
 3 files changed, 182 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/display/msm/gmu.txt

-- 
2.16.1
