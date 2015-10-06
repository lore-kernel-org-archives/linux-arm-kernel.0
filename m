From: gabriel.fernandez@linaro.org (Gabriel Fernandez)
Date: Tue,  6 Oct 2015 09:56:06 +0200
Subject: [PATCH v5 1/3] ARM: STi: Kconfig update for PCIe support
In-Reply-To: <1444118168-13086-1-git-send-email-gabriel.fernandez@linaro.org>
References: <1444118168-13086-1-git-send-email-gabriel.fernandez@linaro.org>
Message-ID: <1444118168-13086-2-git-send-email-gabriel.fernandez@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Update Kconfig:
- MIGHT_HAVE_PCI
- PCI_DOMAINS

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
---
 arch/arm/mach-sti/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-sti/Kconfig b/arch/arm/mach-sti/Kconfig
index 125865d..5f99e93 100644
--- a/arch/arm/mach-sti/Kconfig
+++ b/arch/arm/mach-sti/Kconfig
@@ -9,6 +9,8 @@ menuconfig ARCH_STI
 	select ARCH_HAS_RESET_CONTROLLER
 	select HAVE_ARM_SCU if SMP
 	select ARCH_REQUIRE_GPIOLIB
+	select PCI_DOMAINS if PCI
+	select MIGHT_HAVE_PCI
 	select ARM_ERRATA_754322
 	select ARM_ERRATA_764369 if SMP
 	select ARM_ERRATA_775420
-- 
1.9.1
