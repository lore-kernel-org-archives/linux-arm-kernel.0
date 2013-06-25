From: balbi@ti.com (Felipe Balbi)
Date: Tue, 25 Jun 2013 18:18:34 +0300
Subject: [PATCH v8 2/8] usb: phy: omap-usb2: use the new generic PHY
 framework
In-Reply-To: <1372139926-3719-3-git-send-email-kishon@ti.com>
References: <1372139926-3719-1-git-send-email-kishon@ti.com>
 <1372139926-3719-3-git-send-email-kishon@ti.com>
Message-ID: <20130625151834.GG21334@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 25, 2013 at 11:28:40AM +0530, Kishon Vijay Abraham I wrote:
> Used the generic PHY framework API to create the PHY. Now the power off and
> power on are done in omap_usb_power_off and omap_usb_power_on respectively.
> 
> However using the old USB PHY library cannot be completely removed
> because OTG is intertwined with PHY and moving to the new framework
> will break OTG. Once we have a separate OTG state machine, we
> can get rid of the USB PHY library.
> 
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> Reviewed-by: Sylwester Nawrocki <s.nawrocki@samsung.com>

Acked-by: Felipe Balbi <balbi@ti.com>

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130625/b91d82b3/attachment.sig>
