From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Tue, 24 Nov 2015 18:08:29 +0900
Subject: [PATCH 2/2] arm64: defconfig: enable UniPhier SoCs support
In-Reply-To: <1448356109-22380-1-git-send-email-yamada.masahiro@socionext.com>
References: <1448356109-22380-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <1448356109-22380-3-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable ARCH_UNIPHIER with its on-chip UART driver.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/arm64/configs/defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index bdd7aa3..5853bc0 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -45,6 +45,7 @@ CONFIG_ARCH_TEGRA_132_SOC=y
 CONFIG_ARCH_QCOM=y
 CONFIG_ARCH_SPRD=y
 CONFIG_ARCH_THUNDER=y
+CONFIG_ARCH_UNIPHIER=y
 CONFIG_ARCH_VEXPRESS=y
 CONFIG_ARCH_XGENE=y
 CONFIG_ARCH_ZYNQMP=y
@@ -110,6 +111,7 @@ CONFIG_SERIAL_8250=y
 CONFIG_SERIAL_8250_CONSOLE=y
 CONFIG_SERIAL_8250_DW=y
 CONFIG_SERIAL_8250_MT6577=y
+CONFIG_SERIAL_8250_UNIPHIER=y
 CONFIG_SERIAL_AMBA_PL011=y
 CONFIG_SERIAL_AMBA_PL011_CONSOLE=y
 CONFIG_SERIAL_SAMSUNG=y
-- 
1.9.1
