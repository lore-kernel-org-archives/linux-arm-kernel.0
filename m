From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 18 Oct 2013 10:56:42 -0700
Subject: [PATCH v2 0/4] APQ8074 updates
In-Reply-To: <1382034310-31147-1-git-send-email-rvaswani@codeaurora.org>
References: <1382034310-31147-1-git-send-email-rvaswani@codeaurora.org>
Message-ID: <1382119006-22231-1-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset simplifies the ARCH_MSM_DT config and adds some more
nodes for devices that have drivers merged in the upstream kernel.

Changes since v1:
 * Moved nodes into soc node
 * Enabled restart driver in defconfig

Stephen Boyd (4):
  ARM: msm: Simplify ARCH_MSM_DT config
  ARM: dts: MSM8974: Add restart node
  ARM: dts: MSM8974: Add MMIO architected timer node
  ARM: msm_defconfig: Enable restart driver

 arch/arm/boot/dts/qcom-msm8974.dtsi | 64 +++++++++++++++++++++++++++++++++++++
 arch/arm/configs/msm_defconfig      |  2 ++
 arch/arm/mach-msm/Kconfig           |  6 ++--
 3 files changed, 70 insertions(+), 2 deletions(-)

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
