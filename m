From: biju.das@bp.renesas.com (Biju Das)
Date: Mon, 13 Aug 2018 08:41:33 +0100
Subject: [PATCH] arm64: defconfig: enable R8A774A1 SoC
In-Reply-To: <1534146093-1651-1-git-send-email-biju.das@bp.renesas.com>
References: <1534146093-1651-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1534146093-1651-2-git-send-email-biju.das@bp.renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable the Renesas RZ/G2M (R8A774A1) SoC in the ARM64 defconfig.

Signed-off-by: Biju Das <biju.das@bp.renesas.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 4327f62..1c953ff 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -49,6 +49,7 @@ CONFIG_ARCH_ROCKCHIP=y
 CONFIG_ARCH_SEATTLE=y
 CONFIG_ARCH_SYNQUACER=y
 CONFIG_ARCH_RENESAS=y
+CONFIG_ARCH_R8A774A1=y
 CONFIG_ARCH_R8A7795=y
 CONFIG_ARCH_R8A7796=y
 CONFIG_ARCH_R8A77965=y
-- 
2.7.4
