From: ben-linux@fluff.org (Ben Dooks)
Date: Thu, 21 Oct 2010 23:37:56 +0100
Subject: [PATCH 0/4] USB: gadget: Add Samsung S3C24xx USB HS controller
	driver
In-Reply-To: <1286928627-22824-1-git-send-email-sbkim73@samsung.com>
References: <1286928627-22824-1-git-send-email-sbkim73@samsung.com>
Message-ID: <4CC0C0C4.8050308@fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13/10/10 01:10, Sangbeom Kim wrote:
> The Samsung's S3C2416, S3C2443 and S3C2450 includes a USB High-Speed
> device controller module. This driver enables support for USB high-speed
> gadget functionality for the Samsung S3C24xx SoC's that include this
> controller.
> 
> The patch series contains:
> [PATCH 1/4] ARM: S3C2416: Add USB Phy register definitions
> [PATCH 2/4] ARM: S3C24XX: Add plaform device definition for USB High-Speed gadget controller.
> [PATCH 3/4] USB: Gadget: Add Samsung S3C24XX USB High-Speed controller driver
> [PATCH 4/4] ARM: S3C2416: Add support for USB 2.0 High-Speed gadget controller

patch 3/4 needs a bit of work, otherwise looks ok.

I'll look at applying the s3c24xx items in the next day or so.

-- 
Ben
