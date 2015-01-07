From: sjoerd.simons@collabora.co.uk (Sjoerd Simons)
Date: Thu,  8 Jan 2015 00:06:14 +0100
Subject: [PATCH RESEND] ARM: EXYNOS: Recognize Samsung MFC v8 devices
Message-ID: <1420671974-25938-1-git-send-email-sjoerd.simons@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Also setup memory allocations for version 8 of the MFC as present in
Samsung Exynos 5422/5800 SoCs

Signed-off-by: Sjoerd Simons <sjoerd.simons@collabora.co.uk>
---
 arch/arm/mach-exynos/exynos.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-exynos/exynos.c b/arch/arm/mach-exynos/exynos.c
index c13d083..b343a1a 100644
--- a/arch/arm/mach-exynos/exynos.c
+++ b/arch/arm/mach-exynos/exynos.c
@@ -282,6 +282,7 @@ static void __init exynos_reserve(void)
 		"samsung,mfc-v5",
 		"samsung,mfc-v6",
 		"samsung,mfc-v7",
+		"samsung,mfc-v8",
 	};
 
 	for (i = 0; i < ARRAY_SIZE(mfc_mem); i++)
-- 
2.1.4
