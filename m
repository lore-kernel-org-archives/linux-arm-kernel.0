From: balbi@ti.com (Felipe Balbi)
Date: Thu, 23 May 2013 21:47:15 +0300
Subject: [PATCH 1/7] USB: gadget: atmel_usba: move global struct usba_ep
 usba_ep to struct usba_udc
In-Reply-To: <1369067160-3230-1-git-send-email-plagnioj@jcrosoft.com>
References: <20130520162149.GC9937@game.jcrosoft.org>
 <1369067160-3230-1-git-send-email-plagnioj@jcrosoft.com>
Message-ID: <20130523184715.GE19834@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 20, 2013 at 06:25:54PM +0200, Jean-Christophe PLAGNIOL-VILLARD wrote:
> so we can have multiple usb gadget instance
> 
> Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
> Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
> Cc: linux-usb at vger.kernel.org

Acked-by: Felipe Balbi <balbi@ti.com>

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130523/ae696055/attachment.sig>
