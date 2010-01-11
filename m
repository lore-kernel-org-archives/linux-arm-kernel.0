From: dwalker@codeaurora.org (Daniel Walker)
Date: Mon, 11 Jan 2010 14:47:32 -0800
Subject: [RFC 13/18] arm: msm: define HAVE_CLK for ARCH_MSM
In-Reply-To: <1263250057-26692-1-git-send-email-dwalker@codeaurora.org>
References: <1263250057-26692-1-git-send-email-dwalker@codeaurora.org>
Message-ID: <1263250057-26692-14-git-send-email-dwalker@codeaurora.org>
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
index 2db3739..c8b3a29 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -574,6 +574,7 @@ config ARCH_PXA
 config ARCH_MSM
 	bool "Qualcomm MSM"
 	select ARCH_HAS_CPUFREQ
+	select HAVE_CLK
 	select GENERIC_TIME
 	select GENERIC_CLOCKEVENTS
 	help
-- 
1.6.3.3
