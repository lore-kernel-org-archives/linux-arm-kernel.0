From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 17 Oct 2013 14:31:26 -0700
Subject: [PATCH 0/3] APQ8074 updates
In-Reply-To: <1382034310-31147-1-git-send-email-rvaswani@codeaurora.org>
References: <1382034310-31147-1-git-send-email-rvaswani@codeaurora.org>
Message-ID: <1382045489-21075-1-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset simplifies the ARCH_MSM_DT config and adds some more
nodes for devices that have drivers merged in the upstream kernel.

Stephen Boyd (3):
  ARM: msm: Simplify ARCH_MSM_DT config
  ARM: dts: MSM8974: Add restart node
  ARM: dts: MSM8974: Add MMIO architected timer node

 arch/arm/boot/dts/qcom-msm8974.dtsi | 64 +++++++++++++++++++++++++++++++++++++
 arch/arm/mach-msm/Kconfig           |  6 ++--
 2 files changed, 68 insertions(+), 2 deletions(-)

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
