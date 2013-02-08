From: balbi@ti.com (Felipe Balbi)
Date: Fri, 8 Feb 2013 09:42:29 +0200
Subject: [PATCH 02/10] USB: EHCI: make ehci-omap a separate driver
In-Reply-To: <5113e5db.c84e420a.08c3.ffffbe6b@mx.google.com>
References: <yes> <1360258447-27247-1-git-send-email-yes>
 <5113e5db.c84e420a.08c3.ffffbe6b@mx.google.com>
Message-ID: <20130208074229.GA21879@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

HI,

On Thu, Feb 07, 2013 at 11:03:59PM +0530, manjunath.goudar at linaro.org wrote:
> From: Manjunath Goudar <manjunath.goudar@linaro.org>
> 
> Separate the OMAP host controller driver from ehci-hcd host code
> into its own driver module.
> 
> Signed-off-by: Manjunath Goudar <manjunath.goudar@linaro.org>
> Signed-off-by: Arnd Bergmann <arnd@linaro.org>
> Cc: Felipe Balbi <balbi@ti.com>
> Cc: Greg KH <greg@kroah.com>
> Cc: Alan Stern <stern@rowland.harvard.edu>
> Cc: linux-usb at vger.kernel.org
> Cc: Tony Lindgren <tony@atomide.com>

Alan and Roger have already been working on this for ehci-omap. Their
patches might already be in Greg's queue...

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130208/736d8670/attachment.sig>
