From: balbi@ti.com (Felipe Balbi)
Date: Tue, 18 Jun 2013 12:47:26 +0300
Subject: [PATCH v7 8/9] usb: phy: omap-usb2: remove *set_suspend*
 callback from omap-usb2
In-Reply-To: <1371113039-5784-9-git-send-email-kishon@ti.com>
References: <1371113039-5784-1-git-send-email-kishon@ti.com>
 <1371113039-5784-9-git-send-email-kishon@ti.com>
Message-ID: <20130618094726.GW5461@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 13, 2013 at 02:13:58PM +0530, Kishon Vijay Abraham I wrote:
> Now that omap-usb2 is adapted to the new generic PHY framework,
> *set_suspend* ops can be removed from omap-usb2 driver.
> 
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>

Reviewed-by: Felipe Balbi <balbi@ti.com>

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130618/80a91e77/attachment-0001.sig>
