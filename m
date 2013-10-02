From: balbi@ti.com (Felipe Balbi)
Date: Wed, 2 Oct 2013 08:11:14 -0500
Subject: [PATCH v7 09/10] usb: dwc3: omap: manage "usb_otg_ss_refclk960m"
 clock
In-Reply-To: <52403E02.4070208@ti.com>
References: <1379508542-22389-1-git-send-email-rogerq@ti.com>
 <1379508542-22389-10-git-send-email-rogerq@ti.com>
 <52403E02.4070208@ti.com>
Message-ID: <20131002131113.GM1476@radagast>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 23, 2013 at 04:11:30PM +0300, Roger Quadros wrote:
> Hi Felipe,
> 
> On 09/18/2013 03:49 PM, Roger Quadros wrote:
> > "usb_otg_ss_refclk960m" is an optional functional clock to the
> > UBS_OTG_SS module. So manage it in the driver.
> > 
> 
> Just realized that "usb_otg_ss_refclk960m" is in fact functional clock to the 
> PHY and not USB_OTG_SS module. The name is misleading.
> 
> So please ignore patch 9 and 10.

ignored. All others are fine, right ?

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131002/531ab78c/attachment.sig>
