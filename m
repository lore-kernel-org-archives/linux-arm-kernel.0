From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 31 Jan 2013 10:50:48 +0900
Subject: [PATCH 1/4] ARM: mach-shmobile: marzen: defconfig: use regulators by
 default
In-Reply-To: <1359597051-32700-1-git-send-email-horms+renesas@verge.net.au>
References: <1359597051-32700-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1359597051-32700-2-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use regulators by default

This is in preparation for initialising devices using DT.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/configs/marzen_defconfig |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/configs/marzen_defconfig b/arch/arm/configs/marzen_defconfig
index 728a43c..afee4a2 100644
--- a/arch/arm/configs/marzen_defconfig
+++ b/arch/arm/configs/marzen_defconfig
@@ -83,6 +83,8 @@ CONFIG_USB=y
 CONFIG_USB_RCAR_PHY=y
 CONFIG_MMC=y
 CONFIG_MMC_SDHI=y
+CONFIG_REGULATOR=y
+CONFIG_REGULATOR_DUMMY=y
 CONFIG_USB=y
 CONFIG_USB_EHCI_HCD=y
 CONFIG_USB_OHCI_HCD=y
-- 
1.7.10.4
