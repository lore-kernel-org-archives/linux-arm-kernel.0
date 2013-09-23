From: balbi@ti.com (Felipe Balbi)
Date: Mon, 23 Sep 2013 14:43:25 -0500
Subject: [PATCH v6 7/8] ARM: dts: omap4: update omap-control-usb nodes
In-Reply-To: <1377529713-19762-8-git-send-email-rogerq@ti.com>
References: <1377529713-19762-1-git-send-email-rogerq@ti.com>
 <1377529713-19762-8-git-send-email-rogerq@ti.com>
Message-ID: <20130923194325.GD309@radagast>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Aug 26, 2013 at 06:08:32PM +0300, Roger Quadros wrote:
> Split otghs_ctrl and USB2 PHY power down into separate
> omap-control-usb nodes. Get rid of "ti,type" property.
> 
> Also get rid of "ti,has-mailbox" property from usb_otg_hs
> node and provide the ctrl-module phandle.
> 
> CC: Benoit Cousson <bcousson@baylibre.com>
> Signed-off-by: Roger Quadros <rogerq@ti.com>

Benoit ? Any comments here ?

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130923/1915f373/attachment.sig>
