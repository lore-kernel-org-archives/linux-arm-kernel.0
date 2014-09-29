From: a.kesavan@samsung.com (Abhilash Kesavan)
Date: Mon, 29 Sep 2014 10:45:12 +0530
Subject: [PATCH v3 6/6] arm64: exynos: Enable pinctrl support for Exynos7
In-Reply-To: <1411967712-8321-1-git-send-email-a.kesavan@samsung.com>
References: <1411967712-8321-1-git-send-email-a.kesavan@samsung.com>
Message-ID: <1411967712-8321-7-git-send-email-a.kesavan@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Naveen Krishna Ch <naveenkrishna.ch@gmail.com>

Enable pinctrl support for exynos7 SoCs.

Signed-off-by: Naveen Krishna Ch <naveenkrishna.ch@gmail.com>
Signed-off-by: Abhilash Kesavan <a.kesavan@samsung.com>
Reviewed-by: Thomas Abraham <thomas.ab@samsung.com>
Tested-by: Thomas Abraham <thomas.ab@samsung.com>
Cc: Rob Herring <robh@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Tomasz Figa <tomasz.figa@gmail.com>
Cc: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm64/Kconfig |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 1874e1a..4ee1250 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -146,6 +146,8 @@ config ARCH_EXYNOS7
 	bool "ARMv8 based Samsung Exynos7"
 	select ARCH_EXYNOS
 	select COMMON_CLK_SAMSUNG
+	select PINCTRL
+	select PINCTRL_EXYNOS
 	help
 	  This enables support for Samsung Exynos7 SoC family
 
-- 
1.7.9.5
