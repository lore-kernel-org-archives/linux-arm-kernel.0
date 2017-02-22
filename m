From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Wed, 22 Feb 2017 18:31:46 +0100
Subject: [PATCH 3/3] arm64: defconfig: enable I2C_PXA
In-Reply-To: <20170222173146.30993-1-gregory.clement@free-electrons.com>
References: <20170222173146.30993-1-gregory.clement@free-electrons.com>
Message-ID: <20170222173146.30993-4-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that the Armada 37xx SoCs support the i2c pxa driver, enable it by
default.

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 7c48028ec64a..cdad9f63304e 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -249,6 +249,7 @@ CONFIG_I2C_DESIGNWARE_PLATFORM=y
 CONFIG_I2C_IMX=y
 CONFIG_I2C_MESON=y
 CONFIG_I2C_MV64XXX=y
+CONFIG_I2C_PXA=y
 CONFIG_I2C_QUP=y
 CONFIG_I2C_RK3X=y
 CONFIG_I2C_TEGRA=y
-- 
2.11.0
