From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Mon, 30 Jan 2017 10:55:46 +0900
Subject: [RESEND PATCH 1/2] arm64: defconfig: enable CONFIG_MTD_BLOCK
In-Reply-To: <1485741347-17363-1-git-send-email-yamada.masahiro@socionext.com>
References: <1485741347-17363-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <1485741347-17363-2-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable the block layer support for MTD devices.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 33b744d..f1f0caf 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -143,6 +143,7 @@ CONFIG_DEVTMPFS=y
 CONFIG_DEVTMPFS_MOUNT=y
 CONFIG_DMA_CMA=y
 CONFIG_MTD=y
+CONFIG_MTD_BLOCK=y
 CONFIG_MTD_M25P80=y
 CONFIG_MTD_SPI_NOR=y
 CONFIG_BLK_DEV_LOOP=y
-- 
2.7.4
