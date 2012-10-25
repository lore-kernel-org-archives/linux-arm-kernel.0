From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Thu, 25 Oct 2012 18:11:51 +0530
Subject: [PATCH v2 1/7] i2c: omap: no need to access platform_device
In-Reply-To: <1351167915-15079-2-git-send-email-balbi@ti.com>
References: <1350899218-13624-1-git-send-email-balbi@ti.com>
 <1351167915-15079-1-git-send-email-balbi@ti.com>
 <1351167915-15079-2-git-send-email-balbi@ti.com>
Message-ID: <5089338F.4030509@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 25 October 2012 05:55 PM, Felipe Balbi wrote:
> PM callbacks pass our device pointer as argument
> and we don't need to access the platform_device
> just to dereference that down to dev->drvdata.
>
> instead, just use dev_get_drvdata() directly.
>
> Signed-off-by: Felipe Balbi <balbi@ti.com>
> ---
Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
