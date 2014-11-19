From: carlo@caione.org (Carlo Caione)
Date: Wed, 19 Nov 2014 11:32:22 +0100
Subject: [PATCH 3/4] ARM: meson: enable reset controller in kconfig
In-Reply-To: <1416393143-20434-1-git-send-email-carlo@caione.org>
References: <1416393143-20434-1-git-send-email-carlo@caione.org>
Message-ID: <1416393143-20434-4-git-send-email-carlo@caione.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Modify the arch Kconfig to enable the reset controller

Signed-off-by: Carlo Caione <carlo@caione.org>
---
 arch/arm/mach-meson/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-meson/Kconfig b/arch/arm/mach-meson/Kconfig
index 18301dc..af2ad93 100644
--- a/arch/arm/mach-meson/Kconfig
+++ b/arch/arm/mach-meson/Kconfig
@@ -10,6 +10,8 @@ config MACH_MESON6
 	bool "Amlogic Meson6 (8726MX) SoCs support"
 	default ARCH_MESON
 	select MESON6_TIMER
+	select ARCH_HAS_RESET_CONTROLLER
+	select RESET_CONTROLLER
 
 config MACH_MESON8
 	bool "Amlogic Meson8 SoCs support"
-- 
1.9.1
