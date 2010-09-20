From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Mon, 20 Sep 2010 14:55:30 +0200
Subject: [PATCH v2] ARM: S5PC110: Samsung Goni board update
Message-ID: <1284987337-15365-1-git-send-email-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This patch series updates the devices supported by Samsung Goni board.
The patch series has been prepared against latest kgene/for-next kernel
tree.

This is a second version of this patch series. It has been updated to
fix the issues reported by Kukjin Kim and Mark Brown.

The complete list of patches:

[PATCHv2 1/7] ARM: S5PC110: update framebuffer setup information for Goni
[PATCHv2 2/7] ARM: S5PC110: fb setup for Goni - remove pixel clock
[PATCHv2 3/7] ARM: S5PC110: add support for S6E63M0 LCD controller on Goni board
[PATCHv2 4/7] ARM: S5PC110: Add si470x radio device to the GONI board
[PATCHv2 5/7] ARM: S5PV210: Enable USB HSOTG gadget build
[PATCHv2 6/7] ARM: S5PC110: add support for otg usb gadget on Goni board
[PATCHv2 7/7] ARM: S5PC110: add support for MMC regulators on Goni board

Best regards
-- 
Marek Szyprowski
Samsung Poland R&D Center
