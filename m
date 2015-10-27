From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Tue, 27 Oct 2015 11:47:13 +0900
Subject: [PATCH] ARM: multi_v7_defconfig: enable UniPhier I2C drivers
Message-ID: <1445914033-4598-1-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These two drivers were merged into the I2C sub-system by
commit dd6fd4a32793 ("i2c: uniphier: add UniPhier FIFO-less I2C driver")
and commit 6a62974b667f ("i2c: uniphier_f: add UniPhier FIFO-builtin I2C
driver").

Enable them from arch/arm/configs/multi_v7_defconfig.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/arm/configs/multi_v7_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index bfd74fe..90e2b68 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -308,6 +308,8 @@ CONFIG_I2C_SIRF=y
 CONFIG_I2C_ST=y
 CONFIG_I2C_SUN6I_P2WI=y
 CONFIG_I2C_TEGRA=y
+CONFIG_I2C_UNIPHIER=y
+CONFIG_I2C_UNIPHIER_F=y
 CONFIG_I2C_XILINX=y
 CONFIG_I2C_RCAR=y
 CONFIG_I2C_CROS_EC_TUNNEL=m
-- 
1.9.1
