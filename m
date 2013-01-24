From: chao.xie@marvell.com (Chao Xie)
Date: Thu, 24 Jan 2013 01:38:29 -0500
Subject: [V5 PATCH 05/26] usb: host: ehci-mv: remove unused variable
In-Reply-To: <1359009530-28182-1-git-send-email-chao.xie@marvell.com>
References: <1359009530-28182-1-git-send-email-chao.xie@marvell.com>
Message-ID: <1359009530-28182-6-git-send-email-chao.xie@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Chao Xie <chao.xie@marvell.com>
Acked-by: Alan Stern <stern@rowland.harvard.edu>
---
 drivers/usb/host/ehci-mv.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/drivers/usb/host/ehci-mv.c b/drivers/usb/host/ehci-mv.c
index 6c56297..3065809 100644
--- a/drivers/usb/host/ehci-mv.c
+++ b/drivers/usb/host/ehci-mv.c
@@ -302,7 +302,6 @@ static int mv_ehci_remove(struct platform_device *pdev)
 {
 	struct ehci_hcd_mv *ehci_mv = platform_get_drvdata(pdev);
 	struct usb_hcd *hcd = ehci_mv->hcd;
-	int clk_i;
 
 	if (hcd->rh_registered)
 		usb_remove_hcd(hcd);
-- 
1.7.4.1
