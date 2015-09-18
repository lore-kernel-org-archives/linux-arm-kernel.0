From: balbi@ti.com (Felipe Balbi)
Date: Fri, 18 Sep 2015 09:59:49 -0500
Subject: [PATCH] usb: gadget: atmel_usba_udc: add ep capabilities support
 on device tree binding
In-Reply-To: <1442588308-10201-1-git-send-email-nicolas.ferre@atmel.com>
References: <20150918142716.GB3126@saruman.tx.rr.com>
 <1442588308-10201-1-git-send-email-nicolas.ferre@atmel.com>
Message-ID: <20150918145949.GC3126@saruman.tx.rr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 18, 2015 at 04:58:28PM +0200, Nicolas Ferre wrote:
> From: Sylvain Rochet <sylvain.rochet@finsecur.com>
> 
> The recently added endpoint capabilities flags verification breaks Atmel
> USBA because the endpoint configuration was only added when the driver
> is bound using the legacy pdata interface.
> 
> Convert endpoint configuration to new capabilities model when driver is
> bound to a device tree as well.
> 
> Signed-off-by: Sylvain Rochet <sylvain.rochet@finsecur.com>
> Fixes: 47bef3865115 ("usb: gadget: atmel_usba_udc: add ep capabilities support")
> Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
> ---
> Felipe,
> 
> As you've just requested, here is the same patch sent to linux-usb ml. I had
> added the "Fixes" and my SoB tags.
> 
> For the record:
> It is considered as a fix for 4.3. Can you please queue it for the "4.3-rc"
> phase?

thanks, I'll take it for -rc3 (already sent my -rc2 pull request).

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150918/4f03736c/attachment-0001.sig>
