From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Mon,  6 Jul 2015 12:47:28 +0900
Subject: [PATCH 1/3] ARM: multi_v7_defconfig: enable UniPhier UART driver
In-Reply-To: <1436154450-21102-1-git-send-email-yamada.masahiro@socionext.com>
References: <1436154450-21102-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <1436154450-21102-2-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The UniPhier on-chip UART driver was merged into the mainline by
commit 1a8d2903cb6a (serial: 8250_uniphier: add UniPhier serial
driver).

Enable it from multi_v7_defconfig.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/arm/configs/multi_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 6d83a1b..9311cd9 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -251,6 +251,7 @@ CONFIG_SERIAL_8250_CONSOLE=y
 CONFIG_SERIAL_8250_DW=y
 CONFIG_SERIAL_8250_EM=y
 CONFIG_SERIAL_8250_MT6577=y
+CONFIG_SERIAL_8250_UNIPHIER=y
 CONFIG_SERIAL_AMBA_PL011=y
 CONFIG_SERIAL_AMBA_PL011_CONSOLE=y
 CONFIG_SERIAL_ATMEL=y
-- 
1.9.1
