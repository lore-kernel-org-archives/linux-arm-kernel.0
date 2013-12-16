From: balbi@ti.com (Felipe Balbi)
Date: Mon, 16 Dec 2013 15:29:18 -0600
Subject: [PATCH v3 0/2] usb: fix controller-PHY binding for OMAP3 platform
In-Reply-To: <1387209225-11520-1-git-send-email-kishon@ti.com>
References: <1387209225-11520-1-git-send-email-kishon@ti.com>
Message-ID: <20131216212918.GH12896@saruman.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Dec 16, 2013 at 09:23:43PM +0530, Kishon Vijay Abraham I wrote:
> After the platform devices are created using PLATFORM_DEVID_AUTO, the
> device names given in usb_bind_phy (in board file) does not match with
> the actual device name causing the USB PHY library not to return the
> PHY reference when the MUSB controller request for the PHY in the non-dt boot
> case.
> So removed creating platform devices using PLATFORM_DEVID_AUTO in omap2430.c.
> 
> Did enumeration testing in omap3 beagle.
> 
> Changes from v2:
> * Fixed the commit log
> 
> Changes from v1:
> * refreshed to the latested mainline kernel
> * added musb_put_id from omap2430 remove.

Tony, how do you want to handle this ? You want me to provide you a
branch which we both merge ?

cheers

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131216/13634c31/attachment-0001.sig>
