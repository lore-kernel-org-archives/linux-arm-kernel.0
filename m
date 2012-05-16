From: balbi@ti.com (Felipe Balbi)
Date: Wed, 16 May 2012 11:37:23 +0300
Subject: [PATCH] usb: gadget: at91_udc: fix endpoint descriptor dereference
In-Reply-To: <1337156587-7379-1-git-send-email-nicolas.ferre@atmel.com>
References: <1337156587-7379-1-git-send-email-nicolas.ferre@atmel.com>
Message-ID: <20120516083722.GH17359@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 16, 2012 at 10:23:07AM +0200, Nicolas Ferre wrote:
> The patch 5a6506f (Update at91_udc to use usb_endpoint_descriptor inside the
> struct usb_ep) removes the desc field of struct at91_ep. This convertion had
> not been completed which leads to a compilation error.
> 
> Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
> Cc: Felipe Balbi <balbi@ti.com>

Acked-by: Felipe Balbi <balbi@ti.com>

Greg this should be applied to avoid compile breakages on your usb-next
branch. Sorry for that.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120516/974163df/attachment-0001.sig>
