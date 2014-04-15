From: agross@codeaurora.org (Andy Gross)
Date: Mon, 14 Apr 2014 22:10:37 -0500
Subject: [PATCH 3/3] ARM: qcom: Select PINCTRL by default for ARCH_QCOM
In-Reply-To: <1397531437-9104-1-git-send-email-agross@codeaurora.org>
References: <1397531437-9104-1-git-send-email-agross@codeaurora.org>
Message-ID: <1397531437-9104-4-git-send-email-agross@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add missing PINCTRL selection.  This enables selection of pinctrollers for
Qualcomm processors.

Signed-off-by: Andy Gross <agross@codeaurora.org>
---
 arch/arm/mach-qcom/Kconfig |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-qcom/Kconfig b/arch/arm/mach-qcom/Kconfig
index aded06d..2c561c0 100644
--- a/arch/arm/mach-qcom/Kconfig
+++ b/arch/arm/mach-qcom/Kconfig
@@ -5,6 +5,7 @@ config ARCH_QCOM
 	select CLKSRC_OF
 	select GENERIC_CLOCKEVENTS
 	select HAVE_SMP
+	select PINCTRL
 	select QCOM_SCM if SMP
 	help
 	  Support for Qualcomm's devicetree based systems.
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
