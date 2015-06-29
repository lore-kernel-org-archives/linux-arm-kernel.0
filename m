From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Mon, 29 Jun 2015 14:32:20 +0200
Subject: [PATCH v2 2/4] arm64: defconfig: enable ARCH_ROCKCHIP
In-Reply-To: <3333434.ZKWQ6GxgtB@diego>
References: <3333434.ZKWQ6GxgtB@diego>
Message-ID: <1894031.Obs8fLraqt@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable building Rockchip support in the defconfig.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/arm64/configs/defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index daefbf0..77bc5bc 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -34,6 +34,7 @@ CONFIG_MODULE_UNLOAD=y
 CONFIG_ARCH_EXYNOS7=y
 CONFIG_ARCH_FSL_LS2085A=y
 CONFIG_ARCH_MEDIATEK=y
+CONFIG_ARCH_ROCKCHIP=y
 CONFIG_ARCH_SEATTLE=y
 CONFIG_ARCH_TEGRA=y
 CONFIG_ARCH_TEGRA_132_SOC=y
@@ -99,6 +100,7 @@ CONFIG_SERIO_AMBAKMI=y
 CONFIG_LEGACY_PTY_COUNT=16
 CONFIG_SERIAL_8250=y
 CONFIG_SERIAL_8250_CONSOLE=y
+CONFIG_SERIAL_8250_DW=y
 CONFIG_SERIAL_8250_MT6577=y
 CONFIG_SERIAL_AMBA_PL011=y
 CONFIG_SERIAL_AMBA_PL011_CONSOLE=y
-- 
2.1.4
