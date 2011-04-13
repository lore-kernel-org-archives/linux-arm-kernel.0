From: greg@kroah.com (Greg KH)
Date: Wed, 13 Apr 2011 16:28:41 -0700
Subject: [PATCH RESEND v3 3/4] USB: Gadget: Add Samsung S3C24XX USB
	High-Speed controller driver
In-Reply-To: <201103232239.28879.heiko@sntech.de>
References: <201103232235.49318.heiko@sntech.de>
	<201103232239.28879.heiko@sntech.de>
Message-ID: <20110413232841.GA20142@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 23, 2011 at 10:39:28PM +0100, Heiko St?bner wrote:
> From: Thomas Abraham <thomas.ab@samsung.com>
> 
> The Samsung's S3C2416, S3C2443 and S3C2450 includes a USB High-Speed
> device controller module. This driver enables support for USB high-speed
> gadget functionality for the Samsung S3C24xx SoC's that include this
> controller.
> 
> Signed-off-by: Thomas Abraham <thomas.ab@samsung.com>
> Signed-off-by: Sangbeom Kim <sbkim73@samsung.com>
> Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
> ---
> Changes since v1:
> - Addressed comments from Ben Dooks
> 
> Changes since v2:
> - Update the driver to match the data structure changes introduced by
>   commit b0fca50f5a94a268ed02cfddf44448051ed9343f.
>   Alexander Neumann <alexander@debian.org>
> - Move s3c_hsudc to 0x29 in usb_gadget_controller_number in gadget_chips.h
>   Heiko Stuebner <heiko@sntech.de>

The Renesas driver got number 0x29, so this patch no longer applies :(

Care to respin this whole series against the next linux-next tree and
resend it to me so I can apply it?

thanks,

greg k-h
