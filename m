From: a.kesavan@samsung.com (Abhilash Kesavan)
Date: Tue, 30 Sep 2014 20:00:50 +0530
Subject: [PATCH v4 6/6] arm64: exynos: Enable pinctrl support for Exynos7
In-Reply-To: <1412087450-10495-1-git-send-email-a.kesavan@samsung.com>
References: <1412087450-10495-1-git-send-email-a.kesavan@samsung.com>
Message-ID: <1412087450-10495-7-git-send-email-a.kesavan@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Naveen Krishna Ch <naveenkrishna.ch@gmail.com>

Enable pinctrl support for exynos7 SoCs.

Signed-off-by: Naveen Krishna Ch <naveenkrishna.ch@gmail.com>
Signed-off-by: Abhilash Kesavan <a.kesavan@samsung.com>
Reviewed-by: Thomas Abraham <thomas.ab@samsung.com>
Tested-by: Thomas Abraham <thomas.ab@samsung.com>
Acked-by: Tomasz Figa <tomasz.figa@gmail.com>
Cc: Rob Herring <robh@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm64/Kconfig |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 5285f9c..e8ddd84 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -145,6 +145,8 @@ config ARCH_EXYNOS7
 	bool "ARMv8 based Samsung Exynos7"
 	select ARCH_EXYNOS
 	select COMMON_CLK_SAMSUNG
+	select PINCTRL
+	select PINCTRL_EXYNOS
 	help
 	  This enables support for Samsung Exynos7 SoC family
 
-- 
1.7.9.5
