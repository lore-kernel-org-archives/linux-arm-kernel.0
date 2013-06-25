From: balbi@ti.com (Felipe Balbi)
Date: Tue, 25 Jun 2013 18:21:05 +0300
Subject: [PATCH v8 8/8] usb: phy: twl4030-usb: remove *set_suspend* and
 *phy_init* ops
In-Reply-To: <1372139926-3719-9-git-send-email-kishon@ti.com>
References: <1372139926-3719-1-git-send-email-kishon@ti.com>
 <1372139926-3719-9-git-send-email-kishon@ti.com>
Message-ID: <20130625152105.GM21334@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 25, 2013 at 11:28:46AM +0530, Kishon Vijay Abraham I wrote:
> Now that twl4030-usb is adapted to the new generic PHY framework,
> *set_suspend* and *phy_init* ops can be removed from twl4030-usb driver.
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130625/61f539ef/attachment.sig>
