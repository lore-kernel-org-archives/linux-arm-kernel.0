From: f.fainelli@gmail.com (Florian Fainelli)
Date: Wed,  7 Jun 2017 09:58:03 -0700
Subject: [PATCH] arm64: defconfig: Enable ARCH_BRCMSTB
Message-ID: <20170607165806.11242-1-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ARCH_BRCMSTB was one of the few platforms that were not enabled by
default, since we are now adding more and more drivers relevant to that
platform get some proper build coverage.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
I can submit this through the next arm-soc pull requests (shortly), if
that's okay with all of you, thanks!

 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index ce072859e3b2..1439b2f1f590 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -37,6 +37,7 @@ CONFIG_ARCH_ALPINE=y
 CONFIG_ARCH_BCM2835=y
 CONFIG_ARCH_BCM_IPROC=y
 CONFIG_ARCH_BERLIN=y
+CONFIG_ARCH_BRCMSTB=y
 CONFIG_ARCH_EXYNOS=y
 CONFIG_ARCH_LAYERSCAPE=y
 CONFIG_ARCH_LG1K=y
-- 
2.9.3
