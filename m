From: mporter@ti.com (Matt Porter)
Date: Thu,  9 Feb 2012 15:16:25 -0500
Subject: [PATCH 1/2] omap: enable davinci_emac in omap2plus_defconfig for
In-Reply-To: <1328818586-7104-1-git-send-email-mporter@ti.com>
References: <1328818586-7104-1-git-send-email-mporter@ti.com>
Message-ID: <1328818586-7104-2-git-send-email-mporter@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable built-in Ethernet support in the defconfig for all
am35xx parts.

Signed-off-by: Matt Porter <mporter@ti.com>
---
 arch/arm/configs/omap2plus_defconfig |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap2plus_defconfig
index d5f00d7..8d49617 100644
--- a/arch/arm/configs/omap2plus_defconfig
+++ b/arch/arm/configs/omap2plus_defconfig
@@ -91,6 +91,7 @@ CONFIG_SMSC_PHY=y
 CONFIG_NET_ETHERNET=y
 CONFIG_SMC91X=y
 CONFIG_SMSC911X=y
+CONFIG_TI_DAVINCI_EMAC=y
 CONFIG_KS8851=y
 CONFIG_KS8851_MLL=y
 CONFIG_LIBERTAS=m
-- 
1.7.5.4
