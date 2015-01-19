From: sjoerd.simons@collabora.co.uk (Sjoerd Simons)
Date: Mon, 19 Jan 2015 21:57:26 +0100
Subject: [PATCH] ARM: omap2plus_defconfig:  Enable OHCI & EHCI HCD support
Message-ID: <1421701046-17367-1-git-send-email-sjoerd.simons@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable CONFIG_USB_EHCI_HCD and CONFIG_USB_OHCI_HCD to get USB supports
with omap2plus_defconfig.

Signed-off-by: Sjoerd Simons <sjoerd.simons@collabora.co.uk>
---
 arch/arm/configs/omap2plus_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap2plus_defconfig
index c2c3a85..295af70 100644
--- a/arch/arm/configs/omap2plus_defconfig
+++ b/arch/arm/configs/omap2plus_defconfig
@@ -159,6 +159,8 @@ CONFIG_USB_NET_SMSC95XX=y
 CONFIG_USB_ALI_M5632=y
 CONFIG_USB_AN2720=y
 CONFIG_USB_EPSON2888=y
+CONFIG_USB_EHCI_HCD=y
+CONFIG_USB_OHCI_HCD=y
 CONFIG_USB_KC2190=y
 CONFIG_LIBERTAS=m
 CONFIG_LIBERTAS_USB=m
-- 
2.1.4
