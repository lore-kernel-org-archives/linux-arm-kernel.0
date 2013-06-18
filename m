From: balbi@ti.com (Felipe Balbi)
Date: Tue, 18 Jun 2013 12:47:36 +0300
Subject: [PATCH v7 9/9] usb: phy: twl4030-usb: remove *set_suspend* and
 *phy_init* ops
In-Reply-To: <1371113039-5784-10-git-send-email-kishon@ti.com>
References: <1371113039-5784-1-git-send-email-kishon@ti.com>
 <1371113039-5784-10-git-send-email-kishon@ti.com>
Message-ID: <20130618094736.GX5461@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 13, 2013 at 02:13:59PM +0530, Kishon Vijay Abraham I wrote:
> Now that twl4030-usb is adapted to the new generic PHY framework,
> *set_suspend* and *phy_init* ops can be removed from twl4030-usb driver.
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130618/8e23d22f/attachment-0001.sig>
