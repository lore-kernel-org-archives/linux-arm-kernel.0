From: tony@atomide.com (Tony Lindgren)
Date: Wed, 16 Dec 2009 11:09:51 -0800
Subject: [PATCH 1/4] omap3: Allow EHCI to be built on OMAP3
In-Reply-To: <20091216190601.30032.91535.stgit@localhost>
References: <20091216190601.30032.91535.stgit@localhost>
Message-ID: <20091216190951.30032.47819.stgit@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Olof Johansson <olof@lixom.net>

OMAP34XX has EHCI, so select USB_ARCH_HAS_EHCI.

Signed-off-by: Olof Johansson <olof@lixom.net>
Acked-by: Anand Gadiyar <gadiyar@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/Kconfig |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index 76c11ee..10eafa7 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -18,6 +18,7 @@ config ARCH_OMAP2430
 config ARCH_OMAP34XX
 	bool "OMAP34xx Based System"
 	depends on ARCH_OMAP3
+	select USB_ARCH_HAS_EHCI
 
 config ARCH_OMAP3430
 	bool "OMAP3430 support"
