From: stern@rowland.harvard.edu (Alan Stern)
Date: Thu, 1 Dec 2016 10:20:50 -0500 (EST)
Subject: [PATCH v2] USB: OHCI: ohci-s3c2410: remove useless functions
In-Reply-To: <1480603590-23924-1-git-send-email-csmanjuvijay@gmail.com>
Message-ID: <Pine.LNX.4.44L0.1612011017270.2334-100000@iolanthe.rowland.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 1 Dec 2016 csmanjuvijay at gmail.com wrote:

> From: Manjunath Goudar <csmanjuvijay@gmail.com>
> 
> The ohci_hcd_s3c2410_drv_probe and ohci_hcd_s3c2410_drv_remove
> functions are removed as these are useless functions except calling
> usb_hcd_s3c2410_probe and usb_hcd_s3c2410_remove functions.
> 
> The usb_hcd_s3c2410_probe function renamed to ohci_hcd_s3c2410_drv_probe
> and usb_hcd_s3c2410_remove function renamed to ohci_hcd_s3c2410_drv_remove
> for proper naming.
> 
> Signed-off-by: Manjunath Goudar <csmanjuvijay@gmail.com>
> Cc: Kukjin Kim <kgene@kernel.org>
> Cc: Krzysztof Kozlowski <krzk@kernel.org>
> Cc: Javier Martinez Canillas <javier@osg.samsung.com>
> Cc: Alan Stern <stern@rowland.harvard.edu>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: linux-samsung-soc at vger.kernel.org
> Cc: linux-usb at vger.kernel.org
> Cc: linux-kernel at vger.kernel.org
> 
> ---
> Changelog v1 -> v2:
> Removed checkpatch.pl warnings and errors cleanup code which is not related
> to this patch.

Acked-by: Alan Stern <stern@rowland.harvard.edu>
