From: gabriel.fernandez@st.com (Gabriel FERNANDEZ)
Date: Fri, 10 Apr 2015 11:12:44 +0200
Subject: [PATCH v3 1/5] ARM: STi: Kconfig update for PCIe support
In-Reply-To: <1428657168-12495-1-git-send-email-gabriel.fernandez@linaro.org>
References: <1428657168-12495-1-git-send-email-gabriel.fernandez@linaro.org>
Message-ID: <1428657168-12495-2-git-send-email-gabriel.fernandez@linaro.org>
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
index 3b1ac46..7f9b432 100644
--- a/arch/arm/mach-sti/Kconfig
+++ b/arch/arm/mach-sti/Kconfig
@@ -8,6 +8,8 @@ menuconfig ARCH_STI
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
