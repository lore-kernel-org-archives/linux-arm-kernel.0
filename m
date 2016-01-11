From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 11 Jan 2016 12:59:59 +0900
Subject: [PATCH 1/2] ARM: shmobile: enable XHCI_RCAR in defconfig
In-Reply-To: <1452484800-7470-1-git-send-email-horms+renesas@verge.net.au>
References: <1452484800-7470-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1452484800-7470-2-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/configs/shmobile_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/configs/shmobile_defconfig b/arch/arm/configs/shmobile_defconfig
index 969738324a5d..6582b88e3067 100644
--- a/arch/arm/configs/shmobile_defconfig
+++ b/arch/arm/configs/shmobile_defconfig
@@ -163,6 +163,8 @@ CONFIG_SND_SOC_RSRC_CARD=y
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
