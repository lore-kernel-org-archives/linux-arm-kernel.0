From: balbi@ti.com (Felipe Balbi)
Date: Fri, 18 Sep 2015 09:27:16 -0500
Subject: [PATCH linux-next] usb: gadget: atmel_usba_udc: add ep
 capabilities support on device tree binding
In-Reply-To: <55FC1E0F.4070807@atmel.com>
References: <1441657171-15362-1-git-send-email-sylvain.rochet@finsecur.com>
 <55FC1E0F.4070807@atmel.com>
Message-ID: <20150918142716.GB3126@saruman.tx.rr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 18, 2015 at 04:22:07PM +0200, Nicolas Ferre wrote:
> Le 07/09/2015 22:19, Sylvain Rochet a ?crit :
> > The recently added endpoint capabilities flags verification breaks Atmel
> > USBA because the endpoint configuration was only added when the driver
> > is bound using the legacy pdata interface.
> > 
> > Convert endpoint configuration to new capabilities model when driver is
> > bound to a device tree as well.
> > 
> > Signed-off-by: Sylvain Rochet <sylvain.rochet@finsecur.com>
> 
> Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>
> 
> With this additional tag:
> Fixes: 47bef3865115 ("usb: gadget: atmel_usba_udc: add ep capabilities support")
> 
> Felipe, Greg,
> 
> It is considered as a fix for 4.3. Can you please queue it for the "4.3-rc" phase?

sure thing, just, please, resend with linux-usb in Cc :-)

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150918/3995791a/attachment.sig>
