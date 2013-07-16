From: balbi@ti.com (Felipe Balbi)
Date: Tue, 16 Jul 2013 23:03:53 +0300
Subject: [PATCH] ARM: omap2: fix musb usage for n8x0
In-Reply-To: <1374000777-5626-1-git-send-email-zonque@gmail.com>
References: <1374000777-5626-1-git-send-email-zonque@gmail.com>
Message-ID: <20130716200353.GC31293@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 16, 2013 at 08:52:57PM +0200, Daniel Mack wrote:
> Commit b7e2e75a8c ("usb: gadget: drop unused USB_GADGET_MUSB_HDRC")
> dropped a config symbol that was unused by the musb core, but it turns
> out that board support code had references to it.
> 
> As the core now has a fall-back to host-only mode if support for
> dual-role is not compiled in, so we can just pass MUSB_OTG as
> mode from board files.
> 
> Signed-off-by: Daniel Mack <zonque@gmail.com>
> Reported-and-tested-by: Aaro Koskinen <aaro.koskinen@iki.fi>

Acked-by: Felipe Balbi <balbi@ti.com>

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130716/dbae9985/attachment.sig>
