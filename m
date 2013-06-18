From: balbi@ti.com (Felipe Balbi)
Date: Tue, 18 Jun 2013 12:42:23 +0300
Subject: [PATCH v7 3/9] usb: phy: twl4030: use the new generic PHY
 framework
In-Reply-To: <1371113039-5784-4-git-send-email-kishon@ti.com>
References: <1371113039-5784-1-git-send-email-kishon@ti.com>
 <1371113039-5784-4-git-send-email-kishon@ti.com>
Message-ID: <20130618094223.GR5461@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 13, 2013 at 02:13:53PM +0530, Kishon Vijay Abraham I wrote:
> Used the generic PHY framework API to create the PHY. For powering on
> and powering off the PHY, power_on and power_off ops are used. Once the
> MUSB OMAP glue is adapted to the new framework, the suspend and resume
> ops of usb phy library will be removed.
> 
> However using the old usb phy library cannot be completely removed
> because otg is intertwined with phy and moving to the new
> framework completely will break otg. Once we have a separate otg state machine,
> we can get rid of the usb phy library.
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130618/d92c21b5/attachment.sig>
