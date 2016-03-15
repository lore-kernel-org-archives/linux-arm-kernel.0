From: acourbot@nvidia.com (Alexandre Courbot)
Date: Tue, 15 Mar 2016 11:58:39 +0900
Subject: [PATCH v2 0/5] arm64: tegra: fix DT definitions for GM20B GPU
Message-ID: <1458010724-10945-1-git-send-email-acourbot@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Small series that fixes/completes DT bindings for Tegra GPUs and add two
missing entries required for the Tegra210 GPU to operate properly.

Changes since v1:
- Renamed "pllg_ref" clock to "ref" in DT bindings

Alexandre Courbot (5):
  dt-bindings: gk20a: Fix typo in compatible name
  dt-bindings: gk20a: Document iommus property
  dt-bindings: Add documentation for GM20B GPU
  arm64: tegra210: Add reference clock to GM20B
  arm64: tegra210: Add IOMMU node to GM20B

 .../devicetree/bindings/gpu/nvidia,gk20a.txt       | 35 +++++++++++++++++++---
 arch/arm64/boot/dts/nvidia/tegra210.dtsi           |  8 +++--
 2 files changed, 37 insertions(+), 6 deletions(-)

-- 
2.7.2
