From: narmstrong@baylibre.com (Neil Armstrong)
Date: Thu, 24 Mar 2016 17:50:11 +0100
Subject: [PATCH v3 14/18] arm: Add build support for mach-oxnas
In-Reply-To: <1458838215-23314-1-git-send-email-narmstrong@baylibre.com>
References: <1458838215-23314-1-git-send-email-narmstrong@baylibre.com>
Message-ID: <1458838215-23314-15-git-send-email-narmstrong@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add Kconfig support for mach-oxnas.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 arch/arm/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index cdfa6c2..4d48e23 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -804,6 +804,8 @@ source "arch/arm/plat-pxa/Kconfig"
 
 source "arch/arm/mach-mmp/Kconfig"
 
+source "arch/arm/mach-oxnas/Kconfig"
+
 source "arch/arm/mach-qcom/Kconfig"
 
 source "arch/arm/mach-realview/Kconfig"
-- 
1.9.1
