From: tony@atomide.com (Tony Lindgren)
Date: Mon, 19 Jan 2015 10:15:56 -0800
Subject: [PATCH 1/3] ARM: omap2plus_defconfig: Enable support for davinci_emac
In-Reply-To: <1421691358-14661-1-git-send-email-tony@atomide.com>
References: <1421691358-14661-1-git-send-email-tony@atomide.com>
Message-ID: <1421691358-14661-2-git-send-email-tony@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We have this on at least 3517-evm and dm8168-evm. Let's
enable davinci_emac so those can be booted with NFSroot.

Cc: Brian Hutchinson <b.hutchman@gmail.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/configs/omap2plus_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap2plus_defconfig
index b5ccb36..d6f84f2 100644
--- a/arch/arm/configs/omap2plus_defconfig
+++ b/arch/arm/configs/omap2plus_defconfig
@@ -145,6 +145,7 @@ CONFIG_KS8851_MLL=y
 CONFIG_SMC91X=y
 CONFIG_SMSC911X=y
 # CONFIG_NET_VENDOR_STMICRO is not set
+CONFIG_TI_DAVINCI_EMAC=y
 CONFIG_TI_CPSW=y
 # CONFIG_NET_VENDOR_VIA is not set
 # CONFIG_NET_VENDOR_WIZNET is not set
-- 
2.1.4
