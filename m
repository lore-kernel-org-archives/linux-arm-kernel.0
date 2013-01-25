From: balbi@ti.com (Felipe Balbi)
Date: Fri, 25 Jan 2013 12:27:00 +0200
Subject: [PATCH v4 4/4] drivers: usb: start using the control module driver
In-Reply-To: <1359109440-2195-5-git-send-email-kishon@ti.com>
References: <1359109440-2195-1-git-send-email-kishon@ti.com>
 <1359109440-2195-5-git-send-email-kishon@ti.com>
Message-ID: <20130125102700.GO15886@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Jan 25, 2013 at 03:54:00PM +0530, Kishon Vijay Abraham I wrote:
> Start using the control module driver for powering on the PHY and for
> writing to the mailbox instead of writing to the control module
> registers on their own.
> 
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>  Documentation/devicetree/bindings/usb/omap-usb.txt |    4 ++
>  Documentation/devicetree/bindings/usb/usb-phy.txt  |    7 +-
>  arch/arm/mach-omap2/omap_hwmod_44xx_data.c         |   13 ----

I'm taking this patch but I'm leaving out the omap_hwmod_44xx_data.c
change just to kill dependency. Can you send that single change as a
separate patch which Tony can queue ?

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130125/f9714c65/attachment.sig>
