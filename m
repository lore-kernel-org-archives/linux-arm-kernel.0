From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue,  2 Feb 2016 16:23:03 +0100
Subject: [PATCH 2/3] ARM: shmobile: enable XHCI_RCAR in defconfig
In-Reply-To: <cover.1454409855.git.horms+renesas@verge.net.au>
References: <cover.1454409855.git.horms+renesas@verge.net.au>
Message-ID: <ae6b99bc6928d13856172f287ee21be2eac39673.1454409855.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/configs/shmobile_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/configs/shmobile_defconfig b/arch/arm/configs/shmobile_defconfig
index 5208b5caacd1..b7b714c3958c 100644
--- a/arch/arm/configs/shmobile_defconfig
+++ b/arch/arm/configs/shmobile_defconfig
@@ -162,6 +162,8 @@ CONFIG_SND_SOC_RSRC_CARD=y
 CONFIG_SND_SOC_AK4642=y
 CONFIG_SND_SOC_WM8978=y
 CONFIG_USB=y
+CONFIG_USB_XHCI_HCD=y
+CONFIG_USB_XHCI_RCAR=y
 CONFIG_USB_EHCI_HCD=y
 CONFIG_USB_OHCI_HCD=y
 CONFIG_USB_R8A66597_HCD=y
-- 
2.7.0.rc3.207.g0ac5344
