From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed, 27 Apr 2016 14:08:25 +1000
Subject: [PATCH] arm64: defconfig: Add Renesas R-Car USB 3.0 driver support
In-Reply-To: <cover.1461722984.git.horms+renesas@verge.net.au>
References: <cover.1461722984.git.horms+renesas@verge.net.au>
Message-ID: <a03bd5735dfa87a5db585e162eda00794690c534.1461722984.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm64/configs/defconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index f70505186820..c3cdd640bea3 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -189,7 +189,7 @@ CONFIG_SND_SOC_AK4613=y
 CONFIG_USB=y
 CONFIG_USB_OTG=y
 CONFIG_USB_XHCI_HCD=y
-CONFIG_USB_XHCI_PLATFORM=y
+CONFIG_USB_XHCI_RCAR=y
 CONFIG_USB_EHCI_HCD=y
 CONFIG_USB_EHCI_MSM=y
 CONFIG_USB_EHCI_HCD_PLATFORM=y
-- 
2.7.0.rc3.207.g0ac5344
