From: dwalker@codeaurora.org (Daniel Walker)
Date: Wed, 12 May 2010 14:45:50 -0700
Subject: [PATCH 21/25] msm: Add extern for 7x30 clock list.
In-Reply-To: <>
References: <>
Message-ID: <1273700754-10256-22-git-send-email-dwalker@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Daniel Walker <dwalker@codeaurora.org>
Signed-off-by: David Brown <davidb@codeaurora.org>
Signed-off-by: Gregory Bean <gbean@codeaurora.org>
Signed-off-by: Abhijeet Dharmapurikar <adharmap@codeaurora.org>
Signed-off-by: Stepan Moskovchenko <stepanm@codeaurora.org>
---
 arch/arm/mach-msm/devices.h |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-msm/devices.h b/arch/arm/mach-msm/devices.h
index d209554..568443e 100644
--- a/arch/arm/mach-msm/devices.h
+++ b/arch/arm/mach-msm/devices.h
@@ -38,6 +38,9 @@ extern struct platform_device msm_device_nand;
 extern struct clk msm_clocks_7x01a[];
 extern unsigned msm_num_clocks_7x01a;
 
+extern struct clk msm_clocks_7x30[];
+extern unsigned msm_num_clocks_7x30;
+
 extern struct clk msm_clocks_8x50[];
 extern unsigned msm_num_clocks_8x50;
 
-- 
1.6.2.3
