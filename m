From: svarbanov@mm-sol.com (Stanimir Varbanov)
Date: Fri, 12 Dec 2014 19:14:01 +0200
Subject: [PATCH 5/5] ARM: qcom: Add Qualcomm APQ8084 SoC
In-Reply-To: <1418404441-5518-1-git-send-email-svarbanov@mm-sol.com>
References: <1418404441-5518-1-git-send-email-svarbanov@mm-sol.com>
Message-ID: <1418404441-5518-6-git-send-email-svarbanov@mm-sol.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds Snapdragon 805 ARM-based SoC as multiplatform
compatible platform.

Signed-off-by: Stanimir Varbanov <svarbanov@mm-sol.com>
---
 arch/arm/mach-qcom/Kconfig |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-qcom/Kconfig b/arch/arm/mach-qcom/Kconfig
index ee5697b..b8abe7d 100644
--- a/arch/arm/mach-qcom/Kconfig
+++ b/arch/arm/mach-qcom/Kconfig
@@ -23,6 +23,13 @@ config ARCH_MSM8974
 	bool "Enable support for MSM8974"
 	select HAVE_ARM_ARCH_TIMER
 
+config ARCH_APQ8084
+	bool "Enable support for APQ8084"
+	select HAVE_ARM_ARCH_TIMER
+	select PCI
+	select PCI_DOMAINS
+	select PCI_MSI
+
 config QCOM_SCM
 	bool
 
-- 
1.7.0.4
