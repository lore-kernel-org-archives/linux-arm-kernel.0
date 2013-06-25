From: balbi@ti.com (Felipe Balbi)
Date: Tue, 25 Jun 2013 18:20:44 +0300
Subject: [PATCH v8 7/8] usb: phy: omap-usb2: remove *set_suspend*
 callback from omap-usb2
In-Reply-To: <1372139926-3719-8-git-send-email-kishon@ti.com>
References: <1372139926-3719-1-git-send-email-kishon@ti.com>
 <1372139926-3719-8-git-send-email-kishon@ti.com>
Message-ID: <20130625152044.GL21334@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 25, 2013 at 11:28:45AM +0530, Kishon Vijay Abraham I wrote:
> Now that omap-usb2 is adapted to the new generic PHY framework,
> *set_suspend* ops can be removed from omap-usb2 driver.
> 
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> Reviewed-by: Felipe Balbi <balbi@ti.com>

Acked-by: Felipe Balbi <balbi@ti.com>

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130625/e6036b5f/attachment.sig>
