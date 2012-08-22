From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 22 Aug 2012 16:00:14 -0700
Subject: [PATCH 2/2] ARM: MSM: Add msm8660-surf.dts to Makefile.boot
In-Reply-To: <1345676414-16635-1-git-send-email-sboyd@codeaurora.org>
References: <1345676414-16635-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <1345676414-16635-3-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add this entry to the Makefile so that we can build the dtb
automatically with 'make dtbs'.

Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 arch/arm/mach-msm/Makefile.boot | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-msm/Makefile.boot b/arch/arm/mach-msm/Makefile.boot
index 9b803a5..8de0678 100644
--- a/arch/arm/mach-msm/Makefile.boot
+++ b/arch/arm/mach-msm/Makefile.boot
@@ -1,3 +1,5 @@
   zreladdr-y		+= 0x10008000
 params_phys-y		:= 0x10000100
 initrd_phys-y		:= 0x10800000
+
+dtb-$(CONFIG_ARCH_MSM8X60) += msm8660-surf.dtb
-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
