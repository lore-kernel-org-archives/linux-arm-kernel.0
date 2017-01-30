From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Mon, 30 Jan 2017 10:55:47 +0900
Subject: [RESEND PATCH 2/2] arm64: defconfig: enable CONFIG_MTD_NAND and
 CONFIG_MTD_NAND_DENALI_DT
In-Reply-To: <1485741347-17363-1-git-send-email-yamada.masahiro@socionext.com>
References: <1485741347-17363-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <1485741347-17363-3-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable the NAND framework and the Denali NAND controller driver.
This NAND controller is used on UniPhier SoCs.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/arm64/configs/defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index f1f0caf..e4a8567 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -145,6 +145,8 @@ CONFIG_DMA_CMA=y
 CONFIG_MTD=y
 CONFIG_MTD_BLOCK=y
 CONFIG_MTD_M25P80=y
+CONFIG_MTD_NAND=y
+CONFIG_MTD_NAND_DENALI_DT=y
 CONFIG_MTD_SPI_NOR=y
 CONFIG_BLK_DEV_LOOP=y
 CONFIG_BLK_DEV_NBD=m
-- 
2.7.4
