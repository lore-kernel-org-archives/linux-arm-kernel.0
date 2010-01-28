From: dwalker@codeaurora.org (Daniel Walker)
Date: Thu, 28 Jan 2010 14:59:35 -0800
Subject: [RFC PATCH 10/12] arm: msm: define HAVE_CLK for ARCH_MSM
Message-ID: <1264719577-5436-11-git-send-email-dwalker@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Steve Muckle <smuckle@quicinc.com>

MSM supports the <linux/clk.h> interface.

Acked-by: David Brown <davidb@quicinc.com>
Signed-off-by: Steve Muckle <smuckle@quicinc.com>
Signed-off-by: Daniel Walker <dwalker@codeaurora.org>
---
 arch/arm/Kconfig |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 02c029a..6662876 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -576,6 +576,7 @@ config ARCH_PXA
 config ARCH_MSM
 	bool "Qualcomm MSM"
 	select ARCH_HAS_CPUFREQ
+	select HAVE_CLK
 	select GENERIC_TIME
 	select GENERIC_CLOCKEVENTS
 	help
-- 
1.6.3.3
