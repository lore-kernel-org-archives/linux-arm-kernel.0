From: greg@kroah.com (Greg KH)
Date: Sat, 12 Mar 2011 17:05:10 -0800
Subject: [RFC PATCH 1/5] OMAP2+: Panda introduce async platform data
	definition
In-Reply-To: <20110312225039.27728.24017.stgit@otae.warmcat.com>
References: <20110312224440.27728.60593.stgit@otae.warmcat.com>
	<20110312225039.27728.24017.stgit@otae.warmcat.com>
Message-ID: <20110313010510.GC20396@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Mar 12, 2011 at 10:50:39PM +0000, Andy Green wrote:
> This is part of an RFC patch series introducing asynchronous platform
> data, which may be attached to discovered bus devices at probe time
> based on the device path.
> 
> As part of the series, platform_data is enabled in usbnet layer.
> 
> This patch defines the usbnet platform data, allowing the panda board
> definition file to assert the naming of the usbnet network interface
> should be eth%d instead of usb%d.

Why is this?  If you want to do this, it should be done in userspace
today, no need to involve the kernel in this type of thing.

So I don't see the point of this patch.

thanks,

greg k-h
