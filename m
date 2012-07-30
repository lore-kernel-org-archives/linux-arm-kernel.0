From: shubhrajyoti@ti.com (Shubhrajyoti)
Date: Mon, 30 Jul 2012 15:07:54 +0530
Subject: [PATCH v6 01/11] drivers: usb: otg: add a new driver for omap
 usb2 phy
In-Reply-To: <1343639400-28725-2-git-send-email-kishon@ti.com>
References: <1343639400-28725-1-git-send-email-kishon@ti.com>
 <1343639400-28725-2-git-send-email-kishon@ti.com>
Message-ID: <501655F2.7070900@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 30 July 2012 02:39 PM, Kishon Vijay Abraham I wrote:
> +			writel(~PHY_PD, phy->control_dev);
> +			/* XXX: add proper documentation for this delay */
> +			mdelay(200);
Do you need this to be busy?
