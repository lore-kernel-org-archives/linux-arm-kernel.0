From: xiechao.mail@gmail.com (Chao Xie)
Date: Sun, 25 Nov 2012 23:43:20 -0500
Subject: [PATCH 07/27] usb: host: ehci-mv: remove unused variable
In-Reply-To: <1353905020-29372-1-git-send-email-xiechao.mail@gmail.com>
References: <1353905020-29372-1-git-send-email-xiechao.mail@gmail.com>
Message-ID: <1353905020-29372-8-git-send-email-xiechao.mail@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Chao Xie <chao.xie@marvell.com>

Signed-off-by: Chao Xie <xiechao.mail@gmail.com>
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
