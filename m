From: sbkim73@samsung.com (Sangbeom Kim)
Date: Wed, 13 Oct 2010 09:10:23 +0900
Subject: [PATCH 0/4] USB: gadget: Add Samsung S3C24xx USB HS controller driver
Message-ID: <1286928627-22824-1-git-send-email-sbkim73@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Samsung's S3C2416, S3C2443 and S3C2450 includes a USB High-Speed
device controller module. This driver enables support for USB high-speed
gadget functionality for the Samsung S3C24xx SoC's that include this
controller.

The patch series contains:
[PATCH 1/4] ARM: S3C2416: Add USB Phy register definitions
[PATCH 2/4] ARM: S3C24XX: Add plaform device definition for USB High-Speed gadget controller.
[PATCH 3/4] USB: Gadget: Add Samsung S3C24XX USB High-Speed controller driver
[PATCH 4/4] ARM: S3C2416: Add support for USB 2.0 High-Speed gadget controller
